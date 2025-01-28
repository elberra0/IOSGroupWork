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
    
    @State private var logmessage: String = ""
    @State private var newEmail: String = ""
    @State private var newUserName: String = ""
    @State private var newPassword: String = ""
    @State private var newPasswordValidate: String = ""
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
                TextViewCustom(icon:"at", hint:"New Email", value: $newEmail)
                
                TextViewCustom(icon:"person", hint:"New User Name", value: $newUserName)
                
                TextViewCustom(icon:"lock", hint:"New Password",isPassword: true, value: $newPassword)
                
                TextViewCustom(icon:"lock", hint:"Confirm New Password",isPassword: true, value:$newPasswordValidate)
                
                Button("Update credentials"){
                    //USER NEW CREDENTIALS
                    let userValidation = userAuth()
                    
                    if(userValidation){
                        showAlert = true
                    }
                }
                .buttonStyle(.borderedProminent)
                .disabled(newEmail.isEmpty && newUserName.isEmpty && (newPasswordValidate.isEmpty || newPassword.isEmpty))
                .alert(isPresented: $showAlert){
                    Alert(title: Text("Settings log:"), message: Text(logmessage), dismissButton: .default(Text("OK")))
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
    
    func userAuth() -> Bool{
        if(!newUserName.isEmpty){
            if(!UserManager.userExists(userName: newUserName)){
                var user = UserManager.getUser(userNameOrEmail: userManager.loggedInUser)
                user?.username = newUserName
                
                UserManager.modifyUser(username: userManager.loggedInUser ?? "user not found", newUserName: newUserName, newEmail: user?.email ?? "email not found", newPassword: user?.password ?? "password not found")
                
                var userss = UserManager.loadUsers()
                userManager.loggedInUser = newUserName
            
                logmessage = "Username changed correctly"
            }else{
                logmessage = "Username is already taken. Please choose another one"
                return true
            }
        }
        
        if(!newEmail.isEmpty){
            if(!UserManager.userExists(email:newEmail)){
                let password = UserManager.getUserPassword(usernameOrEmail: UserManager.getUserEmail(username:userManager.loggedInUser ?? "email not found") ?? "password not found")
                var user = UserManager.getUser(userNameOrEmail: userManager.loggedInUser)
                user?.email = newEmail
                
                UserManager.modifyUser(username: userManager.loggedInUser ?? "user not found", newUserName: user?.username ?? "username not found", newEmail: newEmail, newPassword: password)
                
                var userss = UserManager.loadUsers()
                logmessage = "Email changed correctly"
            }else{
                logmessage = "Email is already taken. Please choose another one"
                return true
            }
        }
        
        if(!newPassword.isEmpty && !newPasswordValidate.isEmpty){
            if (newPassword != newPasswordValidate){
                logmessage = "Passwords do not match, try again"
                return true
            }else{
                UserManager.updateUserPassword(username: userManager.loggedInUser ?? "user not found", newPassword: newPassword)
                logmessage = "Password changed correctly"
            }
        }
        return true
    }
}


#Preview {
    SettingsView()
}
