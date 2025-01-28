//
//  SignUpView.swift
//  IOSGroupWork
//
//  Created by Alejandro Berraondo Soria on 22/1/25.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var userManager: UserManager
    @Environment(\.presentationMode) var presentationMode
    
    @State private var newSettingsValidation = SettingsValidation()

    @State private var email: String = ""
    @State private var userName: String = ""
    @State private var password: String = ""
    @State private var passwordValidate: String = ""
    @State private var showAlert: Bool = false
        
    @State var users = UserDefaults.standard.dictionary(forKey: "users") as? [String: String] ?? [:]
    @State var emailsUsers = UserDefaults.standard.dictionary(forKey: "emails") as? [String: String] ?? [:]
    
    var body: some View {
        VStack(content: {
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Label("Back", systemImage: "arrow.left")
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 10)
            
            Group{
                Text("Settings")
                    .foregroundStyle(.white)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top,50)
                
                Text("Change your user information")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundStyle(.gray)
                    .padding(.top, -10)
            }
            .padding(.horizontal, 25)

            VStack(spacing:20){
                //Text fields
                TextViewCustom(icon:"at", hint:"New Email", value: $email)
                
                TextViewCustom(icon:"person", hint:"New User Name", value: $userName)
                
                TextViewCustom(icon:"lock", hint:"New Password",isPassword: true, value: $password)
                
                TextViewCustom(icon:"lock", hint:"Confirm New Password",isPassword: true, value:$passwordValidate)
                
                Button("Update credentials"){
                    //USER NEW CREDENTIALS
                    showAlert = false
                    users = UserDefaults.standard.dictionary(forKey: "users") as? [String: String] ?? [:]
                    emailsUsers = UserDefaults.standard.dictionary(forKey: "emails") as? [String: String] ?? [:]
                    
                    
                    newSettingsValidation.currentUserLogged = userManager.loggedInUser ?? "(username)usuario no logueado"
                    newSettingsValidation.currenteEmailLogged = userManager.loggedInUser ?? "(email)usuario no logueado"
                    newSettingsValidation.newUsername = userName
                    newSettingsValidation.newEmail = email
                    newSettingsValidation.newPassword = password
                    newSettingsValidation.newPasswordConfirmation = passwordValidate

                    newSettingsValidation.users = users
                    //newSettingsValidation.emailsUsers = emailsUsers
                    
                    newSettingsValidation.validateNewUserInformation()
                    showAlert = true
                }
                .buttonStyle(.borderedProminent)
                .disabled(email.isEmpty && userName.isEmpty && (passwordValidate.isEmpty || password.isEmpty))
                .alert(isPresented: $showAlert){
                    Alert(title: Text("Settings log:"), message: Text(newSettingsValidation.logMessage), dismissButton: .default(Text("OK")))
                }.padding(.top, 30)
            }
            .padding(.top, 30)
            .padding(.vertical, 20)
            .padding(.horizontal, 30)
            .toolbar(.hidden, for: .navigationBar)
            
            Spacer(minLength: 0)
        })
        .background(Color.customBlue)
    }
}

struct SettingsValidation{
    var users:[String: String] = [:]
    var currentUserLogged: String = ""
    var currenteEmailLogged: String = ""
    var newUsername: String = ""
    var newEmail: String = ""
    var newPassword: String = ""
    var newPasswordConfirmation: String = ""
    var showAlert: Bool = false
    var logMessage: String = ""
    
    mutating func validateNewUserInformation(){
        if(!newUsername.isEmpty){
            if(users.keys.contains(newUsername)){
                logMessage = "This username is already taken. Please choose another one"
            }else{
                let password = users[currentUserLogged]
                users[newUsername] = password
                users.removeValue(forKey: currentUserLogged)
                UserDefaults.standard.set(users, forKey: "users")
                currentUserLogged = newUsername
                logMessage = "User changed successfully"
            }
        }

        if(!newEmail.isEmpty){
            if(users.keys.contains(newEmail)){
                logMessage = "This email is already taken. Please choose another one"
            }else{
                let password = users[currenteEmailLogged]
                users[newEmail] = password
                users.removeValue(forKey: currentUserLogged)
                UserDefaults.standard.set(users, forKey: "users")
                currenteEmailLogged = newEmail
                logMessage = "Email changed succesfully"
            }
        }
        
        if(!newPassword.isEmpty && !newPasswordConfirmation.isEmpty){
            if(newPassword == users[currentUserLogged]){
                logMessage = "Your password cant be the same as your old password"
            }else{
                if (newPassword == newPasswordConfirmation){
                    users[currentUserLogged] = newPassword
                    users[currenteEmailLogged] = newPassword
                    UserDefaults.standard.set(users, forKey: "users")
                    
                    logMessage = "Password changed succesfully"
                }else{
                    logMessage = "Your passwords dont match"
                }
            }
        }
    }
}


#Preview {
    SettingsView()
}
