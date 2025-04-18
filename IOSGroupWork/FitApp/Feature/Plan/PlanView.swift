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
    let myPlan =  PersistenceController.shared.getPlanById(planId: PlanManager.getmyPlanId() )
    
    var body: some View {
        
        VStack(alignment: .leading,spacing: 20,content: {
            Spacer(minLength: 30)
            Group{
                Text("My Plan")
                    .foregroundStyle(.white)
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("Today is a good dat for fitness")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundStyle(.gray)
                    .padding(.top, -10)
            }
            .padding(.horizontal, 25)
            
            Text(myPlan.clasificacion)
                .foregroundStyle(.white)
                .font(.title3)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity, alignment: .center)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    EjerciciosList(workoutData: myPlan).foregroundStyle(.white)
                    //ConsejosSection(workoutData: myPlan).foregroundStyle(.white)
                    //NutricionSection(workoutData: myPlan).foregroundStyle(.white)
                    //PlanComidaSection(workoutData: myPlan).foregroundStyle(.white)
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

