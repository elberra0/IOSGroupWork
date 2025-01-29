//
//  HomeView.swift
//  IOSGroupWork
//
//  Created by Ramon Peralta on 29/1/25.
//

import SwiftUI

struct HomeView: View {
    @State private var isShowingTestInfoView = false
    @State private var isShowingPlanView = false
    var body: some View {
        ZStack {
            Color(Color.customBlue)
                .edgesIgnoringSafeArea(.all)
            
            Button(action: {
                isShowingTestInfoView = true
            }) {
                Text("Do test")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .sheet(isPresented: $isShowingTestInfoView) {
                TestInfoView()
            }
            .offset(y: -100)

           
            Button(action: {
                isShowingPlanView = true
            }) {
                Text("My plan")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .sheet(isPresented: $isShowingPlanView) {
                PlanView()
            }
            .offset(y: 100)
        }
    }
}
