//
//  SplashView.swift
//  CloudKidGameCenterTest
//
//  Created by shomokh aldosari on 06/11/1445 AH.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack() {
           
            HStack(spacing: 0) {
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 134, height: 5)
                    .background(.black)
                    .cornerRadius(100)
            }
            .padding(EdgeInsets(top: 21, leading: 128, bottom: 8, trailing: 127))
            .frame(width: 389, height: 34)
            .offset(x: -0.50, y: 404)
            Text("BlazeLens")
                .font(Font.custom("Peralta", size: 40))
                .foregroundColor(Color(red: 0.11, green: 0.32, blue: 0.69))
                .offset(x: 0, y: 112.50)
      
            Image("Logo")
                .foregroundColor(.clear)
                .frame(width: 236, height: 333)
               
                .offset(x: 2.09, y: -90.50)
                .rotationEffect(.degrees(-1.05))
            Text("Capture, Share and Compete!\nUnleash your creativity!")
                .font(Font.custom("SF Pro", size: 20))
                .foregroundColor(.black)
                .offset(x: -0.50, y: 220.87)
        }
        .frame(width: 395, height: 844)
        .background(
            LinearGradient(gradient: Gradient(colors: [Color(red: 1, green: 0.98, blue: 0.92), Color(red: 0.95, green: 0.95, blue: 0.94), Color(red: 0.24, green: 0.50, blue: 0.85)]), startPoint: .top, endPoint: .bottom)
        )
    }
}

#Preview {
    SplashView()
}

