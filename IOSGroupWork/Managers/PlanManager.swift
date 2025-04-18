//
//  PlanManager.swift
//  IOSGroupWork
//
//  Created by Ramon Peralta on 29/1/25.
//


import Foundation

class PlanManager:ObservableObject {
    
    static func saveMyPlanId(planId:Int){
        UserDefaults.standard.set(planId, forKey: "planId")
    }
    
    static func getmyPlanId() -> Int {
        let planId: Int = UserDefaults.standard.integer(forKey: "planId")
        return planId;
    }
    
    static func saveRefreshTimeStamp(_ date: Date) {
        let isoFormatter = ISO8601DateFormatter()
        let isoString = isoFormatter.string(from: date)
        
        UserDefaults.standard.set(isoString, forKey: "refreshTimestampKey")
    }
    
     static func getRefreshTimeStamp() -> Date? {
        if let isoString = UserDefaults.standard.string(forKey: "refreshTimestampKey") {
            let isoFormatter = ISO8601DateFormatter()
            return isoFormatter.date(from: isoString)
        }
        return nil
    }
    
}
