//
//  LogInVew.swift
//  IOSGroupWork
//
//  Created by Alejandro Berraondo Soria on 22/1/25.
//

import SwiftUI

struct LogInView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    
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
                TextViewCustom(icon:"at", hint:"Email",isPassword: false, value:$email)
                TextViewCustom(icon:"lock", hint:"Password",isPassword: true, value:$password)
                    .padding(.top,20)
                Button("Log in"){}
                    .buttonStyle(.borderedProminent)
                
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

struct TextViewCustom: View {
    @State var icon: String = ""
    @State var iconColor: Color = .gray
    @State var hint: String = ""
    @State var isPassword: Bool = false
    
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
                                .background(.gray)
                                .foregroundStyle(.black)

                        }else{
                            SecureField(hint, text: $value)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .background(.gray)
                                .foregroundStyle(.black)
                        }
                    }
                }else {
                    TextField(hint, text: $value)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .foregroundStyle(.black)
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
    LogInView()
}
