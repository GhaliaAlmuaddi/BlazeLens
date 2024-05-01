//
//  DateView.swift
//  CloudKidGameCenterTest
//
//  Created by Ghalia Mohammed Al Muaddi on 21/10/1445 AH.
//

import SwiftUI
import CloudKit

struct ChallengeView: View {
    
    @EnvironmentObject var ChallengeVM : ChallengeViewModel
    
    var body: some View {

        VStack {
            let currentDate = getCurrentFormattedDate()

        ForEach(ChallengeVM.Challenges) { challenge in
          
            Text (challenge.challengeName) //to check if the modelView works
            //المفروض تكون بعد الشرط بس حطيتها هنا اشيك اذا الفتش ضابط ولالا
            
            
            Text("Wellcome to the Challange view")
          //  Text("Now date is \(currentDate)")
            
            
//            if (challenge.ChallengeStartDate == currentDate ){
//
//                    
//                    Text ("\(challenge.challengeName) Challenge is Start now")
//                    
//                    let currentDate = Date()
//                    
//
//                }
                }
            }.onAppear {
                ChallengeVM.fetchChallenges()
        }
    }
    
     func getCurrentFormattedDate() -> String {
        // Get the current date
        let currentDate = Date()

        // Create a date formatter
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy, hh:mm:ss.SS"
        // dateFormatter.dateFormat =  "yyyy-MM-dd HH:mm:ss"
       // dateFormatter.timeZone = TimeZone(identifier: "UTC")

        // Format the date to string
        let formattedDate = dateFormatter.string(from: currentDate)

        return formattedDate
    }

}
    
    #Preview {
        NavigationStack{
            ChallengeView().environmentObject(ChallengeViewModel())
        }
    }
