//
//  LogInVew.swift
//  IOSGroupWork
//
//  Created by Alejandro Berraondo Soria on 22/1/25.
//

import SwiftUI

struct LogInView: View {
    @EnvironmentObject var userManager: UserManager

    @Binding  var showSignUp: Bool
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var loginInvalid: Bool = false
    @State private var loginValid: Bool = false
    @State var users = UserDefaults.standard.dictionary(forKey: "users") as? [String: String] ?? [:]
    
    var body: some View {
        VStack(alignment: .leading,spacing: 20,content: {

            Spacer(minLength: 0)
            Group{
                Text("Log In")
                    .foregroundStyle(.white)
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("Log in to access the FitAPP")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundStyle(.gray)
                    .padding(.top, -10)
            }
            .padding(.horizontal, 25)

            VStack(spacing:20){
                //Text fields
                TextViewCustom(icon:"at", hint:"Email or UserName",isPassword: false, value:$email)
                TextViewCustom(icon:"lock", hint:"Password",isPassword: true, value:$password)
                    .padding(.top,20)
                Button("Log in"){
                    loginInvalid = UserManager.checkUserLogin(userNameOrEmail: email, password: password)

                    if(!loginInvalid){
                        //Store current user logged in
                        userManager.loggedInUser = UserManager.getUsername(usernameOrEmail: email)
                        loginValid = true
                    }
                }
                    .buttonStyle(.borderedProminent)
                    .disabled(email.isEmpty || password.isEmpty)
                    .alert( isPresented: $loginInvalid){
                        Alert(title: Text("No se iniciar sesión"), message: Text("Campos introducidos incorrectos"), dismissButton: .default(Text("OK")))
                    }
                    .navigationDestination(isPresented: $loginValid){
                        //MapGymsNearbyView()
                        SettingsView()
                    }

                
                VStack{
                    Text("Don't have an account?")
                        .foregroundStyle(.gray)
                    Button("Sign up"){
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
        .onAppear{
            users = UserDefaults.standard.dictionary(forKey: "users") as? [String: String] ?? [:]
        }
    }
}

func logInSystem(emailOrUser:String,password:String,users:[String:String])->Bool{
    if(users.keys.contains(emailOrUser)){
        if (users[emailOrUser] == password){
            return false

        }else{
            return true
        }
    }else{
        return true
    }
}

struct TextViewCustom: View {
    @Environment(\.colorScheme) var colorScheme

    @State var icon: String = ""
    @State var iconColor: Color = .gray
    @State var hint: String = ""
    @State var isPassword: Bool = false
    @State var darkModeEnabled : Bool = false
    
    @Binding var value : String
    
    @State private var showPassword: Bool = false
    var body: some View {
        HStack(alignment: .top,spacing: 8, content: {
            Image(systemName: icon)
                .foregroundStyle(.white)
                .frame(width: 30)
                .padding(.top,5)
            
            VStack(alignment: .leading, spacing: 5,content:{
                if(isPassword){
                    Group{
                        if(showPassword){
                            TextField(hint, text: $value)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .foregroundStyle(colorScheme == .dark ? .white : .black)

                        }else{
                            SecureField(hint, text: $value)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .foregroundStyle(colorScheme == .dark ? .white : .black)
                        }
                    }
                }else {
                    TextField(hint, text: $value)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .foregroundStyle(colorScheme == .dark ? .white : .black)
                }
                Divider()
            })
            .foregroundStyle(.white)
            .overlay(alignment:.trailing) {
                //Password show hide button
                if(isPassword){
                    Button(action: {
                        withAnimation {
                            showPassword.toggle()
                        }
                    }, label:{
                        Image(systemName: showPassword ? "eye.slash" : "eye")
                    } )
                    .foregroundStyle(.gray)
                    .padding(.trailing, 10)
                    .contentShape(.rect)
                }
            }
        })
           
    }
}

#Preview {
    LogInView(showSignUp:.constant(false))
}
