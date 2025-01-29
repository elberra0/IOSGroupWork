//
//  PlanManager.swift
//  IOSGroupWork
//
//  Created by Ramon Peralta on 29/1/25.
//

import MapKit
import Foundation

class PlanManager:ObservableObject {
    
    static func savePlanes(planes:[WorkoutPlan]){
        if let encoded = try? JSONEncoder().encode(planes) {
            UserDefaults.standard.set(encoded, forKey: "planes")
        }
    }
    
    static func saveMyPlanId(planId:Int){
        UserDefaults.standard.set(planId, forKey: "planId")
    }
    
    static func getPlanById(planId: Int) -> WorkoutPlan {
        let planes = UserDefaults.standard.data(forKey: "planes")
        let localPlanes = try! JSONDecoder().decode([WorkoutPlan].self, from: planes!)
        
        return localPlanes.first(where: {$0.id == planId})!
    }
    
    static func getmyPlan() -> WorkoutPlan {
        let planId: Int = UserDefaults.standard.integer(forKey: "planId")
        return getPlanById(planId: planId)
    }
}
