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
            Text("")
        let currentDate = Date()
        ForEach(ChallengeVM.Challenges) { challenge in
          
            
            
            //عشان اشيك عالتواريخ حق كلاود كت والحالي
            Text(formatDate(challenge.ChallengeStartDate))
            Text(formatDate(currentDate))
            
            
            
            //حاطه اكبر عشان اجرب المقارنة بس
            if ((formatDate(challenge.ChallengeStartDate)) >= (formatDate(currentDate)))
            {
//
//                    
                    Text ("\(challenge.challengeName) Challenge is Start now")

              }
                }
            }.onAppear {
                ChallengeVM.fetchChallenges()
        }
    }
    

    
    func formatDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Riyadh")
        
        return dateFormatter.string(from: date)
    }
    

}
    
    #Preview {
        NavigationStack{
            ChallengeView().environmentObject(ChallengeViewModel())
        }
    }
