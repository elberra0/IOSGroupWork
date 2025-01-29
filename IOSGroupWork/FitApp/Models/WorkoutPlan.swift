//
//  WorkoutPlan.swift
//  IOSGroupWork
//
//  Created by Ramon Peralta on 26/1/25.
//

struct WorkoutPlan: Codable {
    let id: Int
    let clasificacionid: Int
    let clasificacion: String
    let ejercicios: [String: DayPlan]
    let consejos: [String]
    var nutricion: Nutrition
}
