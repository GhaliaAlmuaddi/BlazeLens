//
//  AddingPointsView.swift
//  CloudKidGameCenterTest
//
//  Created by Ghalia Mohammed Al Muaddi on 20/10/1445 AH.
//

import SwiftUI
import GameKit

struct AddingPointsView: View {
    //  @State var Points : Int
    @State private var localScore: Int = 0
    @State private var gameCenterScore: Int = 0
    @State private var isGameCenterAuthenticated = false
    var body: some View {
        VStack{
        Button(action: {
            
            //Points = Points+1
            submitScoreToLeaderboard()
            // Change the score to the actual score
        }) {
            Text("Add point")
                .padding()
                .foregroundColor(.white)
                .background(Color.green)
                .cornerRadius(10)
        }
        
        Button ( action: {
            DisplayLeaderBoard ()
            
        }, label: {
            Text("Check the leaderboard")
        })
    }.onAppear {
     //   authenticateWithGameCenter()
        loadGameCenterScore()
    }
}
    
    
//    func authenticateWithGameCenter() {
//          GKLocalPlayer.local.authenticateHandler = { viewController, error in
//              if let viewController = viewController {
//                  UIApplication.shared.windows.first?.rootViewController?.present(viewController, animated: true, completion: nil)
//              } else if let error = error {
//                  print("Game Center authentication failed with error: \(error.localizedDescription)")
//              } else {
//                  print("Local player authenticated")
//                  isGameCenterAuthenticated = true
//              }
//          }
//      }
    
    
    
    func submitScoreToLeaderboard() {
//          guard isGameCenterAuthenticated else {
//              print("Cannot submit score to Game Center. User not authenticated.")
//              return
//          }
        print("game center Score \(gameCenterScore) ")
          let newScore = gameCenterScore + 1 // Calculate the new score to submit
          
          let scoreReporter = GKScore(leaderboardIdentifier: "055001") // Replace with your leaderboard ID
          scoreReporter.value = Int64(newScore)
          
          GKScore.report([scoreReporter]) { (error) in
              if let error = error {
                  print("Failed to report score: \(error.localizedDescription)")
              } else {
                  print("Score \(newScore) submitted to Game Center")
                  gameCenterScore = newScore // Update the local Game Center score
              }
          }
      }
    
    
    func loadGameCenterScore() {
        //        guard isGameCenterAuthenticated else {
        //            print("Cannot load Game Center score. User not authenticated.")
        //            return
        //        }
        
        let leaderboardID = "055001" // My leaderboard ID
        let scoreRequest = GKLeaderboard(players: [GKLocalPlayer.local])
        scoreRequest.identifier = leaderboardID
        
        scoreRequest.loadScores { (scores, error) in
            if let error = error {
                print("Failed to load Game Center scores: \(error.localizedDescription)")
            } else if let score = scoreRequest.localPlayerScore {
                gameCenterScore = Int(score.value)
                print("Game Center score loaded: \(gameCenterScore)")
            }
            else {
                print("Game Center score loaded: \(gameCenterScore)") //here
            }
        }
    }
    func DisplayLeaderBoard (){
        let gcViewController = GKGameCenterViewController()
        gcViewController.leaderboardIdentifier = "055001"
        gcViewController.viewState = .leaderboards
        // Present the view controller
        UIApplication.shared.windows.first?.rootViewController?.present(gcViewController, animated: true, completion: nil)

    }
}

#Preview {
    AddingPointsView( )
}
