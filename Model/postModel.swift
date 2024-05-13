//
//  postModel.swift
//  CloudKidGameCenterTest
//
//  Created by shomokh aldosari on 22/10/1445 AH.
//

import Foundation
import CloudKit

struct postModel: Identifiable {
    let id: CKRecord.ID
    var voting_Counter: Int
    let photo: CKAsset?
    let user_id: String
    let challengeId: CKRecord.ID //Here Ghalia
    
    
    
    init(record: CKRecord) {
        self.id = record.recordID
        self.voting_Counter = record["voting_Counter"] as? Int ?? 0
        self.photo = record["photo"] as? CKAsset
        self.user_id = record["user_id"] as? String ?? "N/A"
        "N/A"
        
        
        self.challengeId = record["challengeId"] as? CKRecord.ID ?? CKRecord.ID(recordName: "") // Assuming you set this field in your database //Here Ghalia
        
        
           }
    }

