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
        Section(header:
                    Text("Esta es tu rutina para el \(day.capitalized):")
                    .foregroundStyle(.white)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top, -20)
        ) {
            Text("\(dayData.tipo)")
                .font(.headline)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity, alignment: .center)
            Text("Calentamiento: \(dayData.calentamiento ?? "No especificado")")
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity, alignment: .center)
            
            EjerciciosListView(ejercicios: dayData.ejercicios)

            if let enfriamiento = dayData.enfriamiento {
                Text("Enfriamiento: \(enfriamiento)")
                    .italic()
            }
        }
    }
}
