//
//  AppLoggedIn.swift
//  IOSGroupWork
//
//  Created by Alejandro Berraondo Soria on 28/1/25.
//

import SwiftUI

struct AppLoggedIn: View {
    var body: some View {
        TabView {
            Tab("Fit Test", systemImage: "heart.fill") {
                NavigationStack {
                    //AQUI EL FORM
                }
            }
            
            Tab("Map", systemImage: "map") {
                NavigationStack {
                    MapGymsNearbyView()
                }
                .background(Color.white)
                .foregroundStyle(.white)
            }
            
            Tab("Settings", systemImage: "gear") {
                NavigationStack {
                    SettingsView()
                }
            }
            
        }
        .tint(Color.white)
        .onAppear {
            UITabBar.appearance().unselectedItemTintColor = UIColor.gray
        }
    }
}

#Preview {
    AppLoggedIn()
}
