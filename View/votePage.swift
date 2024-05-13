//
//  votePage.swift
//  CloudKidGameCenterTest
//
//  Created by shomokh aldosari on 22/10/1445 AH.
//

import SwiftUI
import CloudKit

struct votePage: View {
    @StateObject var viewModel = postViewModel()
    @State var vote : Int = 0
    let container = CKContainer(identifier: "iCloud.l.CloudKidGameCenterTest")
    var body: some View {
        VStack{
            
            ForEach(viewModel.posts.indices, id: \.self) { index in
                var post = viewModel.posts[index]
            HStack{
                AsyncImage(url: viewModel.cloudKitImageURL(for: post.photo)) { phase in
                    switch phase {
                    case .empty:
                        
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .frame(width: 94, height: 94)
                            .cornerRadius(15)
                            .padding()
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
                VStack (alignment: .leading, spacing: 6){
                    //Image("\(brand.brandLogo)")
                    Text("\(post.voting_Counter)")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(Color.black)
                    
                    Button("vote") {
                        getPost(for: post) { voteCounter in
                                if let voteCounter = voteCounter {
                                    // Increment the vote counter locally
                                    viewModel.posts[index].voting_Counter = voteCounter + 1
                                    // Optionally, update the vote counter in CloudKit
                                    viewModel.updateVote(for: post, newVoteCount: voteCounter + 1)
                                } else {
                                    print("Error: Unable to fetch vote counter")
                                }
                            }
                       // viewModel.posts[index].voting_Counter += 1
//                        vote = viewModel.posts[index].voting_Counter
//                        let newVoteCount = viewModel.posts[index].voting_Counter + 1
//                        viewModel.updateVote(for: post, newVoteCount: newVoteCount)
                        
                    }.frame(width: 70, height: 45)
                        .background(.blue)
                        .opacity(0.7)
                        .cornerRadius(8)
                        .foregroundColor(.white)
                }
               
            }
            
            .background(Rectangle())
            .foregroundColor(Color.white)
            .cornerRadius(8)
            .shadow(color: .gray.opacity(0.2),radius: 8)
            .padding(3)

           
                
                
        }
    }
        .onAppear {
            viewModel.fetchposts()
            
        }
    }
    
    func getPost(for post: postModel, completion: @escaping (Int?) -> Void) {
        // Fetch the CKRecord for the post
        let recordID = CKRecord.ID(recordName: post.id.recordName)
        container.publicCloudDatabase.fetch(withRecordID: recordID) { record, error in
            guard let record = record, error == nil else {
                print("Error fetching record: \(error?.localizedDescription ?? "Unknown error")")
                completion(nil)
                return
            }
            
            // Extract the vote counter from the record
            if let voteCounter = record["voting_Counter"] as? Int {
                completion(voteCounter)
            } else {
                // If the vote counter is not found or cannot be cast to Int, return nil
                completion(nil)
            }
        }
    }
    
        
    func saveVote(){
        
    }
}

#Preview {
    votePage()
}
