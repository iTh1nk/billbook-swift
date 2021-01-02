//
//  LoginView.swift
//  Billbook-Swift
//
//  Created by Chao Feng on 12/27/20.
//

import SwiftUI

struct LoginView: View {
  
  @StateObject private var loginViewModel = LoginViewModel()
  
  @State private var storedUsername: String = UserDefaults.standard.string(forKey: "Username") ?? ""
  @State private var storedToken: String = UserDefaults.standard.string(forKey: "Token") ?? ""
  
  var body: some View {
    NavigationView {
      VStack {
        Form {
          Section(header: Text("Username")) {
            TextField("Username", text: $loginViewModel.username)
              .autocapitalization(.none)
          }
          Section(header: Text("Password"), footer: Text(loginViewModel.inlineErrorForPassword).foregroundColor(.red)) {
            SecureField("Password", text: $loginViewModel.password)
          }
        }
        
        // Test Starts
        Text(loginViewModel.username)
          .padding()
        ForEach(loginViewModel.user) { item in
          Text(item.username)
          Text(item.token)
        }
        Button(action: {
          self.loginViewModel.checkDetails(username: loginViewModel.username, password: loginViewModel.password)
          print("Hello: ", loginViewModel.user)
        }) {
          RoundedRectangle(cornerRadius: 10)
            .frame(width: 80,height: 39)
            .colorInvert()
            .overlay(Text("Post").foregroundColor(.white))
        }
        Button(action: {
          UserDefaults.standard.set(loginViewModel.username, forKey: "Username")
          storedUsername = loginViewModel.username
        }) {
          RoundedRectangle(cornerRadius: 10)
            .frame(width: 80,height: 39)
            .colorInvert()
            .overlay(Text("Save").foregroundColor(.white))
        }
        .padding()
        // Test Ends
        
        Button(action: {}) {
          RoundedRectangle(cornerRadius: 10)
            .frame(height: 60)
            .overlay(Text("Login").foregroundColor(.white))
        }
        .padding()
        .disabled(!loginViewModel.isValid)
      }
      .navigationTitle("Login")
    }
  }
}

struct LoginView_Previews: PreviewProvider {
  static var previews: some View {
    LoginView()
      .preferredColorScheme(.dark)
  }
}
