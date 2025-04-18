//
//  PersistenceController.swift
//  IOSGroupWork
//
//  Created by Ramon Peralta on 17/4/25.
//
import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name:"ModelFitApp")
        container.loadPersistentStores {
            storeDescription, error in
            debugPrint(storeDescription.url!)
            if let error = error as NSError? {
                fatalError("Error al cargar Core Data: \(error), \(error.userInfo)")
            }
        }
    }
    
    var viewContext: NSManagedObjectContext {
        return container.viewContext
    }
    
    func getAll() throws -> [WorkoutPlan] {
        let fetchRequest: NSFetchRequest<PlanEntity> = PlanEntity.fetchRequest()
        
        let context = container.viewContext
        
        do {
            let planEntities = try context.fetch(fetchRequest)
            
            let planes: [WorkoutPlan] = try planEntities.map { entity in
                let jsonData = entity.ejercicios!.data(using: .utf8)
                let decoded = try JSONDecoder().decode([String: DayPlan].self, from: jsonData!)
                
                let WorkoutPlan = WorkoutPlan(
                    id: Int(entity.id),
                    clasificacionid: Int(entity.clasificacionId),
                    clasificacion: entity.clafisicacion ?? String(),
                    ejercicios: decoded
                )
                
                return WorkoutPlan
            }
            
            return planes
        } catch {
            throw error
        }
    }
    
    
    func deleteAll() {
        let context = container.viewContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = PlanEntity.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
            print("Datos eliminados correctamente")
        } catch {
            print("Error al borrar datos: \(error)")
        }
    }
    
    func getPlanById(planId: Int) -> WorkoutPlan {
       
        let context = container.viewContext
        
        let fetchRequestPlanEntity: NSFetchRequest<PlanEntity> = PlanEntity.fetchRequest()
        fetchRequestPlanEntity.predicate = NSPredicate(format: "id == %d", planId)

        
        do {
            
            if let planEntityResults = try context.fetch(fetchRequestPlanEntity).first {
                let jsonData = planEntityResults.ejercicios!.data(using: .utf8)
                let decoded = try JSONDecoder().decode([String: DayPlan].self, from: jsonData!)
                
                let WorkoutPlan = WorkoutPlan(
                    id: Int(planEntityResults.id),
                    clasificacionid: Int(planEntityResults.clasificacionId),
                    clasificacion: planEntityResults.clafisicacion ?? String(),
                    ejercicios: decoded
                )
                return WorkoutPlan
            }
            
        } catch {
            print("Error al actualizar")
        }
        return WorkoutPlan(id: 0, clasificacionid: 0, clasificacion: "", ejercicios: [:]
        )
    }
}
