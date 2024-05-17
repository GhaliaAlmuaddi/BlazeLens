//
//  ExploreView.swift
//  CloudKidGameCenterTest
//
//  Created by Ghalia Mohammed Al Muaddi on 26/10/1445 AH.
//


import SwiftUI
import CloudKit
import GameKit
struct ExploreView: View {
    
    @StateObject var ChallengeVM = ChallengeViewModel()
    @StateObject var viewModel = postViewModel()
    @State private var gameCenterScore: Int = 0
    @State private var isGameCenterAuthenticated = false

    @State private var currentPlayerID: String?
    
    @State private var totalVoting: Int = 0
    
    
   // @State var x : String
    @State var buttonText: String = ""
    
    @State var ButtonAppear : Bool = false
    
    @State var selectedChallenge: ChallengeModel?
    
    @State var ChallangeFinieshed  : Bool = false

    //@State private var playerID: String = ""
    @State private var profileImage: UIImage?
    @EnvironmentObject var voteData: postViewModel
    
    var body: some View {
        
          NavigationStack {
        
              ZStack {
                  Color(.backgroungC)
                      .ignoresSafeArea()
                      .toolbar {
                          ToolbarItem(placement: .principal) {
                              VStack {
                                  Text("Explore")
                                      .bold()
                              }
                          }
                          ToolbarItemGroup(placement: .primaryAction) {
                              NavigationLink {
                                  userProfile()
                              } label: {
                                  if let profileImage = profileImage {
                                      Image(uiImage: profileImage)
                                          .resizable()
                                          .scaledToFit()
                                          .frame(width: 30, height: 30)
                                          .clipShape(Circle())
                                  } else {
                                      // Placeholder image or loading indicator
                                      Text("Loading profile image...")
                                  }
                                  
                              }
                          }
                          ToolbarItem(placement: .navigationBarLeading) {
                              Button(action: {
                                  calculateTotalVotingCount()
                                  displayLeaderboard()
                              }) {
                                  Image("winner")
                                      .resizable()
                                      .padding(.leading, 5.0)
                                      .frame(width: 45, height: 35)
                                      .foregroundColor(Color(red: 1, green: 0.55, blue: 0.26))
                              }
                          }
                      }
                  
                      .ignoresSafeArea()
                  
                  
                  
                  VStack {
                      Text("")
                      let currentDate = Date()
                      Text("Today's challenge :").padding(.trailing, 200)
                      ZStack {
                          RoundedRectangle(cornerRadius: 30)
                              .frame(width: 291, height: 138)
                              .foregroundStyle(Color(red: 0.95, green: 0.98, blue: 0.98))
                          
                          VStack {
                              ForEach(ChallengeVM.Challenges.indices, id: \.self) { index in
                                  let challenge = ChallengeVM.Challenges[index]
                                  
                                  if challenge.ChallengeStartDate < currentDate && currentDate < challenge.VotingEndDate {
                                      ChallengeRow(challenge: challenge, currentDate: currentDate)
                                  } else if currentDate >= challenge.VotingEndDate {
                                      // Check if there is a next challenge
                                      if index + 1 < ChallengeVM.Challenges.count {
                                          let nextChallenge = ChallengeVM.Challenges[index + 1]
                                          
                                          // Check if currentDate is between the current challenge's VotingEndDate and the start date of the next challenge
                                          if currentDate >= challenge.VotingEndDate && currentDate
                                                < nextChallenge.ChallengeStartDate {
                                              Text("Time out wait for next")
                                          }
                                      }
                                      //                                else {
                                      //                                    // If this is the last challenge and currentDate is past its VotingEndDate
                                      //                                    Text("Time out , no more challange")
                                      //                                }
                                  }
                                  
                              }
                              
                              
                              //                        ForEach(ChallengeVM.Challenges.indices, id: \.self) { index in
                              //                            let challenge = ChallengeVM.Challenges[index]
                              //
                              //                            let high = viewModel.posts.filter { $0.challengeId?.recordID == challenge.id }
                              //                            if let highestVotedPost = viewModel.highestVotedPost(posts: high) {
                              //                                Text("Highest voted photo: \(highestVotedPost.voting_Counter)")
                              //                            } else {
                              //                                Text("No posts found for this challenge")
                              //                            }
                              //                        }
                              
                              
                              
                              
                          }
                      }
                      
                      
                      VStack{
                          Text("Explore past challenges: ")
                              .font(Font.custom("SF Pro", size: 16).weight(.bold))
                              .foregroundColor(.black)
                              .multilineTextAlignment(.leading)
                              .padding(.trailing, 200)
                              .padding()
                          ScrollView(.horizontal) {
                              HStack(spacing: 8) {
                                  
                                  HStack(spacing: 8) {
                                      ZStack() {
                                          Rectangle()
                                              .foregroundColor(.clear)
                                              .frame(width: 291, height: 396)
                                              .offset(x: 0, y: -0)
                                          VStack(alignment: .leading, spacing: 7) {
                                              
                                              VStack(spacing: 0) {
                                                  Text("Coffee cup")
                                                      .font(Font.custom("SF Pro", size: 24).weight(.bold))
                                                      .foregroundColor(Color(red: 0.05, green: 0.23, blue: 0.61))
                                                  ZStack() {
                                                      
                                                      Text("Winner: gh_12")
                                                          .font(Font.custom("SF Pro", size: 20).weight(.bold))
                                                          .foregroundColor(Color(red: 0.49, green: 0.49, blue: 0.49))
                                                          .offset(x: 0, y: -0.70)
                                                      Rectangle()
                                                          .foregroundColor(.clear)
                                                          .frame(width: 32.18, height: 21.32)
                                                          .offset(x: 33.61, y: 0.17)
                                                  }
                                                  .frame(width: 216.50, height: 21.66)
                                              }
                                              .frame(width: 344, height: 94)
                                              .background(Color(red: 0.95, green: 0.95, blue: 0.94))
                                          }
                                          .background(
                                            NavigationLink(destination: ExploerView2()) {
                                                Image("coffee1")
                                                
                                            }
                                            
                                            
                                          )
                                          .offset(x: 2.50, y: 151)
                                      }
                                      .frame(width: 291, height: 396)
                                      .background(Image(systemName: "doc"))
                                      
                                      .cornerRadius(24)
                                      .shadow(
                                        color: Color(red: 0, green: 0, blue: 0, opacity: 0.12), radius: 5, y: 4
                                      )
                                      
                                      
                                      VStack(spacing: 0) {
                                          VStack(alignment: .leading, spacing: 7) {
                                              VStack(spacing: 0) {
                                                  
                                                  Text("Sunset")
                                                      .font(Font.custom("SF Pro", size: 24).weight(.bold))
                                                      .foregroundColor(Color(red: 0.05, green: 0.23, blue: 0.61))
                                                  Text("Winner: ra-n33")
                                                      .font(Font.custom("SF Pro", size: 20))
                                                      .foregroundColor(.black)
                                              }
                                              .frame(width: 344, height: 94)
                                              .background(Color(red: 0.95, green: 0.95, blue: 0.94))
                                          }
                                          .frame(width: 297, height: 94)
                                      }
                                      .padding(EdgeInsets(top: 255, leading: 0, bottom: 0, trailing: 28))
                                      .frame(width: 296, height: 349)
                                      .background(
                                        Image("sun")
                                            .resizable()
                                            .frame(width:291, height: 396)
                                      )
                                      .cornerRadius(24)
                                      .shadow(
                                        color: Color(red: 0, green: 0, blue: 0, opacity: 0.25), radius: 4, y: 4
                                      )
                                      
                                      VStack(spacing: 0) {
                                          VStack(alignment: .leading, spacing: 7) {
                                              VStack(spacing: 0) {
                                                  Text("Nature")
                                                      .font(Font.custom("SF Pro", size: 24).weight(.bold))
                                                      .foregroundColor(Color(red: 0.05, green: 0.23, blue: 0.61))
                                                  Text("Winner: kh12")
                                                      .font(Font.custom("SF Pro", size: 20))
                                                      .foregroundColor(.black)
                                              }
                                              .frame(width: 344, height: 94)
                                              .background(Color(red: 0.95, green: 0.95, blue: 0.94))
                                          }
                                          .frame(width: 297, height: 94)
                                      }
                                      .padding(EdgeInsets(top: 255, leading: 0, bottom: 0, trailing: 28))
                                      .frame(width: 296, height: 349)
                                      .background(
                                        Image("flower")
                                            .resizable()
                                            .frame(width:291, height: 396)
                                      )
                                      .cornerRadius(24)
                                      .shadow(
                                        color: Color(red: 0, green: 0, blue: 0, opacity: 0.25), radius: 4, y: 4
                                      )
                                  }
                                  //  .offset(x: 302.50, y: 155)
                              }
                          }
                          //.offset(x: 0, y: 155)
                      }
                  }
                  }}.onAppear {
                      // Fetch challenges only if not already fetched
                      if ChallengeVM.Challenges.isEmpty {
                          ChallengeVM.fetchChallenges()
                      }
                      
                      loadProfilePhoto()
                      authenticateWithGameCenter()
        }.navigationBarBackButtonHidden(true)
    }
   
    
    func loadGameCenterScore() {
        guard isGameCenterAuthenticated else {
            print("Cannot load Game Center score. User not authenticated.")
            return
        }
        
        let leaderboardID = "055001"
        let scoreRequest = GKLeaderboard(players: [GKLocalPlayer.local])
        scoreRequest.identifier = leaderboardID
        
        scoreRequest.loadScores { scores, error in
            if let error = error {
                print("Failed to load Game Center scores: \(error.localizedDescription)")
            } else if let score = scoreRequest.localPlayerScore {
                gameCenterScore = Int(score.value)
                print("Game Center score loaded: \(gameCenterScore)")
            }
        }
    }
    func displayLeaderboard() {
        loadGameCenterScore()
           let gcViewController = GKGameCenterViewController()
           gcViewController.leaderboardIdentifier = "055001"
           gcViewController.viewState = .leaderboards
           gcViewController.gameCenterDelegate = makeCoordinator()
           UIApplication.shared.windows.first?.rootViewController?.present(gcViewController, animated: true, completion: nil)
       }
    
