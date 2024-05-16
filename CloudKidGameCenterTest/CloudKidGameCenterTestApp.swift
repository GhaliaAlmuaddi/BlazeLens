//
//  CloudKidGameCenterTestApp.swift
//  CloudKidGameCenterTest
//
//  Created by Ghalia Mohammed Al Muaddi on 19/10/1445 AH.
//

import SwiftUI

@main
struct CloudKidGameCenterTestApp: App {
    @StateObject var VM = ChallengeViewModel()
    var body: some Scene {
        WindowGroup {
            AddingPointsView()
                .environmentObject(VM)
        }
    }
    

}
