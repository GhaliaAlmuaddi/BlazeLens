//
//  ChallengeViewModel.swift
//  CloudKidGameCenterTest
//
//  Created by Ghalia Mohammed Al Muaddi on 21/10/1445 AH.
//

import Foundation
import CloudKit

class ChallengeViewModel : ObservableObject {
    @Published var Challenges : [ChallengeModel] = []
    
    
    
    func fetchChallenges (){

        let predicate = NSPredicate(value: true)

        let query = CKQuery(recordType:"ChallangesRecord", predicate: predicate)

        let operation = CKQueryOperation(query: query)

        operation.recordMatchedBlock = { recordId, result in
            DispatchQueue.main.async {
                switch result {
                case .success(let record):

                    let Challange = ChallengeModel(record: record)

                    self.Challenges.append(Challange)

                    
                case .failure(let error):
                    print("\(error.localizedDescription)")
                    
                }
            }
        }
        
        CKContainer(identifier: "iCloud.l.CloudKidGameCenterTest").publicCloudDatabase.add(operation)
    }
    
    
    
    func saveChallengeToCloudKit(ChallengeRecord: ChallengeModel, completion: @escaping (Error?) -> Void) {
    let record = CKRecord(recordType: "ChallangesRecord")
        record["challengeName"] = ChallengeRecord.challengeName
        record["ChallengeStartDate"] = ChallengeRecord.ChallengeStartDate
        record["ChallengeEndDate"] = ChallengeRecord.ChallengeEndDate
        record ["VotingStartDate"]=ChallengeRecord.VotingStartDate
        record ["VotingEndDate"]=ChallengeRecord.VotingEndDate

   
 

        CKContainer(identifier: "iCloud.l.CloudKidGameCenterTest").publicCloudDatabase.save(record) { (savedRecord, error) in
    completion(error)
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
    
    
    
//    func Current_Challenge () -> ChallengeModel{
//   
//        if ((formatDate(Challenges.ChallengeStartDate)) >= (formatDate(currentDate)))
//            {
//            
//            
//            
//        }
//    }
    
    
//    func filteredChallenges() -> [ChallengeModel]{
//          let currentDate = Date()
//        return Challenges.filter { $0.ChallengeStartDate <= currentDate }
//      }
    
    
}
    
    
   

        
