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
                    .background(Color.blue)
                    .foregroundColor(.white)
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
                    .background(Color.blue)
                    .foregroundColor(.white)
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
        }
    }
}
