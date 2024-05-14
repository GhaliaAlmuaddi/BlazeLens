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
   // @State var x : String
    @State var buttonText: String = ""
    
    @State var ButtonAppear : Bool = false
    
    @State var selectedChallenge: ChallengeModel?
    
    @State var ChallangeFinieshed  : Bool = false

    //@State private var playerID: String = ""
    @State private var profileImage: UIImage?
    
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
                            NavigationLink {
                               userProfile()
                            } label: {
                                Image("winner")
                                
                                    .resizable()
                                
                                    .padding(.leading, 5.0)
                                
                                    .frame(width: 45 , height: 35).foregroundColor(Color(red: 1, green: 0.55, blue: 0.26))
                            }
                            
                        }
                        
                    }

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
                                    if currentDate >= challenge.VotingEndDate && currentDate < nextChallenge.ChallengeStartDate {
                                        Text("Time out wait for next")
                                    }
                                } else {
                                    // If this is the last challenge and currentDate is past its VotingEndDate
                                    Text("Time out , no more challange")
                                }
                            }
                            
                        }
                        ForEach(ChallengeVM.Challenges.indices, id: \.self) { index in
                            let challenge = ChallengeVM.Challenges[index]
                            
                            VStack {
                                Text("\(challenge.challengeName)")
                                
                                if let highestVotedPost = viewModel.highestVotedPost(posts: viewModel.posts.filter { $0.challengeId == challenge.challengId }) {
                                    // Display information about the highest voted post for this challenge
                                    Text("The post with the highest vote count is: \(highestVotedPost)")
                                    if let photo = highestVotedPost.photo {
                                        // Display the photo if available
                                        Image(uiImage: UIImage(contentsOfFile: photo.fileURL!.path)!)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 100, height: 100) // Adjust size as needed
                                    } else {
                                        // Handle case where photo is not available
                                        Text("No photo available")
                                    }
                                } else {
                                    // Handle the case where no posts are available for this challenge
                                    Text("No posts available")
                                }
                            }
                        }

                        
                    }
                }
            }.onAppear {
                // Fetch challenges only if not already fetched
                if ChallengeVM.Challenges.isEmpty {
                    ChallengeVM.fetchChallenges()
                }
                
                loadProfilePhoto()
            }
        }
    }.navigationBarBackButtonHidden(true)
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
            NavigationLink(destination: votePage( challengeID: challenge.id, challenge: challenge)) {
                // NavigationLink(destination: ChallengeView(challenge: challenge,  playerID: playerID, challengeId: challenge.id))
                
               // print("Pressed")
                // Optionally, set selectedChallenge here
                // selectedChallenge = challenge
             
                VStack{
                    ZStack {
                        RoundedRectangle(cornerRadius: 30)
                            .frame(width: 80, height: 32)
                            .foregroundColor(Color.blue)

                        Text(buttonText)
                            .foregroundColor(.white)
                            .bold()
                    }
                }}
            .padding()
           // .background(Color.gray.opacity(0.1))
            .cornerRadius(10)
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
