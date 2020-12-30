//
//  LoginView.swift
//  Billbook-Swift
//
//  Created by Chao Feng on 12/27/20.
//

import SwiftUI

struct LoginView: View {
  
  @StateObject private var loginViewModel = LoginViewModel()
  
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
