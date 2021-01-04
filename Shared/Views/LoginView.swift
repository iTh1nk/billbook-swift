//
//  LoginView.swift
//  Billbook-Swift
//
//  Created by Chao Feng on 12/27/20.
//

import SwiftUI
import Combine

struct LoginView: View {
  
  @StateObject private var loginVM = LoginViewModel()
  
  @EnvironmentObject var enObj: EnObj
  
  var body: some View {
    NavigationView {
      VStack {
        Form {
          Section(header: Text("Username")) {
            TextField("Username", text: $loginVM.username)
              .autocapitalization(.none)
          }
          Section(header: Text("Password"), footer: Text(loginVM.inlineErrorForPassword).foregroundColor(.red)) {
            SecureField("Password", text: $loginVM.password)
          }
        }
        if enObj.errorLogin != "" {
          VStack {
            Text("\(enObj.errorLogin)")
              .foregroundColor(.red)
              .fontWeight(.bold)
              .font(.system(size: 15))
          }
        }
        Button(action: {
          self.loginVM.loginUser(username: loginVM.username, password: loginVM.password, enObj: enObj)
        }) {
          RoundedRectangle(cornerRadius: 10)
            .frame(height: 60)
            .overlay(Text("Login").foregroundColor(.white))
        }
        .padding()
        .disabled(!loginVM.isValid)
      }
      .navigationTitle("Login")
    }
    .onDisappear{
      enObj.errorLogin = ""
    }
  }
}

struct LoginView_Previews: PreviewProvider {
  static var previews: some View {
    LoginView().environmentObject(EnObj())
      .preferredColorScheme(.dark)
  }
}
