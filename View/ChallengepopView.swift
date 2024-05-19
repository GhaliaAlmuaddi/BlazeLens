//
//  ChallengepopView.swift
//  CloudKidGameCenterTest
//
//  Created by Ghalia Mohammed Al Muaddi on 11/11/1445 AH.
//

import SwiftUI

struct ChallengepopView: View {
    let challenge: ChallengeModel

    var body: some View {
        NavigationStack {
                  VStack {
                      Image("fire")
                          .resizable()
                          .frame(width: 150, height: 141)

                      Text("Thank you for Joining!")
                          .bold()
                          .font(.title)

                      Text("Voting timeline ")
                          .font(.title3)
                          .foregroundColor(.gray)

                      Text("\(formatTime(challenge.VotingStartDate)) - \(formatTime(challenge.VotingEndDate))")
                          .bold()

                      NavigationLink {
                          userProfile()
                      } label: {
                          Text("Done")
                              .font(Font.custom("SF Pro", size: 16).weight(.bold))
                              .lineSpacing(25.60)
                              .foregroundColor(.white)
                              .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                              .frame(width: 270, height: 60)
                              .background(
                                  LinearGradient(gradient: Gradient(colors: [Color(red: 0.05, green: 0.23, blue: 0.61), Color(red: 0.24, green: 0.50, blue: 0.85)]), startPoint: .top, endPoint: .bottom)
                              )
                              .cornerRadius(24)
                      }
                  }
                  .frame(width: 313, height: 414)
                  .background()
                  .cornerRadius(24)
                  .shadow(radius: 24)
              }
              .navigationBarBackButtonHidden(true)
          }
        
    
    
    func formatTime(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Riyadh")
        
        return dateFormatter.string(from: date)
    }
}
 

//#Preview {
//    ChallengepopView(challenge: <#ChallengeModel#>)
//}