    func authenticateWithGameCenter() {
         GKLocalPlayer.local.authenticateHandler = { viewController, error in
             if let viewController = viewController {
                 UIApplication.shared.windows.first?.rootViewController?.present(viewController, animated: true, completion: nil)
             } else if let error = error {
                 print("Game Center authentication failed with error: \(error.localizedDescription)")
             } else {
                 print("Local player authenticated")
                 isGameCenterAuthenticated = true
                 currentPlayerID = GKLocalPlayer.local.playerID // Set currentPlayerID upon successful authentication
              //   calculateTotalVotingCount() // Calculate the total voting count once the player ID is set
             }
         }
     }
    
    func calculateTotalVotingCount() {
        guard let currentPlayerID = currentPlayerID else {
            print("Current player ID is nil.")
            return
        }
        
        // Filter posts for the current user using the player ID
        let currentUserPosts = viewModel.posts.filter { $0.user_id == currentPlayerID }
        
        // Calculate total voting count for the user's posts
        totalVoting = currentUserPosts.reduce(0) { $0 + $1.voting_Counter }
        
        // Update the Game Center score with the new voting count
        print(totalVoting)
        updateGameCenterScore(score: totalVoting)
    }
    
    
    func updateGameCenterScore(score: Int) {
        guard isGameCenterAuthenticated else {
            print("Cannot submit score to Game Center. User not authenticated.")
            return
        }
        
        let scoreReporter = GKScore(leaderboardIdentifier: "055001")
        scoreReporter.value = Int64(score)
        
        GKScore.report([scoreReporter]) { error in
            if let error = error {
                print("Failed to report score to Game Center: \(error.localizedDescription)")
            } else {
                print("Score \(score) submitted to Game Center")
                gameCenterScore = score // Update local gameCenterScore state
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
            
           
        }
    
    // Coordinator for Game Center
     class Coordinator: NSObject, GKGameCenterControllerDelegate {
         func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
             gameCenterViewController.dismiss(animated: true, completion: nil)
         }
     }
     
     // Create the coordinator
     func makeCoordinator() -> Coordinator {
         return Coordinator()
     }
 }
    
    

//let challengePosts = viewModel.posts.filter { $0.challengeId == challenge.challengId }
//
//    if let highestVotedPost = challengePosts.max(by: { $0.voting_Counter < $1.voting_Counter }) {
//        Text("Highest voted photo: \(highestVotedPost.photoURL)")
//    }

struct ChallengeRow: View {
    let challenge: ChallengeModel
    let currentDate: Date
       @State private var isJoinable: Bool = false
       @State private var isVotable: Bool = false
    var A : String = "Challenge time out"
    
