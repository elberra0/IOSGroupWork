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
    let sexOptions = ["Gender", "Male", "Female"]
    let objetivoOptions = ["Goal", "Lose weight", "Gain muscle mass", "Maintain weight"]
    init() {
     _APIPersistenceService = APIPersistenceService.shared
     _APIPersistenceService.load()
    }
    var body: some View {
       
        
        VStack(alignment: .leading,spacing: 20,content: {
            Spacer(minLength: verticalSizeClass == .compact ? 20 : 70)
            Group{
                Text("Do Test")
                    .foregroundStyle(.white)
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("Determine the exercise plan")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundStyle(.gray)
                    .padding(.top, -10)
            }
            .padding(.horizontal, 25)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    TextField("Age", text: $age)
                        .keyboardType(.numberPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .accessibilityLabel("Age field")
                    
                    Picker("Gender", selection: $sex) {
                        ForEach(sexOptions, id: \.self) { option in
                            Text(option)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .accessibilityLabel("Gender selection")
                    
                    TextField("Current weight (kg)", text: $weight)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .accessibilityLabel("Weight field")
                    
                    TextField("Current height (cm)", text: $height)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .accessibilityLabel("High field")
                    
                    Picker("Goal", selection: $objetivo) {
                        ForEach(objetivoOptions, id: \.self) { option in
                            Text(option)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .accessibilityLabel("Goal")
                    
                    Button(action: onSubmitClick) {
                        Text("Let's go")
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            //.frame(minWidth: verticalSizeClass == .compact ? 600 : 300, maxHeight: 40,alignment:.center)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .background(Color.white)
                            .foregroundColor(.customBlue)
                            .cornerRadius(8)
                    }
                    .padding(.top,50)

                }
                .alert("Warning!", isPresented: $showAlertPlan) {
                    Button("Ok", role: .none) {
                        stringBuilder = ""
                        showAlert = false
                        dismiss()
                    }
                } message: {
                    Text(stringBuilder)
                }
                .padding(16)
                .alert("Warning!", isPresented: $showAlert) {
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
        .onAppear {
            objetivo = "Goal"
            sex = "Gender"
        }
    }
    
    func onSubmitClick() {
        
        if age  == ""
        {
            stringBuilder.append("You must specify your age. \n")
        }
        
        if sex  == "" || sex == "Gender"
        {
            stringBuilder.append("You must specify your gender. \n")
        }
        
        if weight  == ""
        {
            stringBuilder.append("You must specify your weight. \n")
        }
        
        if height  == ""
        {
            stringBuilder.append("You must specify your height. \n")
        }
        
        if objetivo  == "" || objetivo == "Goal"
        {
            stringBuilder.append("You must choose a goal. \n")
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
        case "Male":
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
        case "Maintain weight":
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
