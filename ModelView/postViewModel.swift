//
//  postViewModel.swift
//  CloudKidGameCenterTest
//
//  Created by shomokh aldosari on 22/10/1445 AH.
//

import Foundation

import CloudKit

class postViewModel: ObservableObject{
    
    @Published var posts : [postModel] = []
    let container = CKContainer(identifier: "iCloud.l.CloudKidGameCenterTest")
    @Published var showImageViewer = false
    @Published var selectedImagesID: String = ""
    @Published var selectedPost: postModel?
    @Published var selectedPostID: URL?
    
    init() {
        fetchposts()
    }
    
    func highestVotedPost(posts: [postModel]) -> postModel? {
        guard !posts.isEmpty else {
            return nil
        }
        
        var highestVotedPost: postModel? = nil
        var highestVoteCount = 0
        
        for post in posts {
            if post.voting_Counter > highestVoteCount {
                highestVotedPost = post
                highestVoteCount = post.voting_Counter
            }
        }
        
        return highestVotedPost
    }
    
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
    
    

//    func createPostRecord(PostRecord: postModel, completion: @escaping (Error?) -> Void)->CKRecord {
//        let record = CKRecord(recordType: "challengePost")
//        
//        //CKRecord.Reference(recordID: userId!, action: .none)
//        record["voting_Counter"] = PostRecord.voting_Counter
//        record["photo"] = PostRecord.photo
//        // record["user_id"] = CKRecord.Reference(recordID: userId!, action: .none)
//        record["user_id"] = PostRecord.user_id as CKRecordValue
//         
//         // Set the challengeId as a CKRecord.Reference to the ChallengeRecord
//         let challengeRecordID = PostRecord.challengeId
//         let challengeRecordReference = CKRecord.Reference(recordID: challengeRecordID!, action: .none)
//         record["challengeId"] = challengeRecordReference
//        
//        //Set image
//     
//        
//        CKContainer(identifier: "iCloud.l.CloudKidGameCenterTest").publicCloudDatabase.save(record) { (savedRecord, error) in
//            completion(error)
//        }
//        
//        return record
//    }
    
    
    
    
    
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
    
    
    func getPost(for post: postModel, completion: @escaping (Int?) -> Void) {
        // Fetch the CKRecord for the post
        let recordID = CKRecord.ID(recordName: post.id.recordName)
        container.publicCloudDatabase.fetch(withRecordID: recordID) { record, error in
            guard let record = record, error == nil else {
                print("Error fetching record: \(error?.localizedDescription ?? "Unknown error")")
                completion(nil)
                return
            }
            
            // Extract the vote counter from the record
            if let voteCounter = record["voting_Counter"] as? Int {
                completion(voteCounter)
            } else {
                // If the vote counter is not found or cannot be cast to Int, return nil
                completion(nil)
            }
        }
    }
    

}
