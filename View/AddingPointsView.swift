//
////
////  AddingPointsView.swift
////  CloudKidGameCenterTest
////
////  Created by Ghalia Mohammed Al Muaddi on 20/10/1445 AH.
////
//
////import SwiftUI
////import GameKit
//import SwiftUI
//import GameKit
//
//struct AddingPointsView: View {
//    @State private var gameCenterScore: Int = 0
//    @State private var isGameCenterAuthenticated = false
//    @State private var currentPlayerID: String?
//    
//    @StateObject var viewModel = postViewModel()
//    @State private var totalVoting: Int = 0
//    
//    var body: some View {
//        VStack {
//            Button(action: {
//                // Call calculateTotalVotingCount to get the total voting count for the current user
//                calculateTotalVotingCount()
//                
//            })
//            {
//                Text("Add Point")
//                    .padding()
//                    .foregroundColor(.white)
//                    .background(Color.green)
//                    .cornerRadius(10)
//            }
//            
//            Button(action: {
//                displayLeaderboard()
//            }) {
//                Text("Check Leaderboard")
//            }
//        }
//        .onAppear {
//            authenticateWithGameCenter()
//         //   viewModel.fetchposts()
//        }
//    }
//    
//    func calculateTotalVotingCount() {
//        guard let currentPlayerID = currentPlayerID else {
//            print("Current player ID is nil.")
//            return
//        }
//        
//        // Filter posts for the current user using the player ID
//        let currentUserPosts = viewModel.posts.filter { $0.user_id == currentPlayerID }
//        
//        // Calculate total voting count for the user's posts
//        totalVoting = currentUserPosts.reduce(0) { $0 + $1.voting_Counter }
//        
//        // Update the Game Center score with the new voting count
//        print(totalVoting)
//        updateGameCenterScore(score: totalVoting)
//    }
//
//    
//   func authenticateWithGameCenter() {
//        GKLocalPlayer.local.authenticateHandler = { viewController, error in
//            if let viewController = viewController {
//                UIApplication.shared.windows.first?.rootViewController?.present(viewController, animated: true, completion: nil)
//            } else if let error = error {
//                print("Game Center authentication failed with error: \(error.localizedDescription)")
//            } else {
//                print("Local player authenticated")
//                isGameCenterAuthenticated = true
//                currentPlayerID = GKLocalPlayer.local.playerID // Set currentPlayerID upon successful authentication
//             //   calculateTotalVotingCount() // Calculate the total voting count once the player ID is set
//            }
//        }
//    }
//
//    
//    func updateGameCenterScore(score: Int) {
//        guard isGameCenterAuthenticated else {
//            print("Cannot submit score to Game Center. User not authenticated.")
//            return
//        }
//        
//        let scoreReporter = GKScore(leaderboardIdentifier: "055001")
//        scoreReporter.value = Int64(score)
//        
//        GKScore.report([scoreReporter]) { error in
//            if let error = error {
//                print("Failed to report score to Game Center: \(error.localizedDescription)")
//            } else {
//                print("Score \(score) submitted to Game Center")
//                gameCenterScore = score // Update local gameCenterScore state
//            }
//        }
//    }
//
//    func loadGameCenterScore() {
//        guard isGameCenterAuthenticated else {
//            print("Cannot load Game Center score. User not authenticated.")
//            return
//        }
//        
//        let leaderboardID = "055001"
//        let scoreRequest = GKLeaderboard(players: [GKLocalPlayer.local])
//        scoreRequest.identifier = leaderboardID
//        
//        scoreRequest.loadScores { scores, error in
//            if let error = error {
//                print("Failed to load Game Center scores: \(error.localizedDescription)")
//            } else if let score = scoreRequest.localPlayerScore {
//                gameCenterScore = Int(score.value)
//                print("Game Center score loaded: \(gameCenterScore)")
//            }
//        }
//    }
//    
//    
//    
//    func displayLeaderboard() {
//        loadGameCenterScore()
//        let gcViewController = GKGameCenterViewController()
//        gcViewController.leaderboardIdentifier = "055001"
//        gcViewController.viewState = .leaderboards
//        UIApplication.shared.windows.first?.rootViewController?.present(gcViewController, animated: true, completion: nil)
//    }
//}
//
//struct AddingPointsView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddingPointsView()
//    }
//}
