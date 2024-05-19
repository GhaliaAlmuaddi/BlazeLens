//
//  votePage.swift
//  CloudKidGameCenterTest
//
//  Created by shomokh aldosari on 22/10/1445 AH.
//

import SwiftUI
import CloudKit


struct votePage: View {
   // @StateObject var homeData = ViewModel()
    @StateObject var viewModel = postViewModel()
    @State var vote : Int = 0
    let container = CKContainer(identifier: "iCloud.l.CloudKidGameCenterTest")
    //@State private var selectedPhotos: Set<postModel> = Set()
       let maxSelections = 3
    //@State var isSelectButton : Bool = false
    @State private var isSelectButton = false
    @State var currentUserID: String?
    @State private var isShowingPopUp = false
    @State var selectedPhoto: postModel? = nil // Track the selected photo
        @State private var isShowingDetailView = false
    //let challengeID: CKRecord.ID
    @State var challengeId: CKRecord.ID?
    let challenge: ChallengeModel
    @StateObject var ChallengeVM = ChallengeViewModel()
    
    let columns = [
           GridItem(.flexible()),
           GridItem(.flexible())
       ]
    
    var body: some View {
        NavigationStack{

            ZStack{
                Color(.backgroungC)
                    .ignoresSafeArea()
                VStack(alignment: .center, content: {
                    Text("Voting end at :")
                        .foregroundColor(.gray)
                        .font(.callout)

                    
                    Text("\(formatTime(challenge.VotingEndDate))")
                        .bold()
                        .font(.title2)
                    
                    
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(viewModel.posts.indices, id: \.self) { index in
                          
                            if let postChallengeId = viewModel.posts[index].challengeId,
                                  postChallengeId.recordID == challengeId{
                                      GridImageView(index: index, challengeId: challenge.id)
                                  }
                            }
                    }

                            
                       
                                       
                                   }

                    NavigationLink(destination: votePop(), isActive: $isShowingPopUp) {
                                      EmptyView()
                                  }
                              

                              Button("Submit voting"){

                                  isShowingPopUp = true
                                  // Clear the selectedPhotos set after submitting the votes
                                 // selectedPhotos.removeAll()
                              }
                              //.frame(width: 343, height: 60)
                              .font(Font.custom("SF Pro", size: 16).weight(.bold))
                              .lineSpacing(25.60)
                              .foregroundColor(.white)
                              .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                              .frame(width: 343, height: 60)
                              .background(
                                  LinearGradient(gradient: Gradient(colors: [Color(red: 0.05, green: 0.23, blue: 0.61), Color(red: 0.24, green: 0.50, blue: 0.85)]), startPoint: .top, endPoint: .bottom)
                              )
                              .cornerRadius(24)
//                              .background(.buttoncolor)
//                              .cornerRadius(24)
//                              .foregroundColor(.white)
//                              .bold()
//                              .padding()

                           
                })
                .overlay(
                    ZStack{
                        if viewModel.showImageViewer{
                            ImageView()
                        }
                    }
                )
                .environmentObject(viewModel)
            }
        
        .onAppear {
            viewModel.fetchposts()
            
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                    VStack {
                        Text("Challenge")
                            .bold()
                            
                    }
                }
        }
    }.navigationBarBackButtonHidden(true)
           
    }
    
   
    
        
   
}

//#Preview {
//    votePage()
//}
