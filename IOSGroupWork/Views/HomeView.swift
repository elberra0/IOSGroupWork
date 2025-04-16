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
        VStack{
            Spacer(minLength: 0)
            Group{
                Text("FIT APP")
                    .foregroundStyle(.white)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top,verticalSizeClass == .compact ? 10 : 100)
            }
            .padding(.horizontal, 10)
            
            ScrollView {
                Group{
                    Text("Do our fitness test")
                        .foregroundStyle(.white)
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.top,verticalSizeClass == .compact ? 5 : 50)
                    
                    Text("Plan your workouts with your own fitness level")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundStyle(.gray)
                        .padding(.top, -10)
                }
                .padding(.horizontal, 25)
                Button(action: {
                    isShowingTestInfoView = true
                }) {
                    Text("Do test")
                        .padding()
                        .frame(minWidth: verticalSizeClass == .compact ? 600 : 300, maxHeight: 40)
                        .background(Color.white)
                        .foregroundColor(.customBlue)
                        .cornerRadius(10)
                }
                .sheet(isPresented: $isShowingTestInfoView) {
                    TestInfoView()
                }
                .padding(.top, 20)
                
                Group{
                    Text("Review your plan")
                        .foregroundStyle(.white)
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.top,verticalSizeClass == .compact ? 5 : 100)
                    
                    Text("Check your custom workout sessions")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundStyle(.gray)
                        .padding(.top, -10)
                }
                .padding(.horizontal, 25)
                
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
                        .frame(minWidth: verticalSizeClass == .compact ? 600 : 300, maxHeight: 40)
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
                .padding(.top, 20)
            }
            Spacer()
            NavBarBackground()
        }
        .ignoresSafeArea()
        .background(Color.customBlue)
    }
}
