//
//  postViewModel.swift
//  CloudKidGameCenterTest
//
//  Created by shomokh aldosari on 22/10/1445 AH.
//

import Foundation

import CloudKit

class ViewModel: ObservableObject{
    
    @Published var posts : [postModel] = []
    let container = CKContainer(identifier: "iCloud.l.CloudKidGameCenterTest")
    
    func fetchposts() {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "challengePost", predicate: predicate)
        
        let operation = CKQueryOperation(query: query)
        operation.recordMatchedBlock = { recordId, result in
            DispatchQueue.main.async {
                switch result {
                case .success(let record):
                    var post = postModel(record: record)
                    self.posts.append(post)
                case .failure(let error):
                    print("\(error.localizedDescription)")
                }
            }
        }
        
        CKContainer(identifier: "iCloud.l.CloudKidGameCenterTest").publicCloudDatabase.add(operation)
    }
    func cloudKitImageURL(for brandLogo: CKAsset?) -> URL? {
        guard let brandLogo = brandLogo, let fileURL = brandLogo.fileURL else {
            return nil
        }
        return fileURL
    }
    
    
    func updateVote(for post: postModel, newVoteCount: Int) {
        let recordID = CKRecord.ID(recordName: post.id.recordName)
        container.publicCloudDatabase.fetch(withRecordID: recordID) { record, error in
            guard let record = record, error == nil else {
                print("Error fetching record: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            // Update the vote counter in the record
            record["voting_Counter"] = newVoteCount
            
            // Save the updated record
            self.container.publicCloudDatabase.save(record) { savedRecord, saveError in
                if let saveError = saveError {
                    print("Error saving record: \(saveError.localizedDescription)")
                } else {
                    DispatchQueue.main.async {
                        // Optionally, update the vote counter locally
                        // post.voting_Counter = newVoteCount
                        print("Vote count updated successfully")
                    }
                }
            }
        }
    }
}