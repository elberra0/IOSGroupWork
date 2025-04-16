//
//  TestInfoView.swift
//  IOSGroupWork
//
//  Created by Ramon Peralta on 27/1/25.
//
import SwiftUI

struct TestInfoView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.verticalSizeClass) var verticalSizeClass

    @State private var age: String = ""
    @State private var sex: String = ""
    @State private var weight: String = ""
    @State private var height: String = ""
    @State private var objetivo: String = ""
    @State private var showAlert: Bool = false
    @State private var showAlertPlan: Bool = false
    @State private var stringBuilder: String = ""
    let _APIPersistenceService: APIPersistenceService
    let sexOptions = ["Masculino", "Femenino"]
    let objetivoOptions = ["Perder peso", "Ganar masa muscular", "Mantener peso"]
    init() {
     _APIPersistenceService = APIPersistenceService.shared
     _APIPersistenceService.load()
    }
    var body: some View {
       
        
        VStack(alignment: .leading,spacing: 20,content: {
            Spacer(minLength: verticalSizeClass == .compact ? 20 : 70)
            Group{
                Text("Test Plan")
                    .foregroundStyle(.white)
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("Determinar el plan de ejercicios")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundStyle(.gray)
                    .padding(.top, -10)
            }
            .padding(.horizontal, 25)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    TextField("Edad", text: $age)
                        .keyboardType(.numberPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .accessibilityLabel("Campo de edad")
                    
                    Picker("Sexo", selection: $sex) {
                        ForEach(sexOptions, id: \.self) { option in
                            Text(option)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .accessibilityLabel("Selección de sexo")
                    
                    TextField("Peso actual (kg)", text: $weight)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .accessibilityLabel("Campo de peso")
                    
                    TextField("Altura (cm)", text: $height)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .accessibilityLabel("Campo de altura")
                    
                    Picker("Objetivo", selection: $objetivo) {
                        ForEach(objetivoOptions, id: \.self) { option in
                            Text(option)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .accessibilityLabel("Objetivo")
                    
                    Button(action: onSubmitClick) {
                        Text("Enviar")
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .alert("¡Aviso!", isPresented: $showAlertPlan) {
                    Button("Ok", role: .none) {
                        stringBuilder = ""
                        showAlert = false
                        dismiss()
                    }
                } message: {
                    Text(stringBuilder)
                }
                .padding(16)
                .alert("¡Aviso!", isPresented: $showAlert) {
                    Button("Ok", role: .none) {
                        stringBuilder = ""
                        showAlert = false
                    }
                } message: {
                    Text(stringBuilder)
                }
            }
        })
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.customBlue)
        .edgesIgnoringSafeArea(.all)
    }
    
    func onSubmitClick() {
        
        if age  == ""
        {
            stringBuilder.append("Debe espeficiar su edad. \n")
        }
        
        if sex  == ""
        {
            stringBuilder.append("Debe espeficiar su sexo. \n")
        }
        
        if weight  == ""
        {
            stringBuilder.append("Debe espeficiar su peso. \n")
        }
        
        if height  == ""
        {
            stringBuilder.append("Debe espeficiar su altura. \n")
        }
        
        if objetivo  == ""
        {
            stringBuilder.append("Debe elegir un objetivo. \n")
        }
        
        if stringBuilder == ""
        {
            let puntos =  evaluarPuntos()
            
            var planId = 0
           
            switch puntos {
            case 0...7:
                planId = 3
            case 8...11:
                planId = 2
            case 12...99:
                planId = 1
            default:
                planId = 0
            }
            PlanManager.saveMyPlanId(planId: planId)
            stringBuilder = try! _APIPersistenceService.getPlanById(plandId: planId).clasificacion
            showAlertPlan = true
        }
        else
        {
            showAlert = true
        }
    }
    
    private func evaluarPuntos() -> Int {
        var puntosPuntos = 0

        switch Int(age)! {
        case 18...30:
            puntosPuntos += 3
        case 31...50:
            puntosPuntos += 2
        default:
            puntosPuntos += 1
        }

        switch sex {
        case "Hombre":
            puntosPuntos += 2
        default:
            puntosPuntos += 1
        }

        switch Double(weight)! {
        case 0.0...59.0:
            puntosPuntos += 2
        case 60.0...80.0:
            puntosPuntos += 1
        default:
            puntosPuntos += 3
        }

        switch  Double(height)! {
        case 0.0...159.99:
            puntosPuntos += 1
        case 160...180.00:
            puntosPuntos += 2
        default:
            puntosPuntos += 3
        }

        switch objetivo {
        case "Mantener peso":
            puntosPuntos += 2
        default:
            puntosPuntos += 3
        }

        return puntosPuntos
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TestInfoView()
    }
}
