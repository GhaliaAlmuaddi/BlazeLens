//
//  ContentView.swift
//  CloudKidGameCenterTest
//
//  Created by Ghalia Mohammed Al Muaddi on 19/10/1445 AH.
//

import SwiftUI
import GameKit
import CloudKit


struct GameCenterLoginButton: View {
    //@State private var ProfilePhoto: UIImage?
    @State private var playerID: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Button(action: {
                    authenticateWithGameCenter()
                }) {
                    Text("Game Center login")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                
                NavigationLink(destination: AddingPointsView()) {
                    Text("PointsPage")
                }
                
//                NavigationLink(destination: ChallengeView( challenge: <#ChallengeModel#>)) {
//                    Text("Challange Page")
//                }
                
                NavigationLink(destination: ExploreView()) {
                    Text("Explore page")
                }
                NavigationLink(destination: userProfile()) {
                    Text("Profile")
                }
            }
        }}
    
    func authenticateWithGameCenter() {
        GKLocalPlayer.local.authenticateHandler = { viewController, error in
            if let viewController = viewController {
                // Present the Game Center login view controller to the player
                UIApplication.shared.windows.first?.rootViewController?.present(viewController, animated: true, completion: nil)
            } else if let error = error {
                // Handle authentication error
                print("Game Center authentication failed with error: \(error.localizedDescription)")
            } else {
                // Local player is authenticated, you can now access Game Center features
                print("Local player authenticated")
                
                // Save Game Center player ID to CloudKit
                savePlayerIDToCloudKit()
            }
        }
    }
    

    func savePlayerIDToCloudKit() {
        let player = GKLocalPlayer.local
        let playerID = player.playerID ?? ""
        let playerName = player.displayName
        
        // Load the player's photo
        player.loadPhoto(for: .normal) { (photo, error) in
            if let error = error {
                print("Error loading player photo: \(error.localizedDescription)")
            } else if let photo = photo {
                // Convert the UIImage to a CKAsset
                if let photoAsset = self.photoToCKAsset(image: photo) {
                    // Create a CKRecord and save the player's data
                    let recordID = CKRecord.ID(recordName: UUID().uuidString)
                    let record = CKRecord(recordType: "Player", recordID: recordID)
                    record["playerID"] = playerID
                    record["playerName"] = playerName
                    record["playerPhoto"] = photoAsset
                    
                    let container = CKContainer(identifier: "iCloud.l.CloudKidGameCenterTest")
                    container.publicCloudDatabase.save(record) { (record, error) in
                        if let error = error {
                            print("Error saving player data: \(error.localizedDescription)")
                            
                          
                        } else {
                            print("Player data saved successfully")
                            
                            NavigationLink(destination: AddingPointsView()) {
                                Text("PointsView")
                            }
                        }
                        //                else {
                        //                    print("Error converting UIImage to CKAsset")
                        //                }
                    }
                }
            }}}
        
        // Function to convert UIImage to CKAsset
        func photoToCKAsset(image: UIImage) -> CKAsset? {
            if let imageData = image.jpegData(compressionQuality: 0.8) {
                let tempDirectoryURL = URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true)
                let fileURL = tempDirectoryURL.appendingPathComponent(UUID().uuidString + ".jpg")
                do {
                    try imageData.write(to: fileURL)
                    return CKAsset(fileURL: fileURL)
                } catch {
                    print("Error writing image data to temporary file: \(error.localizedDescription)")
                    return nil
                }
            }
            return nil
        }
        
        
    }
    
 
    struct ContentView: View {
        var body: some View {
            VStack {
                
                GameCenterLoginButton()
            }
        }
    }
    
    #Preview {
        ContentView()
    }

