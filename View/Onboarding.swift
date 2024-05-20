//
//  Onboarding.swift
//  CloudKidGameCenterTest
//
//  Created by shomokh aldosari on 10/11/1445 AH.
//

import SwiftUI

struct Onboarding: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Image("IMG_5609")
                    .resizable(resizingMode: .stretch)
                    .edgesIgnoringSafeArea(.all)
                
                MagnifyGlass()
                    .toolbar {
                     
                     
                        ToolbarItem(placement: .navigationBarTrailing) {
                            NavigationLink {
                                ExploreView()
                            } label: {
                                Text("Skip")
                                    .foregroundColor(.blue)
                                    .padding()
                                    .bold()
                                    .background(Color.clear)
                                    .cornerRadius(10)
                            }
                        }
                    }
                VStack {
                    VStack(alignment: .leading,spacing: 5) {
                        
                            Text("Discover beauty in every shot")
                                .font(.system(size: 24))
                                .fontWeight(.bold)
                                .padding(EdgeInsets())
                                .foregroundColor(Color("Color 1"))
                                .padding([.top, .leading], 7.0)
                        
                            Text("Move the lens to reveal image details")
                                .font(.system(size: 18))
                                .padding(EdgeInsets())
                                .foregroundColor(Color("Color 1"))
                                .padding(.leading, 9.0)
                        
                    }
                    //.padding(10)
                    //.offset(y: 30)
                    
                    Spacer()
                }
                .offset(y:-15)
               
                
            }
            
        }.navigationBarBackButtonHidden(true)
    }
}


struct MagnifyGlassView_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding()
    }
}

extension Path {
    var reversed: Path {
        let reversedCGPath = UIBezierPath(cgPath: cgPath)
            .reversing()
            .cgPath
        return Path(reversedCGPath)
    }
}

struct LensShape: Shape {
    var xOffset: CGFloat = 0
    var yOffset: CGFloat = 0
    
    func path(in rect: CGRect) -> Path {
        var path = Rectangle().path(in: rect)
        let hole = Circle().path(in: CGRect(x: rect.midX + xOffset - 50, y: rect.midY + yOffset - 50, width: 180, height: 180)).reversed
        path.addPath(hole)
        return path
    }
}

struct MagnifyGlass: View {
    @State private var xOffset: CGFloat = 0
    @State private var yOffset: CGFloat = 0
  //  @State private var isAnimating = false
    
    var body: some View {
        GeometryReader { geometry in
            ZStack{
                
                
                LensShape(xOffset: xOffset, yOffset: yOffset)
                    .fill(Color("Color"))
                    .opacity(0.8)
                
                
                Image( "smallerLogo")
                    .resizable()
                    .frame(width: 358,height:367)
                    .foregroundColor(.white)//.opacity(0.9)
                    .offset(x: xOffset+39, y: yOffset+41)
                    .shadow(radius: /*@START_MENU_TOKEN@*/15/*@END_MENU_TOKEN@*/)
                 //   .shadow(color: Color.black, radius: -20, x: 1, y: -6)
                   // .frame(width: geometry.size.width, height: geometry.size.height)
             
                //هنا اقدر اغير اللون الاسود
//                AnimatedImage(name: "Logo3.GIF")
//
////
// .frame(width: 577,height: 990)
// .shadow(color: Color(white: 0.812, opacity: 0.78), radius: 13, x: 6, y: -5)
//                    //.resizable()
//
//                   // .foregroundColor(.white)
//                    .opacity(0.95)
//                    .offset(x: xOffset+78, y: yOffset-146)
//   لوقو الgif
//                Image("appname")
//                    .resizable()
//                    .frame(width: 120, height: 30, alignment: .center)//.opacity(0.2)
//                   // .fontWeight(.light)
//                   // .rotationEffect(.degrees(-180))
//                    .offset(x: xOffset+50, y: yOffset+180)
//                    .shadow(radius: 15)
             

                
              }
                .gesture(DragGesture()
                    .onChanged { value in
                        xOffset = value.translation.width
                        yOffset = value.translation.height
                    }
                    .onEnded { value in
                        // If you need to do something after the drag ends, you can add code here.
                    }
                )
                .contentShape(LensShape(xOffset: xOffset, yOffset: yOffset))
        }.edgesIgnoringSafeArea(.all) // needed for hit-testing
    }
}



#Preview {
    Onboarding()
}

