//
//  todayPhotoChallenge.swift
//  CloudKidGameCenterTest
//
//  Created by shomokh aldosari on 05/11/1445 AH.
//

import SwiftUI
import CloudKit
struct todayPhotoChallenge: View {
    @StateObject var viewModel = postViewModel()
    @State var vote : Int = 0
    let container = CKContainer(identifier: "iCloud.l.CloudKidGameCenterTest")
    
    
    var body: some View {
        NavigationStack{
            

                          
       
            ZStack{
                Color(.backgroungC)
                    .ignoresSafeArea()
              
                VStack{
                
                    
                   
                    
                    ScrollView {
                        LazyVGrid(columns: [GridItem(), GridItem()], spacing: 10) {
                        ForEach(viewModel.posts, id: \.self) { post in
                            AsyncImage(url: viewModel.cloudKitImageURL(for: post.photo)) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                case .success(let image):
                                    image
                                        .resizable()
                                        .frame(width:  163, height: 163)
                                        .cornerRadius(15)
                                        
                                    HStack{
                                        Text("\(post.voting_Counter)")
                                        Image("fire")
                                            .resizable()
                                            .frame(width: 20, height: 20)
                                    }.padding(.leading, 100)
                                       
                                    
                                case .failure:
                                    Image(systemName: "exclamationmark.triangle.fill")
                                        .resizable()
                                        .frame(width: 94, height: 94)
                                        .cornerRadius(15)
                                        .padding()
                                @unknown default:
                                    EmptyView()
                                }
                                
                                
                            }
                           
                               
                            
                        }
                        }.padding()
                                   }
                    

                    
                    
                    
                }
                .onAppear {
                    viewModel.fetchposts()
                    
                }
            }
        
        
        .toolbar {
            ToolbarItem(placement: .principal) {
                    VStack {
                        Text("Challenge")
                            .bold()
                            
                    }
                }
        }.navigationBarBackButtonHidden(true)
    }
    }
}

#Preview {
    todayPhotoChallenge()
}

