//
//  EjercicioRow.swift
//  IOSGroupWork
//
//  Created by Ramon Peralta on 29/1/25.
//
import SwiftUI
struct EjercicioRow: View {
    let ejercicio: Exercise

    var body: some View {
        VStack(alignment: .leading) {
            Text(ejercicio.nombre ?? "")
                .font(.subheadline)
            if let series = ejercicio.series, let repeticiones = ejercicio.repeticiones {
                Text("Series: \(series) - Repeticiones: \(repeticiones)")
            } else if let descripcion = ejercicio.nombre {
                Text(descripcion)
            }
        }
    }
}
