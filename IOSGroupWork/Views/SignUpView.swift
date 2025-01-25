//
//  SignUpView.swift
//  IOSGroupWork
//
//  Created by Alejandro Berraondo Soria on 22/1/25.
//

import SwiftUI

struct SignUpView: View {
    @Binding  var showSignUp: Bool
    
    @State private var userAuthentication = UserAuth()
    
    @State private var email: String = ""
    @State private var userName: String = ""
    @State private var password: String = ""
    @State private var passwordValidate: String = ""
    @State private var showAlert: Bool = false
        
    @State var users = UserDefaults.standard.dictionary(forKey: "users") as? [String: String] ?? [:]
    @State var emailsUsers = UserDefaults.standard.dictionary(forKey: "emails") as? [String: String] ?? [:]
    
    var body: some View {
        VStack(alignment: .leading,spacing: 20,content: {
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
                    //USER SIGN UP VALIDATION
                    users = UserDefaults.standard.dictionary(forKey: "users") as? [String: String] ?? [:]
                    emailsUsers = UserDefaults.standard.dictionary(forKey: "emails") as? [String: String] ?? [:]
                    
                    userAuthentication.userName = userName
                    userAuthentication.email = email
                    userAuthentication.password = password
                    userAuthentication.passwordValidate = passwordValidate
                    
                    userAuthentication.users = users
                    userAuthentication.emailsUsers = emailsUsers
                    
                    if(!userAuthentication.authenticateUser()){
                        showAlert = true
                    }
                    else{
                        //Esctitura inmediata
                        UserDefaults.standard.synchronize()
                        showSignUp.toggle()
                    }
                }
                .buttonStyle(.borderedProminent)
                .disabled(email.isEmpty || password.isEmpty||userName.isEmpty||passwordValidate.isEmpty)
                .alert(isPresented: $showAlert){
                    Alert(title: Text("No se pudo registrar User"), message: Text(userAuthentication.errorMessage), dismissButton: .default(Text("OK")))
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
}

struct UserAuth{
    var users:[String: String] = [:]
    var emailsUsers:[String: String] = [:]
    var userName: String = ""
    var email: String = ""
    var password: String = ""
    var passwordValidate: String = ""
    var showAlert: Bool = false
    var errorMessage: String = ""
    
    mutating func authenticateUser() -> Bool{
        
        if(users.keys.contains(userName)){
            errorMessage = "This username is already taken. Please choose another one"
            return false
        }
        
        if(emailsUsers.keys.contains(email)){
            errorMessage = "This email is already taken. Please choose another one"
            return false
        }
        
        //Pending validate user in a data
        if(password != passwordValidate){
            errorMessage = "Sign up failed. Password does not match"
            return  false
        }
        
        //Adding user to UserDefaults
        users[userName] = password
        UserDefaults.standard.set(users, forKey: "users")

        emailsUsers[email] = password
        UserDefaults.standard.set(emailsUsers, forKey: "emailsUsers")
        
        return true
    }
    
}


#Preview {
    SignUpView(showSignUp:.constant(true))
}
