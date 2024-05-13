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
    
    var body: some View {
        NavigationStack{

            ZStack{
                Color(.backgroungC)
                    .ignoresSafeArea()
                VStack(alignment: .center, content: {
                    Text("Voting start in")
                        .foregroundColor(.gray)
                        .font(.callout)
                    

                    
                    ScrollView {
                        
                        let columns = Array(repeating: GridItem(.flexible(), spacing: 12), count: 2)
                        LazyVGrid(columns: columns, alignment: .center,spacing: 10, content:{

                                ForEach(viewModel.posts.indices, id: \.self) { index in
                                   
                                        
                                   
                                        GridImageView(index: index)

                                    
                                }
                            
                        }).padding(.top)
                            
                       
                                       
                                   }

                    NavigationLink(destination: votePop(), isActive: $isShowingPopUp) {
                                      EmptyView()
                                  }
                              

                              Button("Submit voting"){

                                  isShowingPopUp = true
                                  // Clear the selectedPhotos set after submitting the votes
                                 // selectedPhotos.removeAll()
                              }
                              .frame(width: 343, height: 60)
                              .background(.buttoncolor)
                              .cornerRadius(24)
                              .foregroundColor(.white)
                              .bold()
                              .padding()

                           
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

#Preview {
    votePage()
}
