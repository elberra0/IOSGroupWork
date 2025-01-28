//
//  UserManager.swift
//  IOSGroupWork
//
//  Created by Alejandro Berraondo Soria on 28/1/25.
//

import SwiftUI

class UserManager: ObservableObject {
    @Published var loggedInUser: String? = nil
    
    static func saveUsers(users:[User]){
        if let encoded = try? JSONEncoder().encode(users) {
            UserDefaults.standard.set(encoded, forKey: "users")
        }
    }
    
    static func loadUsers() -> [User] {
        guard let savedData = UserDefaults.standard.data(forKey: "users") else {
            return []
        }
        return try! JSONDecoder().decode([User].self, from: savedData)
    }
    
    static func userExists(userName:String? = nil, email:String? = nil)->Bool{
        let users: [User] = loadUsers()
        
        if let userName = userName{
            if users.contains(where: {$0.username == userName}){
                return true
            }
        }
        
        if let email = email{
            if users.contains(where: {$0.email == email}){
                return true
            }
        }
        
        return false
    }
    
    static func getUser(userNameOrEmail:String? = nil)->User?{
        let users = loadUsers()
        if let userNameOrEmail = userNameOrEmail{
            if users.contains(where: {$0.username == userNameOrEmail}){
                return users.first(where: {$0.username == userNameOrEmail})
            }
        }
        
        if let userNameOrEmail = userNameOrEmail{
            if users.contains(where: {$0.email == userNameOrEmail}){
                return users.first(where: {$0.email == userNameOrEmail})
            }
        }
        
        return nil
    }
    
    static func checkUserLogin(userNameOrEmail:String? = nil, password:String? = nil)->Bool{
        let users: [User] = loadUsers()
        
        if let userNameOrEmail = userNameOrEmail, let password = password{
            if users.contains(where: {$0.username == userNameOrEmail && $0.password == password}){
                return false
            }
        }
        
        if let userNameOrEmail = userNameOrEmail, let password = password{
            if users.contains(where: {$0.email == userNameOrEmail && $0.password == password}){
                return false
            }
        }
        
        return true
    }
    
    static func modifyUser(username:String? = nil,newUserName:String? = nil, newEmail:String? = nil, newPassword: String? = nil){
        var users: [User] = loadUsers()
        
        //Find the user that meets the requirement (equal usernames)
        if let index = users.firstIndex(where: {$0.username == username}){
            
            //Modify what's needed if parameter nil, wont change 
            if let newUserName = newUserName{
                users[index].username = newUserName
            }
            
            if let newEmail = newEmail{
                users[index].email = newEmail
            }
            
            if let newPassword = newPassword{
                users[index].password = newPassword
            }
            //Save the new user
            saveUsers(users: users)
        }
    }
    
    static func addUser(user:User){
        var users: [User] = loadUsers()
        users.append(user)
        saveUsers(users: users)
    }
    
    static func getUserPassword(usernameOrEmail:String)->String?{
        var users:[User] = loadUsers()
        if let user = users.first(where: {$0.username == usernameOrEmail}){
            return user.password
        }
        if let user = users.first(where: {$0.email == usernameOrEmail}){
            return user.password
        }
        return nil
    }
    
    static func updateUserPassword(username:String, newPassword:String){
        var users:[User] = loadUsers()
        
        if let index = users.firstIndex(where: { $0.username == username }) {
            users[index].password = newPassword
            UserManager.saveUsers(users: users)
        }
        
        if let index = users.firstIndex(where: { $0.email == username }) {
            users[index].password = newPassword
            UserManager.saveUsers(users: users)
        }
    }
    
    static func getUserEmail(username:String)->String?{
        var users:[User] = loadUsers()
        if let user = users.first(where: {$0.username == username}){
            return user.email
        }
        return nil
    }
    
    static func getUsername(usernameOrEmail: String) -> String? {
        var users = UserManager.loadUsers()
        if let user = users.first(where: { $0.username == usernameOrEmail || $0.email == usernameOrEmail }) {
            return user.username
        }
        return nil
    }
}
