//
//  PlanManager.swift
//  IOSGroupWork
//
//  Created by Ramon Peralta on 29/1/25.
//

import MapKit
import Foundation

class PlanManager:ObservableObject {
   /*
    static func savePlanes(planes:[WorkoutPlan]){
        if let encoded = try? JSONEncoder().encode(planes) {
            UserDefaults.standard.set(encoded, forKey: "planes")
        }
    }
  */
    static func saveMyPlanId(planId:Int){
        UserDefaults.standard.set(planId, forKey: "planId")
    }
    
    static func getmyPlanId() -> Int {
        let planId: Int = UserDefaults.standard.integer(forKey: "planId")
        return planId;
    }
}
