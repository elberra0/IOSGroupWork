//
//  SignUpView.swift
//  IOSGroupWork
//
//  Created by Alejandro Berraondo Soria on 22/1/25.
//

import SwiftUI

struct SignUpView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @Binding  var showSignUp: Bool
        
    @State private var errorMessage: String = ""
    @State private var email: String = ""
    @State private var userName: String = ""
    @State private var password: String = ""
    @State private var passwordValidate: String = ""
    @State private var showAlert: Bool = false
    
    @State var users = UserDefaults.standard.dictionary(forKey: "users") as? [String: String] ?? [:]
    
    var body: some View {
        VStack(alignment: .leading,spacing: 20,content: {
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Label("Back", systemImage: "arrow.left")
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 10)
            
            Group{
                Text("Sign Up")
                    .foregroundStyle(.white)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top,50)
                
                Text("Sign up to access the FitAPP")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundStyle(.gray)
                    .padding(.top, -10)
            }
            .padding(.horizontal, 25)
            
            VStack(spacing:20){
                //Text fields
                TextViewCustom(icon:"at", hint:"Email", value: $email)
                
                TextViewCustom(icon:"person", hint:"User Name", value: $userName)
                
                TextViewCustom(icon:"lock", hint:"Password",isPassword: true, value: $password)
                
                TextViewCustom(icon:"lock", hint:"Confirm Password",isPassword: true, value:$passwordValidate)
                
                Button("Sign up"){
                    let userValidation = userAuth()
                    
                    if(userValidation){
                        showAlert = true
                    }else{
                        let user = User(username: userName, password: password, email: email)
                        UserManager.addUser(user: user)
                                            
                        showSignUp.toggle()
                    }
                }
                .buttonStyle(.borderedProminent)
                .disabled(email.isEmpty || password.isEmpty||userName.isEmpty||passwordValidate.isEmpty)
                .alert(isPresented: $showAlert){
                    Alert(title: Text("No se pudo registrar User"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
                }
                
                VStack{
                    Text("Already have an account?")
                        .foregroundStyle(.gray)
                    Button("Log In"){
                        showSignUp.toggle()
                    }
                    .foregroundStyle(.blue)
                }.padding(.top,50)
                
            }
            .padding(.top, 20)
            .padding(.vertical, 20)
            .padding(.horizontal, 30)
            .toolbar(.hidden, for: .navigationBar)
            
            Spacer(minLength: 0)
        })
        .background(Color.customBlue)
    }
    
    func userAuth()-> Bool{
        if(UserManager.userExists(userName:userName)){
            errorMessage = "This username is already taken. Please choose another one"
            return true
        }
        
        if(UserManager.userExists(email:email)){
            errorMessage = "This email is already taken. Please choose another one"
            return true
        }
        
        //Pending validate user in a data
        if(password != passwordValidate){
            errorMessage = "Sign up failed. Password does not match"
            return  true
        }
        return false
    }
}


#Preview {
    SignUpView(showSignUp:.constant(true))
}
