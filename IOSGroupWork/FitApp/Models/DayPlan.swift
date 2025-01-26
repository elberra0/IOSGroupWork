//
//  DayPlan.swift
//  IOSGroupWork
//
//  Created by Ramon Peralta on 26/1/25.
//

struct DayPlan: Codable {
    let tipo: String
    let calentamiento: String?
    let ejercicios: [Exercise]
    let enfriamiento: String?
}
