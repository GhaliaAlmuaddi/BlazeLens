//
//  GridImageView.swift
//  CloudKidGameCenterTest
//
//  Created by shomokh aldosari on 05/11/1445 AH.
//

import SwiftUI
import CloudKit

struct GridImageView: View {
    @EnvironmentObject var voteData: postViewModel
    var index: Int
    let container = CKContainer(identifier: "iCloud.l.CloudKidGameCenterTest")
    @State private var isVoteTapped = false
    @State private var voteCount = 0
    var body: some View {
        Button(action: {
            withAnimation(.easeInOut){
                voteData.selectedPost = voteData.posts[index]
                voteData.showImageViewer = true // Set showImageViewer to true
            }
        }, label: {
            ZStack{
                if index < voteData.posts.count { // Check if index is within bounds
                    if let fileURL = voteData.posts[index].photo?.fileURL,
                       let imageData = try? Data(contentsOf: fileURL) {
                        Image(uiImage: UIImage(data: imageData)!)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: (getRect().width-100)/2, height: 120)
                            .cornerRadius(12)
                            .contextMenu {
                                Button(action: {
                                    if voteCount < 3{
                                        voteData.getPost(for: voteData.posts[index]) { voteCounter in
                                                    if let voteCounter = voteCounter {
                                                        // Increment the vote counter locally
                                                        voteData.posts[index].voting_Counter = voteCounter + 1
                                                        // Optionally, update the vote counter in CloudKit
                                                        voteData.updateVote(for: voteData.posts[index], newVoteCount: voteCounter + 1)
                                                        isVoteTapped.toggle()
                                                    } else {
                                                        print("Error: Unable to fetch vote counter")
                                                    }
                                                }
                                    }
                                   
                                }) {
                                    HStack {
                                                        Image(systemName: isVoteTapped ? "flame.fill" : "flame")
                                                            .foregroundColor(isVoteTapped ? .red : .black) // Change color when filled
                                                        Text("Vote")
                                                    }
                                                    }
                                               
                                           }//(isPresented: $isContextMenuVisible)
//                            .onLongPressGesture {
//                                                // Show context menu
//                                                isContextMenuVisible = true
//                                            }
                    }
                }
            }
        })
        
    }
  
}

//#Preview {
//    votePage()
//}

extension View{
    func getRect()->CGRect{
        return UIScreen.main.bounds
    }
}
