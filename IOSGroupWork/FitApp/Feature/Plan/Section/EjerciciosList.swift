//
//  EjerciciosList.swift
//  IOSGroupWork
//
//  Created by Ramon Peralta on 29/1/25.
//
import SwiftUI
struct EjerciciosList: View {
    let workoutData: WorkoutPlan
    let weekDay = ["lunes","martes","miercoles","jueves", "viernes", "sabado", "domingo"]
    var body: some View {
        ForEach(weekDay, id: \..self) { dia in
            if let rutina = workoutData.ejercicios[dia] {
                EjercicioSection(day: dia, dayData: rutina)
            }
        }
    }
}