       var body: some View {
           VStack {
               if isJoinable {
                   ChallengeItemView(challenge: challenge, buttonText: "Join")
               } else if isVotable {
                   ChallengeItemView(challenge: challenge, buttonText: "Vote")
               } else {
                   Text("Challenge time out")
                       .foregroundColor(.red)
               }
           }.onAppear {
               // Determine joinable and votable states based on current date
               isJoinable = currentDate >= challenge.ChallengeStartDate && currentDate < challenge.ChallengeEndDate
               isVotable = currentDate >= challenge.VotingStartDate && currentDate < challenge.VotingEndDate
           }
           
       }
    
   }
    
    
    struct ChallengeItemView: View {
        let challenge: ChallengeModel
        let buttonText: String
        
        @State private var playerID: String = ""
        var body: some View {
            Text (challenge.challengeName).font(.headline)
            
                // Handle button tap action
            NavigationLink (
                       destination: determineDestination(),
                       label: {
                           VStack{
                               ZStack {
                                   RoundedRectangle(cornerRadius: 30)
                                       .frame(width: 80, height: 32)
                                       .foregroundColor(Color.blue)
                                   
                                   Text(buttonText)
                                       .font(Font.custom("SF Pro", size: 16).weight(.bold))
                                       .lineSpacing(25.60)
                                       .foregroundColor(.white)
                                       .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                                       .frame(width: 80, height: 32)
                                       .background(
                                        LinearGradient(gradient: Gradient(colors: [Color(red: 0.05, green: 0.23, blue: 0.61), Color(red: 0.24, green: 0.50, blue: 0.85)]), startPoint: .top, endPoint: .bottom)
                                       )
                                       .cornerRadius(24)
                               }}}
                    // Function to determine navigation destination based on button text
                       )
                   
                }
            
        func determineDestination() -> some View {
           if buttonText == "Vote" {
               return AnyView(votePage(challengeId: challenge.id, challenge: challenge))
           } else {
               return AnyView(ChallengeView(challenge: challenge, playerID: playerID))
           }
       }

        }
    
    
    func formatDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Riyadh")
        
        return dateFormatter.string(from: date)
    }
    
    
    
    func formatTime(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Riyadh")
        
        return dateFormatter.string(from: date)
    }
      



#Preview {
    NavigationStack{
        ExploreView().environmentObject(ChallengeViewModel())
    }
}
