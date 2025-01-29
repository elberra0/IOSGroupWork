//
//  FitAppServices.swift
//  IOSGroupWork
//
//  Created by Ramon Peralta on 26/1/25.
//

import Foundation

@Observable
final class APIPersistenceService {
    static let shared = APIPersistenceService()
    
    private init() {}
    
    private let apiKey = ""
    private let pathGetPlanes = "getplanes"
    private let pathGetPlanById = "getplanbyId"
    
    private(set) var workoutPlan: [WorkoutPlan] = []
    private let urlServer = "https://invoicegen.gear.host/api/FitApp/"
    
    func load() {
        Task{
            workoutPlan = try await getAll()
            PlanManager.savePlanes(planes: workoutPlan)
        }
    }
    
    func getPlanById(plandId: Int) throws -> WorkoutPlan {
        return try PlanManager.getPlanById(planId: plandId)
    }
    
    func getAll() async throws -> [WorkoutPlan] {
    
        guard let url = URL(string: urlServer + pathGetPlanes) else { throw URLError(.badURL) }
      
        let (data,_) = try await URLSession.shared.data(from: url)
        
        let decoded = try JSONDecoder().decode([WorkoutPlan].self, from: data)
 
        return decoded
    }
}
