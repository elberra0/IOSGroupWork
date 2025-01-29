//
//  EjercicioSection.swift
//  IOSGroupWork
//
//  Created by Ramon Peralta on 29/1/25.
//
import SwiftUI
struct EjercicioSection: View {
    let day: String
    let dayData: DayPlan

    var body: some View {
        Section(header: Text(day.capitalized).fontWeight(.bold) ) {
            Text("Tipo: \(dayData.tipo)")
                .font(.headline)
            Text("Calentamiento: \(dayData.calentamiento ?? "No especificado")")
            
            EjerciciosListView(ejercicios: dayData.ejercicios)

            if let enfriamiento = dayData.enfriamiento {
                Text("Enfriamiento: \(enfriamiento)")
                    .italic()
            }
        }
    }
}
