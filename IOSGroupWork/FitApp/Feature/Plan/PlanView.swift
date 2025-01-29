//
//  PlanView.swift
//  IOSGroupWork
//
//  Created by Ramon Peralta on 29/1/25.
//
//
//  TestInfoView.swift
//  IOSGroupWork
//
//  Created by Ramon Peralta on 27/1/25.
//
import SwiftUI

struct PlanView: View {
    let myPlan =  PlanManager.getmyPlan()
    var body: some View {
        
        VStack(alignment: .leading,spacing: 20,content: {
            Spacer(minLength: 30)
            Group{
                Text(myPlan.clasificacion)
                    .foregroundStyle(.white)
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("Hoy es un buen día para estar en forma.")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundStyle(.gray)
                    .padding(.top, -10)
            }
            .padding(.horizontal, 25)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    EjerciciosList(workoutData: myPlan).foregroundStyle(.white)
                    ConsejosSection(workoutData: myPlan).foregroundStyle(.white)
                    NutricionSection(workoutData: myPlan).foregroundStyle(.white)
                    PlanComidaSection(workoutData: myPlan).foregroundStyle(.white)
                }
                .padding(16)
            }
        })
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.customBlue)
        .edgesIgnoringSafeArea(.all)
    }
}


struct PlanView_Previews: PreviewProvider {
    static var previews: some View {
        PlanView()
    }
}

