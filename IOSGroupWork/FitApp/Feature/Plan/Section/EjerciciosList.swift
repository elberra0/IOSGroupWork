//
//  EjerciciosList.swift
//  IOSGroupWork
//
//  Created by Ramon Peralta on 29/1/25.
//
import SwiftUI
struct EjerciciosList: View {
    @State private var expandedDays: [String: Bool] = [
        "lunes": false,
        "martes": false,
        "miercoles": false,
        "jueves": false,
        "viernes": false,
        "sabado": false,
        "domingo": false
    ]
    

    let workoutData: WorkoutPlan
  
   let weekDay = ["lunes","martes","miercoles","jueves", "viernes", "sabado", "domingo"]
    var body: some View {

        ScrollView {
              VStack(spacing: 16) {
                
                  ForEach(weekDay, id: \..self) { dia in
                      
                      VStack(alignment: .leading, spacing: 8) {
                          Button(action: {
                              withAnimation {
                                  expandedDays[dia]?.toggle()
                              }
                          }) {
                              HStack {
                                  Text(dia)
                                      .font(.headline)
                                      .foregroundColor(.white)
                                  Spacer()
                                  Image(systemName: expandedDays[dia] == true ? "chevron.up" : "chevron.down")
                                      .foregroundColor(.gray)
                              }
                              .padding()
                              .background(Color.customBlue)
                              .cornerRadius(12)
                          }
                        
                          if expandedDays[dia] == true {
                              VStack(alignment: .leading, spacing: 6) {
                                  if let rutina = workoutData.ejercicios[dia] {
                                      EjercicioSection(day: dia, dayData: rutina)
                                  }
                              }
                              .padding(.horizontal)
                              .transition(.opacity)
                          }
                      }
                      .padding(.horizontal)
                  }
              }
              .padding(.top)
          }
        .onAppear {
            let dia = obtenerDiaActual()
                .replacingOccurrences(of: "miércoles", with: "miercoles")
                .replacingOccurrences(of: "sábado", with: "sabado")
            
            expandedDays[dia] = true
        }
        
        .background(Color.customBlue)
          .ignoresSafeArea(edges: .bottom)
    }
    
    func obtenerDiaActual() -> String {
       let date = Date()
  
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "es_ES")
        formatter.dateFormat = "EEEE"
        
        return formatter.string(from: date)
    }
}
