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
            /*
            Text(ejercicio.nombre ?? "")
                .font(.subheadline)
            if let series = ejercicio.series, let repeticiones = ejercicio.repeticiones {
                Text("Series: \(series) - Repeticiones: \(repeticiones)")
            } else if let descripcion = ejercicio.nombre {
                Text(descripcion)
            }
             */
            
            Text(ejercicio.nombre!)
                .foregroundColor(.white)
                .font(.system(size: 20))
                .padding(.top, 4)
            if ejercicio.repeticiones?.isEmpty == false
            {
                TextField(
                    "",
                    text: .constant(
                        (ejercicio.repeticiones?.isEmpty == false)
                        ? "De \(ejercicio.repeticiones!) repeticiones en \(ejercicio.series!) series."
                        : ""
                    )
                    
                )
                .disabled(true)
                .font(.system(size: 15))
                .foregroundColor(.white)
                .padding(8)
                .background(Color.customBlue)
                .overlay(
                    RoundedRectangle(cornerRadius: 3)
                        .stroke(Color.gray, lineWidth: 1)
                )
            }
            else
            {
                Divider()
                    .frame(maxWidth: .infinity)
                    .frame(height: 1)
                    .background(Color.gray)
                    .padding(.vertical)
            }
        }
    }
}
