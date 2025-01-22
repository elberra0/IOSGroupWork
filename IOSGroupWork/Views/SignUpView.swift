//
//  SignUpView.swift
//  IOSGroupWork
//
//  Created by Alejandro Berraondo Soria on 22/1/25.
//

import SwiftUI

struct SignUpView: View {
    @Binding  var showSignUp: Bool
    
    @State private var email: String = ""
    @State private var password: String = ""
    
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
                TextViewCustom(icon:"at", hint:"Email",isPassword: false, value:$email)
                
                TextViewCustom(icon:"person", hint:"User Name", value:$password)
                
                TextViewCustom(icon:"lock", hint:"Password",isPassword: true, value:$password)
                
                TextViewCustom(icon:"lock", hint:"Confirm Password",isPassword: true, value:$password)
                
                Button("Sign up"){}
                    .buttonStyle(.borderedProminent)
                    .disabled(email.isEmpty || password.isEmpty)

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

#Preview {
    SignUpView(showSignUp:.constant(true))
}
