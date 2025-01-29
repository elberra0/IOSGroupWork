//
//  AlimentoSection.swift
//  IOSGroupWork
//
//  Created by Ramon Peralta on 29/1/25.
//
import SwiftUI

struct AlimentoSection: View {
    let planComidas: Meal
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(planComidas.alimentos, id: \..self) { alimento in
                Text("* \(alimento)." )
            }
        }
    }
}

