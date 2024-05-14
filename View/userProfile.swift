//
//  userProfile.swift
//  CloudKidGameCenterTest
//
//  Created by shomokh aldosari on 06/11/1445 AH.
//

import SwiftUI
import CloudKit
import GameKit

struct userProfile: View {
    @StateObject var viewModel = postViewModel()
    
    @State private var fetchedPlayerID: String?
    @State private var profileImage: UIImage?
       @State private var displayName: String = ""
    
    var body: some View {
        NavigationStack{
//            ZStack (alignment: .center, content: {
//                Color("BackgroundColor").ignoresSafeArea()
                
            ZStack{
                
            Color(.backgroungC)
                    .ignoresSafeArea()
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        Text("Profile")
                            .bold()
                    }
                }
                ToolbarItem(placement: .primaryAction) {
                    NavigationLink {
                        ExploreView()
                    } label: {
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                            .resizable()
                            .padding(.trailing, 5.0)
                            .frame(width: 30, height: 20)
                            .foregroundColor(Color(red: 0.05, green: 0.23, blue: 0.61))
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    NavigationLink {
                        ExploreView()
                    } label: {
                        Image(systemName: "arrowshape.backward.fill")
                            .resizable()
                            .padding(.leading, 5.0)
                            .frame(width: 30, height: 20)
                            .foregroundColor(Color(red: 0.05, green: 0.23, blue: 0.61))
                    }
                }
            }
           
           
               
           // })// ZStack end
            
           
                
                VStack(alignment: .center, content: {

                    if let profileImage = profileImage {
                                   Image(uiImage: profileImage)
                                       .resizable()
                                       .scaledToFit()
                                       .frame(width: 100, height: 100)
                                       .clipShape(Circle())
                               } else {
                                   // Placeholder image or loading indicator
                                   Text("Loading profile image...")
                               }
                    
                   Text("\(GKLocalPlayer.local.displayName)")

                    HStack(spacing: 50){
                        VStack{
                            Text("Rank")
                                .font(Font.custom("SF Pro", size: 13))
                                .foregroundColor(Color(red: 0.49, green: 0.49, blue: 0.49))
                                .offset(x: 0, y: 25)
                            Text("20")
                                .font(Font.custom("Inter", size: 18).weight(.semibold))
                                .foregroundColor(.black)
                                .offset(x: -0.63, y: -7.50)
                        }
                        Divider()
                            .frame(width: 1, height: 30)
                            
                        VStack{
                            Text("Votes ")
                                .font(Font.custom("SF Pro", size: 13))
                                .foregroundColor(Color(red: 0.49, green: 0.49, blue: 0.49))
                                .offset(x: -0, y: 25)
                            //come from database
                            Text("274")
                                .font(Font.custom("Inter", size: 18).weight(.semibold))
                                .foregroundColor(.black)
                                .offset(x: -0, y: -7.50)
                        }
                    }.padding()
                    
                    Text("Activity ")
                        .font(Font.custom("SF Pro", size: 24).weight(.bold))
                        .foregroundColor(.black)
                        .offset(x: -120, y: -4)
                    
                    ScrollView {
                        
                        let columns = Array(repeating: GridItem(.flexible(), spacing: 20), count: 3)
                        LazyVGrid(columns: columns, alignment: .center,spacing: 10, content:{
                            //ForEach(ChallengeVM.Challenges, id: \.self) { challeng in
                                
                                ForEach(viewModel.posts.indices, id: \.self) { index in
                                    
                                    if GKLocalPlayer.local.playerID == viewModel.posts[index].user_id{
                                        
                                        if let fileURL = viewModel.posts[index].photo?.fileURL,
                                           let imageData = try? Data(contentsOf: fileURL) {
                                            Image(uiImage: UIImage(data: imageData)!)
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: 105, height: 135)
                                                .cornerRadius(12)
                                            
                                        }
                                        
                                        // GridImageView(index: index)
                                        
                                    }
                                }
                        //}
                        })
                            .padding()
                            
                            
                            
                       
                                       
                                   }

                  
                              .padding()

                           
                })
               
                .environmentObject(viewModel)
            }
        
        .onAppear {
            viewModel.fetchposts()
            loadProfilePhoto()
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                    VStack {
                        Text("Profile")
                            .bold()
                            
                    }
                }
        }
    }.navigationBarBackButtonHidden(true)
    }
    
    
    func loadProfilePhoto() {
            GKLocalPlayer.local.loadPhoto(for: .normal) { (photo, error) in
                if let photo = photo {
                    DispatchQueue.main.async {
                        self.profileImage = photo
                    }
                }
            }
            
            self.displayName = GKLocalPlayer.local.displayName ?? "Unknown"
        }
}

#Preview {
    userProfile()
}
