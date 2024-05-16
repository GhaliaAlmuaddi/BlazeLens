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
//            NavigationLink(destination: ChallengeView(challenge: challenge,  playerID: playerID, challengeId: challenge.id)){
//                VStack{
//                    ZStack {
//                        RoundedRectangle(cornerRadius: 30)
//                            .frame(width: 80, height: 32)
//                            .foregroundColor(Color.blue)
//
//                        Text(buttonText)
//                            .font(Font.custom("SF Pro", size: 16).weight(.bold))
//                            .lineSpacing(25.60)
//                            .foregroundColor(.white)
//                            .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
//                            .frame(width: 80, height: 32)
//                            .background(
//                                LinearGradient(gradient: Gradient(colors: [Color(red: 0.05, green: 0.23, blue: 0.61), Color(red: 0.24, green: 0.50, blue: 0.85)]), startPoint: .top, endPoint: .bottom)
//                            )
//                            .cornerRadius(24)
//                    }
//                }
//            }
            
            NavigationLink(destination: votePage( challengeId: challenge.id, challenge: challenge)) {
                
                
               // print("Pressed")
                // Optionally, set selectedChallenge here
                // selectedChallenge = challenge
             
                VStack{
                    ZStack {
                        RoundedRectangle(cornerRadius: 30)
                            .frame(width: 80, height: 32)
                            .foregroundColor(Color.blue)

                        Text("Vote")
                            .font(Font.custom("SF Pro", size: 16).weight(.bold))
                            .lineSpacing(25.60)
                            .foregroundColor(.white)
                            .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                            .frame(width: 80, height: 32)
                            .background(
                                LinearGradient(gradient: Gradient(colors: [Color(red: 0.05, green: 0.23, blue: 0.61), Color(red: 0.24, green: 0.50, blue: 0.85)]), startPoint: .top, endPoint: .bottom)
                            )
                            .cornerRadius(24)
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
