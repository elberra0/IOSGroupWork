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
    
    private let pathGetPlanes = "getplanes"
    private let pathGetClasificaciones = "getclasificaciones"
    
    private(set) var workoutPlan: [WorkoutPlan] = []
    private let urlServer = "https://invoicegen.gear.host/api/FitApp/"
    
    func load() {
        Task{
            workoutPlan = try await getAll()
            // PlanManager.savePlanes(planes: workoutPlan)
        }
    }
    
    func getPlanById(plandId: Int) throws -> WorkoutPlan {
        return  PersistenceController.shared.getPlanById(planId: plandId)
    }
    
    func getAll() async throws -> [WorkoutPlan] {
        
        let planes = try PersistenceController.shared.getAll()
        var expired = true
        if let lastRefreshDate = PlanManager.getRefreshTimeStamp() {
            let sieteDiasAtras = Calendar.current.date(byAdding: .day, value: -7, to: Date())!
            expired = lastRefreshDate < sieteDiasAtras
        }
        
        return (planes.count == 0 || expired) ? try await updatePlanes() : planes
    }
    
    
    func updatePlanes() async throws -> [WorkoutPlan] {
        
        PersistenceController.shared.deleteAll()
        
        guard let url = URL(string: urlServer + pathGetPlanes) else { throw URLError(.badURL) }
        
        let (data,_) = try await URLSession.shared.data(from: url)
        
        let decoded = try JSONDecoder().decode([WorkoutPlan].self, from: data)
        decoded.forEach { item in
            let planEntity = PlanEntity(context: PersistenceController.shared.container.viewContext)
            planEntity.id = Int16(item.id)
            planEntity.clasificacionId = Int16(item.clasificacionid)
            planEntity.clafisicacion = item.clasificacion
            
            do {
                let ejercicios = try JSONEncoder().encode(item.ejercicios)
                let jsonString = String(data: ejercicios, encoding: .utf8)
                planEntity.ejercicios = jsonString
                try PersistenceController.shared.viewContext.save()
                print("¡Guardado con éxito! ID: ", planEntity.id)
            } catch {
                print("Error al guardar: \(error)")
            }
        }
        PlanManager.saveRefreshTimeStamp(Date())
        return try PersistenceController.shared.getAll()
    }
}
