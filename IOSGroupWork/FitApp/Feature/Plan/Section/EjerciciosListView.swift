//
//  EjerciciosListView.swift
//  IOSGroupWork
//
//  Created by Ramon Peralta on 29/1/25.
//
import SwiftUI
struct EjerciciosListView: View {
    let ejercicios: [Exercise]

    var body: some View {
        ForEach(ejercicios, id: \..nombre) { ejercicio in
            EjercicioRow(ejercicio: ejercicio)
        }
    }
}
