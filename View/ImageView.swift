//
//  ImageView.swift
//  CloudKidGameCenterTest
//
//  Created by shomokh aldosari on 05/11/1445 AH.
//
import SwiftUI
import CloudKit

struct ImageView: View {
    @EnvironmentObject var voteData: postViewModel
    //var index: Int
    @State private var voteCount = 0
    var body: some View {
        ZStack{
            Color.black
                .ignoresSafeArea()
            
            if let selectedPost = voteData.selectedPost,
               let fileURL = selectedPost.photo?.fileURL,
               let imageData = try? Data(contentsOf: fileURL) {
                Image(uiImage: UIImage(data: imageData)!)
                    .resizable()
                    .frame(width: 390, height: 390)
                //                    .padding(.trailing, -210)
                //.aspectRatio(contentMode: .fit)
                    .tag(imageData)
            } else {
                // Placeholder or loading indicator can be displayed here
                Color.gray
            }
        //}
       // .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
      
        // .padding(.trailing, -210)
        
        Button(action: {
            if voteCount < 3{
                voteData.getPost(for: voteData.selectedPost!) { voteCounter in
                    if let voteCounter = voteCounter {
                        // Increment the vote counter locally
                        voteData.selectedPost!.voting_Counter = voteCounter + 1
                        // Optionally, update the vote counter in CloudKit
                        voteData.updateVote(for: voteData.selectedPost!, newVoteCount: voteCounter + 1)
                        
                    } else {
                        print("Error: Unable to fetch vote counter")
                    }
                }
            }else {
                Button(action: {}){
                    VStack{
                        Text("vote")
                            .font(.title3)
                    }.frame(width: 90, height: 32)
                        .background(Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(24)
                        .padding(.top, 500)
                        .padding(.leading, 300)
                }
            }
        }) {
            
            VStack{
                Text("vote")
                    .font(.title3)
            }//.frame(width: 90, height: 32)
//                .background(Color.buttoncolor)
//                .foregroundColor(.white)
//                .cornerRadius(24)
//                .padding(.top, 500)
//                .padding(.leading, 300)
            .font(Font.custom("SF Pro", size: 16).weight(.bold))
            .lineSpacing(25.60)
            .foregroundColor(.white)
            .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
            .frame(width: 90, height: 32)
            .background(
                LinearGradient(gradient: Gradient(colors: [Color(red: 0.05, green: 0.23, blue: 0.61), Color(red: 0.24, green: 0.50, blue: 0.85)]), startPoint: .top, endPoint: .bottom)
            )
            .cornerRadius(24)
            .padding(.top, 500)
            .padding(.leading, 300)
            
        }
    }
        .overlay(
            Button(action: {
                withAnimation(.default){
                    voteData.showImageViewer = false
                }
            }, label: {
                Image(systemName: "xmark")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.white.opacity(0.3))
                    .clipShape(Circle())
            })
            .padding(10)
            ,alignment: .topTrailing
        )
    }
}




//#Preview {
//    votePage()
//}

