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
  
  @EnvironmentObject var enUsername: EnUser
  
  private func decode(jwtToken jwt: String) throws -> [String: Any] {

      enum DecodeErrors: Error {
          case badToken
          case other
      }

      func base64Decode(_ base64: String) throws -> Data {
          let padded = base64.padding(toLength: ((base64.count + 3) / 4) * 4, withPad: "=", startingAt: 0)
          guard let decoded = Data(base64Encoded: padded) else {
              throw DecodeErrors.badToken
          }
          return decoded
      }

      func decodeJWTPart(_ value: String) throws -> [String: Any] {
          let bodyData = try base64Decode(value)
          let json = try JSONSerialization.jsonObject(with: bodyData, options: [])
          guard let payload = json as? [String: Any] else {
              throw DecodeErrors.other
          }
          return payload
      }

      let segments = jwt.components(separatedBy: ".")
      return try decodeJWTPart(segments[1])
    }
  
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
        Text(enUsername.enUsername)
          .padding()
        ForEach(loginViewModel.user) { item in
          Text(item.username)
          Text(item.token)
        }
        Button(action: {
          self.loginViewModel.checkDetails(username: loginViewModel.username, password: loginViewModel.password)
          UserDefaults.standard.set("We0mmm", forKey: "Username")
          enUsername.enUsername = "We0mmm2"
          print("Hello: ", loginViewModel.user)
          
          
          try! print("Decode Begins: ", decode(jwtToken: "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiMjZiNDQ4MjAtMmMzYi00OTQwLTgxMjgtMTI1MWFiMmM2M2M1IiwidXNlcm5hbWUiOiJtYWNAbWFjLmNvbSIsImV4cCI6MTYwOTYzNjk0MywiZW1haWwiOiJtYWNAbWFjLmNvbSJ9.igLb_52CDGeXc2L6DoeTzowjTrj_Gs8ziwnFjnlL44M"))
          
          
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
    LoginView().environmentObject(EnUser())
      .preferredColorScheme(.dark)
  }
}
