//
//  votePop.swift
//  CloudKidGameCenterTest
//
//  Created by shomokh aldosari on 05/11/1445 AH.
//

import SwiftUI

struct votePop: View {
    var body: some View {
        NavigationStack{
            VStack{
                Image("fire")
                    .resizable()
                    .frame(width: 150, height: 141)
                
                Text("Thank you for voting!")
                    .bold()
                    .font(.title)
                Text("Winner will be notified")
                    .font(.title3)
                    .foregroundColor(.gray)
                
                NavigationLink(destination: todayPhotoChallenge()){
                    Text("Done")
                }
              //  .frame(width: 270, height: 60)
//                .background(Color.buttoncolor)
//                .cornerRadius(24)
//                .foregroundColor(.white)
                .font(Font.custom("SF Pro", size: 16).weight(.bold))
                .lineSpacing(25.60)
                .foregroundColor(.white)
                .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                .frame(width: 270, height: 60)
                .background(
                    LinearGradient(gradient: Gradient(colors: [Color(red: 0.05, green: 0.23, blue: 0.61), Color(red: 0.24, green: 0.50, blue: 0.85)]), startPoint: .top, endPoint: .bottom)
                )
                .cornerRadius(24)
                
            }.frame(width: 313, height: 414)
                .background()
                .cornerRadius(24)
                .shadow(radius: 24)
              .navigationBarBackButtonHidden(true)
            
        }
    }
}

#Preview {
    votePop()
}
