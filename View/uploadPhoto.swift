//
//  uploadPhoto.swift
//  CloudKidGameCenterTest
//
//  Created by shomokh aldosari on 22/10/1445 AH.
//

import SwiftUI
import CloudKit
import GameKit

struct uploadPhoto: View {
    
    @EnvironmentObject var Post : postViewModel
    
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage?
    let container = CKContainer(identifier: "iCloud.l.CloudKidGameCenterTest")
    @State private var fetchedPlayerID: String?
    
    let playerID: String
    @State var photo: CKAsset?
    @State var vote: Int = 0
    @State var userId:  CKRecord.ID?
    let challengeId: CKRecord.ID
    let challenge: ChallengeModel
    
  //  let challengeReference: CKRecord.Reference
    
    var body: some View {
        NavigationView {
        VStack{
            Text("Offer image")
                .font(.title2)
            
            HStack {
                Image(systemName: "photo")
                    .foregroundColor(Color.white)
                
                Button("Photo") {
                                        if GKLocalPlayer.local.isAuthenticated {
                                            showImagePicker = true
                                            fetchedPlayerID = GKLocalPlayer.local.playerID
                                        } else {
                                            // Present Game Center login view
                                            authenticateWithGameCenter()
                                        }
                                    }
            }
            
            
            .frame(width: 140, height: 45)
            .background(.blue)
            .opacity(0.7)
            .cornerRadius(8)
            .foregroundColor(.white)
            
            Button("Submit") {
                
                savePost()
                
            }
            .frame(width: 370, height: 50)
            .foregroundColor(.white)
            .controlSize(.regular)
            .background(Color.blue)
            .cornerRadius(10)
            .padding(.top, 30)
            
            
            NavigationLink(
                destination: votePage(challengeID: challenge.id, challenge: challenge), // Destination view
               
                label: {
                    Text("see photos")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                })
            
//            .sheet(isPresented: $showImagePicker) {
//                ImagePickerRepresentable(selectedImage: $selectedImage)
//            }
        }
    }
        .onAppear {
                   fetchPlayerID()
               }
    }
    
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
                    fetchedPlayerID = GKLocalPlayer.local.playerID
                }
            }
        }
    
    
    
    func fetchPlayerID() {
            let predicate = NSPredicate(format: "playerID == %@", playerID)
            let query = CKQuery(recordType: "Player", predicate: predicate)
            
            let queryOperation = CKQueryOperation(query: query)
            queryOperation.desiredKeys = ["playerID"]
            queryOperation.resultsLimit = 1 // Limit to retrieve only one record
            
            var playerIDs: [String] = []
            
            queryOperation.recordFetchedBlock = { record in
                if let playerID = record["playerID"] as? String {
                    playerIDs.append(playerID)
                }
            }
            
            queryOperation.queryCompletionBlock = { cursor, error in
                DispatchQueue.main.async {
                    if let error = error {
                        print("Error fetching player ID: \(error.localizedDescription)")
                    } else {
                        self.fetchedPlayerID = playerIDs.first
                    }
                }
            }
            
            container.publicCloudDatabase.add(queryOperation)
        }
    
    
    
    func getphotoRecord(completion :@escaping(CKRecord?)->()){
        container.fetchUserRecordID { recordId, error in
            //Get record id
            guard  error == nil, let recordId = recordId else {
                //Show alert
                completion(nil)
                return
            }
            //get the record using record id
            container.publicCloudDatabase.fetch(withRecordID: recordId) { record, error in
                completion(record)
            }
            
        }
    }
    
    func createPostRecord()->CKRecord{
        let record = CKRecord(recordType: "challengePost")
     //   record["challengeId"] = "A2DACE2A-DEC9-42CF-86F4-289B6C7C46D1"
       //CKRecord.Reference(recordID: userId!, action: .none)
        record["voting_Counter"] = vote
        record["photo"] = photo
       // record["user_id"] = CKRecord.Reference(recordID: userId!, action: .none)
        record["user_id"] = fetchedPlayerID
       //record["challenge"] = CKRecord.Reference(recordID: challengeRecordID, action: .deleteSelf)
      //Set image
        
        //record["challengeId"] = "A2DACE2A-DEC9-42CF-86F4-289B6C7C46D1"
//        let challengeRecordReference = CKRecord.Reference(recordID: challengeId, action: .none)
//            record["challengeId"] = challengeRecordReference
        return record
    }
    
     func savePost() {
         
         getphotoRecord { postRecord in
             guard let postRecord = postRecord else {
                 return
             }

             if let selectedImage = selectedImage {
                 if let photoAsset = photoToCKAsset(selectedImage: selectedImage) {
                     // Use brandLogoAsset in your CKRecord
                     let challengepost = createPostRecord()
                     challengepost["photo"] = photoAsset
                     print(photoAsset)
                     //postRecord["Player"] = CKRecord.Reference(recordID: challengepost.recordID, action: .none)
                     //challengepost["user_id"] = fetchedPlayerID
                     container.publicCloudDatabase.modifyRecords(saving: [challengepost, postRecord], deleting: []) { result in
                         switch result {
                         case .success(_):
                             // Show success alert or perform any other actions
                             break
                         case .failure(let error):
                             print("Error: \(error)")
                         }
                     }
                 } else {
                     print("Error converting UIImage to CKAsset")
                 }
             } else {
                 // Handle case when no image is selected
             }
         }
     }

    
    
    
    
    func photoToCKAsset(selectedImage: UIImage?) -> CKAsset? {
        guard let selectedImage = selectedImage,
              let imageData = selectedImage.pngData() else {
            return nil
        }

        guard let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first else {
            return nil
        }

        let fileName = "asset#\(UUID().uuidString)"
        guard let imageFilePath = NSURL(fileURLWithPath: documentDirectory)
                .appendingPathComponent(fileName)
        else {
            return nil
        }

        do {
            try imageData.write(to: imageFilePath)
            return CKAsset(fileURL: imageFilePath)
        } catch {
            print("Error converting UIImage to CKAsset!")
            return nil
        }
    }

}

//#Preview {
//    uploadPhoto()
//}
