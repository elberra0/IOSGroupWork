//
//  TestInfoView.swift
//  IOSGroupWork
//
//  Created by Ramon Peralta on 27/1/25.
//
import SwiftUI

struct TestInfoView: View {
    
    @State private var age: String = ""
    @State private var sex: String = ""
    @State private var weight: String = ""
    @State private var height: String = ""
    @State private var objetivo: String = ""
    @State private var showAlert: Bool = false
    @State private var stringBuilder: String = ""
    
    let sexOptions = ["Masculino", "Femenino"]
    let objetivoOptions = ["Perder peso", "Ganar masa muscular", "Mantener peso"]
    
    var body: some View {
        VStack(alignment: .leading,spacing: 20,content: {
            Spacer(minLength: 100)
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
                .padding(16)
                .alert("¡Aviso!", isPresented: $showAlert) {
                    Button("Ok", role: .cancel) {
                        stringBuilder = ""
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
        
        showAlert = stringBuilder != ""
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TestInfoView()
    }
}
