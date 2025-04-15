//
//  HomeView.swift
//  IOSGroupWork
//
//  Created by Ramon Peralta on 29/1/25.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    @State private var isShowingTestInfoView = false
    @State private var isShowingPlanView = false
    @State private var showAlert = false
    var body: some View {
        ZStack {
            Color(Color.customBlue)
                .edgesIgnoringSafeArea(.all)
            
            Button(action: {
                isShowingTestInfoView = true
            }) {
                Text("Do test")
                    .padding()
                    .background(Color.white)
                    .foregroundColor(.customBlue)
                    .cornerRadius(10)
            }
            .sheet(isPresented: $isShowingTestInfoView) {
                TestInfoView()
            }
            .offset(y: -100)

           
            Button(action: {
                if PlanManager.getmyPlan().id > 0
                {
                    isShowingPlanView = true
                }
                else{
                    
                    isShowingPlanView = false
                    showAlert = true
                }
                
            }) {
                Text("My plan")
                    .padding()
                    .background(Color.white)
                    .foregroundColor(.customBlue)
                    .cornerRadius(10)
            }
            .alert("¡Aviso!", isPresented: $showAlert) {
                Button("Ok", role: .none) {
                    showAlert = false
                }
            } message: {
                Text("Debe elegir un plan antes de iniciar.")
            }
            .sheet(isPresented: $isShowingPlanView) {
                PlanView()
            }
            .offset(y: 100)
            
            VStack {
                Spacer()
                Rectangle()
                    .fill(Color.navigationBarBlue)
                    .frame(maxWidth: .infinity)
                    .frame(height: verticalSizeClass == .compact ? 65 : 100)
            }
            .frame(maxWidth: .infinity)
        }
        .ignoresSafeArea()
    }
}
