//
//  ContentView.swift
//  IOSGroupWork
//
//  Created by Alejandro Berraondo Soria on 21/1/25.
//

import SwiftUI

extension Color {
    static let customBlue = Color(red: 44 / 255, green: 62 / 255, blue: 80 / 255)
}

struct SplashScreen:View {
    var body: some View {
        ZStack{
            Rectangle()
                .fill(Color.customBlue)
            Image("Logo Icon")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
        }
        .ignoresSafeArea()
    }
}

struct CustomSplashTransition: Transition {
    var isRoot: Bool
    func body(content: Content, phase:TransitionPhase) -> some View {
        content
            .offset(y:phase.isIdentity ? 0 : isRoot ? screenSize.height : -screenSize.height)
    }
    
    ///Current Screen Size
    var screenSize:CGSize{
        if let screenSize = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.screen.bounds.size{
            return screenSize
        }
        
        return .zero
    }
}

struct ContentView: View {
    @State private var showSplashScreen: Bool = true
    
    var body: some View {
        ZStack{
            if showSplashScreen {
                SplashScreen()
                    .transition(CustomSplashTransition(isRoot: false))
            }else{
                RootView()
                    .transition(CustomSplashTransition(isRoot: true))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()
        .task {
            guard showSplashScreen else {return}
            try? await Task.sleep(for: .seconds(0.5))
            withAnimation(.smooth(duration: 0.5)) {
                showSplashScreen = false
            }
        }

    }
    
    var safeArea:UIEdgeInsets {
        if let safeAarea = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.keyWindow?.safeAreaInsets {
            return safeAarea
        }
        return .zero
    }
}

struct RootView:View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world! Git Update")
        }
        .background(.white)
        .padding()
    }
}


#Preview {
    SplashScreen()
}
