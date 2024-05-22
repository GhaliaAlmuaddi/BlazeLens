//
//  ExploerView2.swift
//  CloudKidGameCenterTest
//
//  Created by shomokh aldosari on 06/11/1445 AH.
//
import SwiftUI
import CloudKit

struct ExploerView2: View {
    //@State var highestVotedPost : postModel
    @StateObject var viewModel = postViewModel()
    @State private var secondHighestVotedPost: postModel?
    @State private var topPosts: [postModel] = []
    var challengeId: CKRecord.ID
    var body: some View{
        NavigationStack{
            ZStack {
                Color("BackgroundColorr").ignoresSafeArea()
                
                    .toolbar {
                        ToolbarItem(placement: .principal) {
                            VStack {
                                Text("Previous challenge")
                                    .bold()
                            }
                        }
                        
                        ToolbarItem(placement: .navigationBarLeading) {
                            NavigationLink {
                                ExploreView()
                            } label: {
                                Image( "arrow_back")
                                
                                    .resizable()
                                
                                    .padding(.leading, 5.0)
                                
                                    .frame(width: 30 , height: 20)
                                    .foregroundColor(Color(red: 0.05, green: 0.23, blue: 0.61))
                            }
                            
                        }
                        
                    }
 
                ScrollView {
                    
//                    ForEach(topPosts, id: \.id) { index, post in
//                        PostView(post: post, index: index + 1)
//                    }
                    ForEach(Array(topPosts.enumerated()), id: \.element.id) { (index, post) in
                                            PostView(post: post, index: index + 1)
                                        }
                }
                
            }
            
            
        }.navigationBarBackButtonHidden(true)
            .onAppear {
                
//                    fetchTopPosts { posts, error in
//                        if let posts = posts {
//                            topPosts = posts
//                        } else if let error = error {
//                            print("Error fetching top posts: \(error.localizedDescription)")
//                        }
//                    }
                
                viewModel.fetchTopPosts(for: challengeId) { posts, error in
                               if let posts = posts {
                                   topPosts = posts
                               } else if let error = error {
                                   print("Error fetching top posts: \(error.localizedDescription)")
                               }
                           }
                
                
            }
    }
   
    
//    func fetchTopPosts(completion: @escaping ([postModel]?, Error?) -> Void) {
//        let container = CKContainer.default()
//        let publicDatabase = container.publicCloudDatabase
//
//        // Create a query to fetch all posts
//        let query = CKQuery(recordType: "challengePost", predicate: NSPredicate(value: true))
//        // Sort the results by voting_Counter in descending order
//        query.sortDescriptors = [NSSortDescriptor(key: "voting_Counter", ascending: false)]
//
//        // Perform the query
//        publicDatabase.perform(query, inZoneWith: nil) { records, error in
//            if let error = error {
//                completion(nil, error)
//                return
//            }
//
//            guard let records = records else {
//                completion(nil, nil)
//                return
//            }
//
//            // Map the records to postModel
//            let posts = records.map { postModel(record: $0) }
//
//            // Get the top 3 posts
//            let topPosts = Array(posts.prefix(3))
//
//            completion(topPosts, nil)
//        }
//    }

}
    struct PostView: View {
        let post: postModel
        
            let index: Int
        var body: some View {
            ZStack {
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 343, height: 414)
                
                if let asset = post.photo, let data = try? Data(contentsOf: asset.fileURL!) {
                    Image(uiImage: UIImage(data: data)!)
                        .resizable()
                        .frame(width: 338, height: 396)
                        .cornerRadius(24)
                } else {
                    Text("Failed to load photo")
                }
                
                HStack(alignment: .center, spacing: 7) {
                    Text("\(post.playerName)")
                        .font(Font.custom("SF Pro", size: 24).weight(.bold))
                        .foregroundColor(.black)
                        .padding(.trailing, 100)

                    Text("\(post.voting_Counter)")
                        .font(Font.custom("SF Pro", size: 20).weight(.bold))
                        .foregroundColor(Color(red: 0.49, green: 0.49, blue: 0.49))
                    
                    Image("fire")
                        .resizable()
                        .foregroundColor(.clear)
                        .frame(width: 20, height: 20)
                }
                .frame(width: 344, height: 94)
                .background(Color(red: 0.95, green: 0.95, blue: 0.94))
                .offset(x: 2.50, y: 151)
                .frame(width: 343, height: 396)
                .cornerRadius(24)
                .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.12), radius: 5, y: 4)
                
                Image("win\(index)")
                    .resizable()
                    .foregroundColor(.clear)
                    .frame(width: 110, height: 140)
                    .offset(x: -115, y: -127)
            }
        }
    }
struct winnerimages:View {
    var body: some View {
        ScrollView {
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
                        Image("winner2")
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
                    Image("coffee1")
                )
                .cornerRadius(24)
                
                ZStack() {
                    // Winner name (comes from database)
                    Text("gh_12")
                        .font(Font.custom("SF Pro", size: 24).weight(.bold))
                        .foregroundColor(.black)
                        .offset(x: -80.51, y: -1.87)
                    
                    HStack() {
                        // 99K (comes from database)
                        Text("99K")
                            .font(Font.custom("SF Pro", size: 20))
                            .foregroundColor(.black)
                            .offset(x: 0, y: -2.46)
                            
                        Image("fire")
                            .resizable()
                            .foregroundColor(.clear)
                            .frame(width: 40, height: 46)
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
                    Image("coffee2")
                )
                .cornerRadius(24)
                
                ZStack() {
                    // Winner name (comes from database)
                    Text("mm_h53")
                        .font(Font.custom("SF Pro", size: 24).weight(.bold))
                        .foregroundColor(.black)
                        .offset(x: -80.51, y: -1.87)
                    
                    HStack() {
                        // 99K (comes from database)
                        Text("99K")
                            .font(Font.custom("SF Pro", size: 20))
                            .foregroundColor(.black)
                            .offset(x: 0, y: -2.46)
                            
                        Image("fire")
                            .resizable()
                            .foregroundColor(.clear)
                            .frame(width: 40, height: 46)
                            .offset(x: 0, y: -2.46)
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
                    Image("coffee3")
                )
                .cornerRadius(24)
                
                ZStack() {
                    // Winner name (comes from database)
                    Text("sa-d66")
                        .font(Font.custom("SF Pro", size: 24).weight(.bold))
                        .foregroundColor(.black)
                        .offset(x: -80.51, y: -1.87)
                    
                    HStack() {
                        // 99K (comes from database)
                        Text("99K")
                            .font(Font.custom("SF Pro", size: 20))
                            .foregroundColor(.black)
                            .offset(x: 0, y: -2.46)
                            
                        Image("fire")
                            .resizable()
                            .foregroundColor(.clear)
                            .frame(width: 40, height: 46)
                            .offset(x: 0, y: -2.46)
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

//#Preview {
//    ExploerView2()
//}
