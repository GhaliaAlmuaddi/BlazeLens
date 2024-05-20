//
//  exploreCard.swift
//  CloudKidGameCenterTest
//
//  Created by shomokh aldosari on 10/11/1445 AH.
//

import SwiftUI
import CloudKit
import GameKit
struct exploreCard: View {
    @StateObject var viewModel = postViewModel()
    @State var highestVotedPost : postModel
    @State var challenge : ChallengeModel
    @State private var userName: String?
    @State private var fetchedPlayerName: String?
    let container = CKContainer(identifier: "iCloud.l.CloudKidGameCenterTest")
    var body: some View {
       
                        ZStack {
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(width: 291, height: 396)
//                            if let challengeId = challenge.challengId {
//                                            NavigationLink(destination: ExploerView2(challengeId: challengeId)) {
//                                                if let asset = highestVotedPost.photo, let data = try? Data(contentsOf: asset.fileURL!) {
//                                                    Image(uiImage: UIImage(data: data)!)
//                                                        .resizable()
//                                                        .frame(width: 291, height: 369)
//                                                        .cornerRadius(24)
//                                                } else {
//                                                    Text("Failed to load photo")
//                                                }
//                                            }
//                                        } else {
//                                            Text("Invalid challenge ID")
//                                        }
                            NavigationLink(destination: ExploerView2(challengeId: challenge.id)) {
                                if let asset = highestVotedPost.photo, let data = try? Data(contentsOf: asset.fileURL!) {
                                    Image(uiImage: UIImage(data: data)!)
                                        .resizable()
                                        .frame(width: 291, height: 369)
                                        .cornerRadius(24)
                                } else {
                                    Text("Failed to load photo")
                                }
                            }
                            VStack(alignment: .center, spacing: 7) {
                                Text("\(challenge.challengeName)")
                                    .font(Font.custom("SF Pro", size: 24).weight(.bold))
                                    .foregroundColor(Color(red: 0.05, green: 0.23, blue: 0.61))
 
                                Text("\(highestVotedPost.playerName)")
                                    .font(Font.custom("SF Pro", size: 20).weight(.bold))
                                    .foregroundColor(Color(red: 0.49, green: 0.49, blue: 0.49))
                             
                               
                            }
                            .frame(width: 344, height: 94)
                            .background(Color(red: 0.95, green: 0.95, blue: 0.94))
                            .offset(x: 2.50, y: 151)
                            .frame(width: 291, height: 396)
                            .cornerRadius(24)
                            .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.12), radius: 5, y: 4)
                            
                        }
                        .onAppear {
  
                            
                               }
    }
    
    
    func retrievePlayerName(for userId: String) {
           let predicate = NSPredicate(format: "playerID == %@", userId)
           let query = CKQuery(recordType: "Player", predicate: predicate)
     
           container.publicCloudDatabase.perform(query, inZoneWith: nil) { results, error in
               if let error = error {
                   print("Error querying CloudKit: \(error.localizedDescription)")
                   return
               }
               
               if let results = results, let record = results.first, let playerName = record["playerName"] as? String {
                   DispatchQueue.main.async {
                       self.fetchedPlayerName = playerName
                   }
               } else {
                   DispatchQueue.main.async {
                       self.fetchedPlayerName = "Unknown Player"
                   }
               }
           }
        
       }
    
    

    
    func fetchUserNameFromGameCenter(userID: String, completion: @escaping (String?) -> Void) {
   //     let publicDatabase = CKContainer(identifier: "iCloud.l.CloudKidGameCenterTest")
        let container = CKContainer.default()
        let publicDatabase = container.publicCloudDatabase
        
        // Define a predicate to search for records with the given user ID
        let predicate = NSPredicate(format: "userID == %@", userID)
        
        // Define a query to fetch user records
        let query = CKQuery(recordType: "Player", predicate: predicate)
        
        // Perform the query
        publicDatabase.perform(query, inZoneWith: nil) { (records, error) in
            guard error == nil else {
                print("Error fetching user records: \(error!.localizedDescription)")
                completion(nil)
                return
            }
            
            // Check if any records were fetched
            guard let records = records, !records.isEmpty else {
                print("No user found with ID \(userID)")
                completion(nil)
                return
            }
            
            // Assuming there's only one user per ID, return the first record's name
            if let userName = records.first?["playerName"] as? String {
                completion(userName)
            } else {
                print("No name found for user with ID \(userID)")
                completion(nil)
            }
        }
    }
 

}

