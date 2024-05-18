//
//  NewPage.swift
//  CloudKidGameCenterTest
//
//  Created by shomokh aldosari on 10/11/1445 AH.
//

import SwiftUI
struct NewPage: View {
    @StateObject private var cloudKitHelper = CloudKitHelper()

    var body: some View {
        ZStack {
            CarouselView(views: getHelperView())
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("backgroungC"))
    }
    
    func getHelperView() -> [CarouselViewHelper] {
        var tempViews: [CarouselViewHelper] = []
        
        for (index, image) in cloudKitHelper.images.enumerated() {
            tempViews.append(CarouselViewHelper(id: index, content: {
                ZStack {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .mask {
                            RoundedRectangle(cornerRadius: 40)
                                .frame(width: 300, height: 500)
                        }
                }
                .frame(width: 300, height: 500)
                .shadow(radius: 20)
            }))
        }
        return tempViews
    }
}

struct CarouselViewHelper: Identifiable {
    let id: Int
    let content: () -> AnyView
    
    init<Content: View>(id: Int, @ViewBuilder content: @escaping () -> Content) {
        self.id = id
        self.content = { AnyView(content()) }
    }
}

struct CarouselView: View {
    let views: [CarouselViewHelper]

    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 16) {
                ForEach(views) { viewHelper in
                    viewHelper.content()
                }
            }
        }
    }
}


#Preview {
    NewPage()
}
