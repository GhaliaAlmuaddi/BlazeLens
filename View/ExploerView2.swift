//
//  ExploerView2.swift
//  CloudKidGameCenterTest
//
//  Created by shomokh aldosari on 06/11/1445 AH.
//
import SwiftUI
struct ExploerView2: View {
    var body: some View{
        NavigationStack{
            ZStack {
            Color("BackgroundColorr").ignoresSafeArea()
            
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        VStack {
                            Text("Challenge name")
                                .bold()
                        }
                    }
               
                    ToolbarItem(placement: .navigationBarLeading) {
                        NavigationLink {
                           userProfile()
                        } label: {
                            Image(systemName: "arrowshape.backward.fill")
                            
                                .resizable()
                            
                                .padding(.leading, 5.0)
                            
                                .frame(width: 30 , height: 20)
                                .foregroundColor(Color(red: 0.05, green: 0.23, blue: 0.61))
                        }
                        
                    }
                    
                }
            

       
            
           // explorehead()
            VStack/*(spacing: 20)*/ {
           winnerimages()
                    .offset(y:-100)
                
            }

        }
       // .background(Color("BackgroundColor"))
       
        }.navigationBarBackButtonHidden(true)

       
         

}
}
struct winnerimages:View {
    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 8) {
                ZStack() {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 343, height: 497)
                        .background(
                            LinearGradient(gradient: Gradient(colors: [Color(red: 0.85, green: 0.85, blue: 0.85).opacity(0), Color(red: 0, green: 0, blue: 0).opacity(0.70)]), startPoint: .top, endPoint: .bottom)
                        )
                        .offset(x: 0, y: 41.50)
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 343, height: 94)
                        .background(Color(red: 0.91, green: 0.91, blue: 0.91))
                        .offset(x: 0, y: 178)
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 47.21, height: 29)
                        .background(
                            AsyncImage(url: URL(string: "https://via.placeholder.com/47x29"))
                        )
                        .offset(x: 158.49, y: 231.50)
                        .shadow(
                            color: Color(red: 0.24, green: 0.50, blue: 0.85, opacity: 0.75), radius: 4, y: 2
                        )
                    ZStack() {
                        Image("win1")
                            .resizable()
                            .foregroundColor(.clear)
                            .frame(width: 120.80, height: 153)
                            .offset(x: 0, y: 0)
                            .offset(x: -2.89, y: 12.50)
                    }
                    .frame(width: 110.80, height: 153)
                    .offset(x: -116.10, y: -152.50)
                }
                .frame(width: 343, height: 414)
                .background(
                    Image("coffee")
                )
                .cornerRadius(24)
                
                ZStack() {
                    // Winner name (comes from database)
                    Text("Winner name")
                        .font(Font.custom("SF Pro", size: 24).weight(.bold))
                        .foregroundColor(.black)
                        .offset(x: -80.51, y: -1.87)
                    
                    HStack() {
                        // 99K (comes from database)
                        Text("99K")
                            .font(Font.custom("SF Pro", size: 20))
                            .foregroundColor(.black)
                            .offset(x: 0, y: -2.46)
                            
                        Image("flame 1")
                            .foregroundColor(.clear)
                            .frame(width: 46.42, height: 24)
                            .offset(x: 0, y: -2.46) // Adjusted offset to reduce space
                    }
                    .frame(width: 96.87, height: 24)
                    .offset(x: 127.15, y: 1)
                }
                .frame(width: 333, height: 26)
                .offset(x: 0, y: -50)
            }
            //
            VStack(spacing: 8) {
                ZStack() {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 343, height: 497)
                        .background(
                            LinearGradient(gradient: Gradient(colors: [Color(red: 0.85, green: 0.85, blue: 0.85).opacity(0), Color(red: 0, green: 0, blue: 0).opacity(0.70)]), startPoint: .top, endPoint: .bottom)
                        )
                        .offset(x: 0, y: 41.50)
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 343, height: 94)
                        .background(Color(red: 0.91, green: 0.91, blue: 0.91))
                        .offset(x: 0, y: 178)
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 47.21, height: 29)
                        .background(
                            AsyncImage(url: URL(string: "https://via.placeholder.com/47x29"))
                        )
                        .offset(x: 158.49, y: 231.50)
                        .shadow(
                            color: Color(red: 0.24, green: 0.50, blue: 0.85, opacity: 0.75), radius: 4, y: 2
                        )
                    ZStack() {
                        Image("win2")
                            .resizable()
                            .foregroundColor(.clear)
                            .frame(width: 120.80, height: 153)
                            .offset(x: 0, y: 0)
                            .offset(x: -2.89, y: 12.50)
                    }
                    .frame(width: 110.80, height: 153)
                    .offset(x: -116.10, y: -152.50)
                }
                .frame(width: 343, height: 414)
                .background(
                    Image("coffee")
                )
                .cornerRadius(24)
                
                ZStack() {
                    // Winner name (comes from database)
                    Text("Winner name")
                        .font(Font.custom("SF Pro", size: 24).weight(.bold))
                        .foregroundColor(.black)
                        .offset(x: -80.51, y: -1.87)
                    
                    HStack() {
                        // 99K (comes from database)
                        Text("99K")
                            .font(Font.custom("SF Pro", size: 20))
                            .foregroundColor(.black)
                            .offset(x: 0, y: -2.46)
                            
                        Image("flame 1")
                            .foregroundColor(.clear)
                            .frame(width: 46.42, height: 24)
                            .offset(x: 0, y: -2.46) // Adjusted offset to reduce space
                    }
                    .frame(width: 96.87, height: 24)
                    .offset(x: 127.15, y: 1)
                }
                .frame(width: 333, height: 26)
                .offset(x: 0, y: -50)
            }
            //
            VStack(spacing: 8) {
                ZStack() {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 343, height: 497)
                        .background(
                            LinearGradient(gradient: Gradient(colors: [Color(red: 0.85, green: 0.85, blue: 0.85).opacity(0), Color(red: 0, green: 0, blue: 0).opacity(0.70)]), startPoint: .top, endPoint: .bottom)
                        )
                        .offset(x: 0, y: 41.50)
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 343, height: 94)
                        .background(Color(red: 0.91, green: 0.91, blue: 0.91))
                        .offset(x: 0, y: 178)
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 47.21, height: 29)
                        .background(
                            AsyncImage(url: URL(string: "https://via.placeholder.com/47x29"))
                        )
                        .offset(x: 158.49, y: 231.50)
                        .shadow(
                            color: Color(red: 0.24, green: 0.50, blue: 0.85, opacity: 0.75), radius: 4, y: 2
                        )
                    ZStack() {
                        Image("win3")
                            .resizable()
                            .foregroundColor(.clear)
                            .frame(width: 120.80, height: 153)
                            .offset(x: 0, y: 0)
                            .offset(x: -2.89, y: 12.50)
                    }
                    .frame(width: 110.80, height: 153)
                    .offset(x: -116.10, y: -152.50)
                }
                .frame(width: 343, height: 414)
                .background(
                    Image("coffee")
                )
                .cornerRadius(24)
                
                ZStack() {
                    // Winner name (comes from database)
                    Text("Winner name")
                        .font(Font.custom("SF Pro", size: 24).weight(.bold))
                        .foregroundColor(.black)
                        .offset(x: -80.51, y: -1.87)
                    
                    HStack() {
                        // 99K (comes from database)
                        Text("99K")
                            .font(Font.custom("SF Pro", size: 20))
                            .foregroundColor(.black)
                            .offset(x: 0, y: -2.46)
                            
                        Image("flame 1")
                            .foregroundColor(.clear)
                            .frame(width: 46.42, height: 24)
                            .offset(x: 0, y: -2.46) // Adjusted offset to reduce space
                    }
                    .frame(width: 96.87, height: 24)
                    .offset(x: 127.15, y: 1)
                }
                .frame(width: 333, height: 26)
                .offset(x: 0, y: -50)
            }
        }
        .frame(width: 390, height: 497)
        .offset(x: 2, y: 10)

//.frame(width: 390, height: 1787)
//.background(Color(red: 0.95, green: 0.95, blue: 0.94))
    }
}

#Preview {
    ExploerView2()
}
