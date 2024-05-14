//
//  winnersPop.swift
//  CloudKidGameCenterTest
//
//  Created by shomokh aldosari on 06/11/1445 AH.
//

import SwiftUI

struct winnersPop: View {
    var body: some View {
        NavigationStack{
            VStack{
                ZStack{
                    Image("winner1")
                        .resizable()
                        .frame(width: 200, height: 200)
                    
                    Image("winner2")
                        .resizable()
                        .frame(width: 125, height: 176)
                }
                
                Text("Congatulations!")
                    .bold()
                    .font(.title)
                Text("You have won the 1st place!")
                    .font(.title3)
                    .foregroundColor(.gray)
                
                NavigationLink(destination: ExploreView()){
                    Text("Ok")
                }
                .frame(width: 270, height: 60)
                .background(Color.buttoncolor)
                .cornerRadius(24)
                .foregroundColor(.white)
                
            }.frame(width: 313, height: 414)
                .background()
                .cornerRadius(24)
                .shadow(radius: 24)
              .navigationBarBackButtonHidden(true)
            
        }

    }
}

#Preview {
    winnersPop()
}
