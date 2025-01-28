//
//  WorkoutPlanView.swift
//  IOSGroupWork
//
//  Created by Ramon Peralta on 28/1/25.
//
import SwiftUI

struct WorkoutPlanView: View {
    let workoutData: WorkoutPlan = WorkoutPlan.sampleData

    var body: some View {
        NavigationView {
            List {
                ClasificacionSection(workoutData: workoutData)
              //  EjerciciosList(workoutData: workoutData)
              //  ConsejosSection(workoutData: workoutData)
              //  NutricionSection(workoutData: workoutData)
            }
            .navigationTitle("Plan de Entrenamiento")
        }
    }
}

struct ClasificacionSection: View {
    let workoutData: WorkoutPlan

    var body: some View {
        Section(header: Text(workoutData.clasificacion)) {
            Text("ID de Clasificación: \(workoutData.clasificacionid)")
        }
    }
}

struct EjerciciosList: View {
    let workoutData: WorkoutPlan

    var body: some View {
        ForEach(workoutData.ejercicios.keys.sorted(), id: \..self) { day in
            if let dayData = workoutData.ejercicios[day] {
                EjercicioSection(day: day, dayData: dayData)
            }
        }
    }
}

struct EjercicioSection: View {
    let day: String
    let dayData: DayPlan

    var body: some View {
        Section(header: Text(day.capitalized)) {
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

struct EjerciciosListView: View {
    let ejercicios: [Exercise]

    var body: some View {
        ForEach(ejercicios, id: \..nombre) { ejercicio in
            EjercicioRow(ejercicio: ejercicio)
        }
    }
}

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

struct ConsejosSection: View {
    let workoutData: WorkoutPlan

    var body: some View {
        Section(header: Text("Consejos")) {
            ForEach(workoutData.consejos, id: \..self) { consejo in
                Text(consejo)
            }
        }
    }
}

/*
struct NutricionSection: View {
    let workoutData: WorkoutPlan

    var body: some View {
        Section(header: Text("Nutrición")) {
            VStack(alignment: .leading) {
               Text("Macronutrientes: Carbohidratos \(workoutData.nutricion.principios.macronutrientes.carbohidratos), Proteínas \(workoutData.nutricion.principios.macronutrientes.proteinas), Grasas \(workoutData.nutricion.principios.macronutrientes.grasas)")
                Text("Hidratación: \(workoutData.nutricion.principios.comidas.hidratacion)")
                Text("Pre/Post Entrenamiento: \(workoutData.nutricion.principios.comidas.pre_post_entrenamiento)")
            }
            
          ForEach(workoutData.nutricion.planComidas.keys.sorted(), id: \..self) { comida in
                if let alimentos = workoutData.nutricion.planComidas[comida] {
                    Section(header: Text(comida.capitalized)) {
                        ForEach(alimentos, id: \..self) { alimento in
                            Text(alimento)
                        }
                    }
                }
            }
    

            Section(header: Text("Suplementos")) {
                ForEach(workoutData.nutricion.suplementos.keys.sorted(), id: \..self) { suplemento in
                    if let detalle = workoutData.nutricion.suplementos[suplemento] {
                        Text("\(suplemento.capitalized): \(detalle)")
                    }
                }
            }
        }
    }
}
*/



struct DiaEjercicio: Codable {
    let tipo: String
    let calentamiento: String?
    let ejercicios: [Ejercicio]
    let enfriamiento: String?
}

struct Ejercicio: Codable {
    let nombre: String
    let series: Int?
    let repeticiones: String?
    let descripcion: String?
}

struct Nutricion: Codable {
    let principios: Principios
    let planComidas: [String: [String]]
    let suplementos: [String: String?]
}

struct Principios: Codable {
    let macronutrientes: Macronutrientes
    let comidas: Comidas
}

struct Macronutrientes: Codable {
    let carbohidratos: String
    let proteinas: String
    let grasas: String
}

struct Comidas: Codable {
    let pre_post_entrenamiento: String
    let hidratacion: String
}
/*
struct ContentplanView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutPlanView()
    }
}
*/
