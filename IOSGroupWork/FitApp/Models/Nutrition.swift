//
//  Nutrition.swift
//  IOSGroupWork
//
//  Created by Ramon Peralta on 26/1/25.
//
struct Nutrition: Codable {
    let principios: Principles
    let planComidas: [String: Meal]
    enum CodingKeys: String, CodingKey {
        case planComidas = "plan_comidas"
        case principios
    }
}
