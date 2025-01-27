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
    
    //private(set) var workoutPlan: WorkoutPlan? =
    
    private let urlServer = "https://invoicegen.gear.host/api/FitApp/"
    
    func load() {
        Task{
            
            var workoutPlan = try await getAll()
            /*
             Task {
                 var result =  try await APIPersistenceService.shared.getAll()
             }
             */
            
        }
    }
    
    func getPlanById(plandId: Int) async throws -> WorkoutPlan {
        
        var urlComponents = URLComponents(string: urlServer + pathGetPlanById)!
        // Agregar parámetros de consulta
        urlComponents.queryItems = [
            URLQueryItem(name: "id", value: String(plandId))
        ]
        
        let (data,_) = try await URLSession.shared.data(from: urlComponents.url!)
        
        let decoded = try JSONDecoder().decode(WorkoutPlan.self, from: data)
        
        return decoded
    }
    
    func getAll() async throws -> [WorkoutPlan] {
    
        guard let url = URL(string: urlServer + pathGetPlanes) else { throw URLError(.badURL) }
      
        let (data,_) = try await URLSession.shared.data(from: url)
        
        let decoded = try JSONDecoder().decode([WorkoutPlan].self, from: data)
        
        return decoded
    }
}
