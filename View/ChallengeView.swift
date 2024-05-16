//
//  DateView.swift
//  CloudKidGameCenterTest
//
//  Created by Ghalia Mohammed Al Muaddi on 21/10/1445 AH.
//

import SwiftUI
import CloudKit
import GameKit

struct ChallengeView: View {
    
    @EnvironmentObject var ChallengeVM : ChallengeViewModel
    @EnvironmentObject var Post : postViewModel
    
    let challenge: ChallengeModel
    
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage?
    let container = CKContainer(identifier: "iCloud.l.CloudKidGameCenterTest")
    @State private var fetchedPlayerID: String?
    
    let playerID: String
    @State var photo: CKAsset?
    @State var vote: Int = 0
    @State var userId:  CKRecord.ID?
    
    @State var challengeId: CKRecord.ID?
    @State private var challengeRecord: CKRecord?
  
    
    var body: some View {
        ZStack {
            VStack {
                
                Text ("\(challenge.challengeName) ").font(
                    Font.custom("SF Pro", size: 24)
                    // .weight(.black)
                )
                .multilineTextAlignment(.center)
                // .foregroundColor(Constants.BlkText)
                .frame(width: 294, height: 50, alignment: .top)
                
                
                
                
                Button(action: {
                    
                    if GKLocalPlayer.local.isAuthenticated {
                        self.showImagePicker = true
                        fetchedPlayerID = GKLocalPlayer.local.playerID
                        savePost()
                        
                    } else {
                        // Present Game Center login view
                        authenticateWithGameCenter()
                    }

                    
                    
                    
                    
                }) {
                    
                    
                    
                    ZStack {
                        
                        Image("Ellipse")
                            .frame(width: 500, height: 140)
                        Image(systemName: "camera").foregroundColor(.white)
                            .font(Font.custom("SF Pro", size: 59))
                        
                            .frame(width: 72.33334, height: 56.59575, alignment: .center).padding()
                        
                        ZStack {
                            
                            Circle().fill(.white).frame(width: 30, height: 30)
                            
                            //    .padding(.bottom , 90 )
                            //                    .padding(.leading ,100)
                            
                            Image(systemName: "plus.circle.fill")
                                .font(Font.custom("SF Pro", size: 40)) .foregroundColor(.orange)
                            //                    .padding(.bottom , 90 )
                            //                    .padding(.leading ,100)
                        }.padding(.leading ,120).padding(.bottom , 100 )
                    }  }
                        //.padding(.bottom , 100 )
                        //  .padding(.leading ,120)

                        Text("Challenge timeline :").foregroundColor(.gray)
                        
                        Text("\(formatTime(challenge.ChallengeStartDate)) -  \(formatTime(challenge.ChallengeEndDate))").bold()
                        
                        Divider().frame(width: 200)
                        
                        Text("Participants Limit :").foregroundColor(.gray)
                        Text("50 Person").bold()
                        
                    }.sheet(isPresented: $showImagePicker, onDismiss: savePost) {
                        ImagePicker(selectedImage: self.$selectedImage, sourceType: .photoLibrary)
            }
            //  }
        }.onAppear {
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
        
//        func createPostRecord()->CKRecord {
//            let record = CKRecord(recordType: "challengePost")
//            //   record["challengeId"] = "A2DACE2A-DEC9-42CF-86F4-289B6C7C46D1"
//            //CKRecord.Reference(recordID: userId!, action: .none)
//            record["voting_Counter"] = vote
//            record["photo"] = photo
//            // record["user_id"] = CKRecord.Reference(recordID: userId!, action: .none)
//            record["user_id"] = fetchedPlayerID
//            record["challengeId"] = CKRecord.Reference(recordID: challengeId, action: .none)
//
//            return record
//        }
    func createPostRecord()->CKRecord{
        let record = CKRecord(recordType: "challengePost")
        record["voting_Counter"] = vote
        record["photo"] = photo
        record["user_id"] = fetchedPlayerID
        
        record["challengeId"] = CKRecord.Reference(recordID: challengeId!, action: .none)
        //Set image
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
                        postRecord["challengePost"] = CKRecord.Reference(recordID: challengepost.recordID, action: .none)
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
        
        
    }

    
    
//    #Preview {
//        NavigationStack{
//            ChallengeView(challenge: <#ChallengeModel#>).environmentObject(ChallengeViewModel())
//        }
//    }
