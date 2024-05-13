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

   // @State var x : String
    @State var buttonText: String = ""
    
    @State var ButtonAppear : Bool = false
    
    @State var selectedChallenge: ChallengeModel?
    
    @State var ChallangeFinieshed  : Bool = false

    //@State private var playerID: String = ""
    
    var body: some View {
        
      //  NavigationStack {
        
            ZStack {
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
                        }
                }
            }.onAppear {
                // Fetch challenges only if not already fetched
                if ChallengeVM.Challenges.isEmpty {
                    ChallengeVM.fetchChallenges()
                }
            }
       }
    }
}
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
            NavigationLink(destination: ChallengeView(challenge: challenge,  playerID: playerID, challengeId: challenge.id)) {
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
