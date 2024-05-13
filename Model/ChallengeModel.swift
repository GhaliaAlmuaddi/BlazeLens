//
//  ChallengeModel.swift
//  CloudKidGameCenterTest
//
//  Created by Ghalia Mohammed Al Muaddi on 21/10/1445 AH.
//

import Foundation
import CloudKit
struct ChallengeModel : Identifiable {
    var challengId : CKRecord.ID? 
  
    var challengeName : String
    var ChallengeStartDate : Date
    var ChallengeEndDate : Date
    var VotingStartDate : Date
    var VotingEndDate : Date
    //var Posts : [PostModel]
    var id : CKRecord.ID {
        challengId ?? CKRecord.ID(recordName: "")
        
    }
    
    init(record : CKRecord) {
        self.challengId = record.recordID
        self.challengeName = record["challengeName"] as? String ?? "N/A"
        self.ChallengeStartDate = record["ChallengeStartDate"] as? Date ?? Date()
        self.ChallengeEndDate = record["ChallengeEndDate"] as? Date ?? Date()
        self.VotingStartDate = record["VotingStartDate"] as? Date ?? Date()
        self.VotingEndDate = record["VotingEndDate"] as? Date ?? Date()
        
    } 
}


