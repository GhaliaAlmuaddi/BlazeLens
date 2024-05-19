//
//  userProfile.swift
//  CloudKidGameCenterTest
//
//  Created by shomokh aldosari on 06/11/1445 AH.
//

import SwiftUI
import GameKit

struct userProfile: View {
    @StateObject var viewModel = postViewModel()
    @State private var isAuth = false
    @State private var fetchedPlayerID: String?
    @State private var profileImage: UIImage?
    @State private var displayName: String = ""
    @State private var playerScore: Int = 0
    @State private var playerRank: Int = 0
    @State private var currentPlayerID: String?
    var body: some View {
        NavigationStack {
            ZStack {
                Color("BackgroundColor").ignoresSafeArea()
                    .toolbar {
                        ToolbarItem(placement: .principal) {
                            Text("Profile")
                                .bold()
                        }
                        ToolbarItem(placement: .primaryAction) {
                            NavigationLink {
                                ExploreView()
                            } label: {
                                Image(systemName: "rectangle.portrait.and.arrow.right")
                                    .resizable()
                                    .padding(.trailing, 5.0)
                                    .frame(width: 30, height: 20)
                                    .foregroundColor(Color(red: 0.05, green: 0.23, blue: 0.61))
                            }
                        }
                        ToolbarItem(placement: .navigationBarLeading) {
                            NavigationLink {
                                ExploreView()
                            } label: {
                                Image(systemName: "arrowshape.backward.fill")
                                    .resizable()
                                    .padding(.leading, 5.0)
                                    .frame(width: 30, height: 20)
                                    .foregroundColor(Color(red: 0.05, green: 0.23, blue: 0.61))
                            }
                        }
                    }
                                VStack(alignment: .center) {
                    if let profileImage = profileImage {
                        Image(uiImage: profileImage)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                    } else {
                        Text("Loading profile image...")
                    }
                    
                    Text(displayName)
                                        .font(.title3)
                                        .foregroundColor(.black)
                    
                    HStack(spacing: 50) {
                        VStack {
                            Text("Rank")
                                .font(Font.custom("SF Pro", size: 13))
                                .foregroundColor(Color(red: 0.49, green: 0.49, blue: 0.49))
                                .offset(x: 0, y: 25)
                            Text("\(playerRank)")
                                .font(Font.custom("Inter", size: 18).weight(.semibold))
                                .foregroundColor(.black)
                                .offset(x: -0.63, y: -7.50)
                        }
                        Divider()
                            .frame(width: 1, height: 30)
                        
                        VStack {
                            Text("Points")
                                .font(Font.custom("SF Pro", size: 13))
                                .foregroundColor(Color(red: 0.49, green: 0.49, blue: 0.49))
                                .offset(x: -0, y: 25)
                            Text("\(playerScore)")
                                .font(Font.custom("Inter", size: 18).weight(.semibold))
                                .foregroundColor(.black)
                                .offset(x: -0, y: -7.50)
                        }
                    }.padding()
                    
                    Text("Activity")
                        .font(Font.custom("SF Pro", size: 24).weight(.bold))
                        .foregroundColor(.black)
                        .offset(x: -120, y: -4)
                    
                    ScrollView {
                      // Text("\(GKLocalPlayer.local.gamePlayerID)")
                        let columns = Array(repeating: GridItem(.flexible(), spacing: 20), count: 3)
                        LazyVGrid(columns: columns, alignment: .center, spacing: 10) {
                            ForEach(viewModel.posts.indices, id: \.self) { index in
                                let post = viewModel.posts[index]
                                if GKLocalPlayer.local.displayName == post.playerName {
                                    
                                    if let fileURL = post.photo?.fileURL,
                                       let imageData = try? Data(contentsOf: fileURL),
                                       let uiImage = UIImage(data: imageData) {
                                        Image(uiImage: uiImage)
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 105, height: 135)
                                            .cornerRadius(12)
                                    } else {
                                        Rectangle()
                                            .fill(Color.gray)
                                            .frame(width: 105, height: 135)
                                            .cornerRadius(12)
                                    }
                                }
                            }
                        }
                        .padding()
                    }
                    .padding()
                }
            
                .environmentObject(viewModel)
            }
                        .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Profile")
                        .bold()
                }
            }
        }
        .onAppear {
            authenticateWithGameCenter()
            viewModel.fetchposts()
            loadProfilePhoto()
            loadGameCenterScore()
            //print(GKLocalPlayer.local.gamePlayerID)
            displayPlayerRank()
        }

        .navigationBarBackButtonHidden(true)
    }
    
    func authenticateWithGameCenter() {
         GKLocalPlayer.local.authenticateHandler = { viewController, error in
             if let viewController = viewController {
                 UIApplication.shared.windows.first?.rootViewController?.present(viewController, animated: true, completion: nil)
             } else if let error = error {
                 print("Game Center authentication failed with error: \(error.localizedDescription)")
             } else {
                 print("Local player authenticated")
                 isAuth = true
                 currentPlayerID = GKLocalPlayer.local.playerID // Set currentPlayerID upon successful authentication
              //   calculateTotalVotingCount() // Calculate the total voting count once the player ID is set
             }
         }
     }
    
    func loadGameCenterScore() {
        let leaderboardID = "055001"

        let leaderboardRequest = GKLeaderboard()
        leaderboardRequest.identifier = leaderboardID
        leaderboardRequest.loadScores { (scores, error) in
            if let error = error {
                print("Error loading scores: \(error.localizedDescription)")
                return
            }

            if let localPlayerScore = leaderboardRequest.localPlayerScore {
                print("Player score: \(localPlayerScore.value)")
                playerScore = Int(localPlayerScore.value)
            } else {
                print("No score found for the local player.")
            }
        }
    }
    
    func loadPlayerRank(for leaderboardID: String, completion: @escaping (Int?, Error?) -> Void) {
        let leaderboard = GKLeaderboard(players: [GKLocalPlayer.local])
        leaderboard.identifier = leaderboardID
        leaderboard.loadScores { scores, error in
            if let error = error {
                completion(nil, error)
            } else if let localPlayerScore = leaderboard.localPlayerScore {
                let playerRank = localPlayerScore.rank
               
                completion(playerRank, nil)
            } else {
                completion(nil, nil) // No scores found
            }
        }
    }
    
    func displayPlayerRank() {
        authenticateWithGameCenter()

        // Replace "your_leaderboard_id" with your actual leaderboard ID
        let leaderboardID = "055001"

        loadPlayerRank(for: leaderboardID) { rank, error in
            if let error = error {
                print("Error loading player rank: \(error.localizedDescription)")
            } else if let rank = rank {
                playerRank = rank
                print("Player rank: \(rank)")
                // Update your UI with the player's rank
            } else {
                print("No rank found for the player")
            }
        }
    }
    
    func loadProfilePhoto() {
        GKLocalPlayer.local.loadPhoto(for: .normal) { (photo, error) in
            if let photo = photo {
                DispatchQueue.main.async {
                    self.profileImage = photo
                }
            }
        }
        self.displayName = GKLocalPlayer.local.displayName
    }
}


#Preview {
    userProfile()
}
