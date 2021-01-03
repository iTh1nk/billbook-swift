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
  
  @State private var storedUsername: String = UserDefaults.standard.string(forKey: "Username") ?? ""
  @State private var storedToken: String = UserDefaults.standard.string(forKey: "Token") ?? ""
  
  @EnvironmentObject var enUser: EnUser
  
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
        
        // ********** TEST STARTS **********
        Text("enUsername: \(enUser.enUsername)")
          .padding()
        ForEach(loginVM.user) { item in
          Text(item.username)
          Text(item.token)
        }
        Button(action: {
//          self.loginVM.checkDetails(username: loginVM.username, password: loginVM.password, enUser: enUser)
          enUser.enUsername = "OMG"
        }) {
          RoundedRectangle(cornerRadius: 10)
            .frame(width: 80,height: 39)
            .colorInvert()
            .overlay(Text("Post").foregroundColor(.white))
        }
        // ########## TEST ENDS ##########
        
        Button(action: {}) {
          RoundedRectangle(cornerRadius: 10)
            .frame(height: 60)
            .overlay(Text("Login").foregroundColor(.white))
        }
        .padding()
        .disabled(!loginVM.isValid)
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
