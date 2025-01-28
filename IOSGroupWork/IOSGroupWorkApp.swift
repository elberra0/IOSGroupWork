//
//  IOSGroupWorkApp.swift
//  IOSGroupWork
//
//  Created by Alejandro Berraondo Soria on 21/1/25.
//

import SwiftUI

@main
struct IOSGroupWorkApp: App {
    @StateObject private var userManager = UserManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(userManager)
        }
    }
}
