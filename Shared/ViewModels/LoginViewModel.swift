//
//  Login.swift
//  Billbook-Swift
//
//  Created by Chao Feng on 12/29/20.
//

import SwiftUI
import Combine
import os

class LoginViewModel: ObservableObject {
  
  @StateObject private var userVM = UserViewModel()
  
  // ********** TEST STARTS **********
  func decode(jwtToken jwt: String) throws -> [String: Any] {
    
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
  // ########## TEST ENDS ##########
  
  
  
  var didChange = PassthroughSubject<LoginViewModel, Never>()
  var authenticated = false {
    didSet {
      didChange.send(self)
    }
  }
  
  func loginUser(username: String, password: String, enObj: EnObj) {
    
    guard let url = URL(string: "https://vzw.api.we0mmm.site/api/v1/auth/login/") else { return }
    let body: [String: String] = ["email": username == "mac" ? "mac@mac.com" : username + "@we0mmm.site", "password": password]
    let finalBody = try! JSONSerialization.data(withJSONObject: body)
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.httpBody = finalBody
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    URLSession.shared.dataTask(with: request) { (data, resp, error) in
      guard let data = data else { return }
      let finalData = try! JSONDecoder().decode(ServerRespLogin.self, from: data)
      //      print("***FinalData: ", finalData)
      if finalData.status == 200 {
        DispatchQueue.main.async {
          do {
            //            print(try self.decode(jwtToken: finalData.token))
            enObj.enUsername = try self.decode(jwtToken: finalData.token)["username"] as! String
            enObj.enLoggedIn = true
            UserDefaults.standard.set(enObj.enUsername, forKey: "Username")
            UserDefaults.standard.set(try self.decode(jwtToken: finalData.token)["exp"], forKey: "Exp")
            UserDefaults.standard.set(try self.decode(jwtToken: finalData.token)["user_id"], forKey: "UserID")
            UserDefaults.standard.set(finalData.token, forKey: "Token")
            ActivityViewModel().getBalance(userId: try self.decode(jwtToken: finalData.token)["user_id"] as! String) { (activity) -> Void in
              enObj.totalBalance = activity.totalBalance
            }
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (allowed, error) in
              //This callback does not trigger on main loop be careful
              if allowed {
                os_log(.debug, "Allowed: \(allowed)")
                ApnsTokenForward().forwardTokenToServer(token: UserDefaults.standard.data(forKey: "DeviceTokenData")!)
              } else {
                os_log(.debug, "Error")
              }
            }
          } catch _ {
            print("Error")
          }
          
        }
      } else if finalData.status == 401 {
        DispatchQueue.main.async {
          enObj.errorLogin = "Username and password do not match!"
        }
      } else { return }
    }
    .resume()
  }
  
  @Published var username = ""
  @Published var password = ""
  @Published var token = ""
  @Published var isValid = false
  @Published var inlineErrorForPassword = ""
  
  private var cancellables = Set<AnyCancellable>()
  
  private static let pwdCheck = NSPredicate(format: "SELF MATCHES %@", "^.{4,}$")
  
  init() {
    
    isFormValidPublisher
      .receive(on: RunLoop.main)
      .assign(to: \.isValid, on: self)
      .store(in: &cancellables)
    
    isPasswordValidPublisher
      .dropFirst()
      .receive(on: RunLoop.main)
      .map { passwordStatus in
        switch passwordStatus {
        case .empty:
          return "Password cannot be empty"
        case .notStrongEnough:
          return "Password is not valid"
        case .valid:
          return ""
        }
      }
      .assign(to: \.inlineErrorForPassword, on: self)
      .store(in: &cancellables)
  }
  
  private var isUsernameValidPublisher: AnyPublisher<Bool, Never> {
    $username
      .debounce(for: 0.8, scheduler: RunLoop.main)
      .removeDuplicates()
      .map { $0.count >= 3 }
      .eraseToAnyPublisher()
  }
  private var isPasswordEmptyPublisher: AnyPublisher<Bool, Never> {
    $password
      .debounce(for: 0.8, scheduler: RunLoop.main)
      .removeDuplicates()
      .map { $0.isEmpty }
      .eraseToAnyPublisher()
  }
  private var isPasswordStrongPublisher: AnyPublisher<Bool, Never> {
    $password
      .debounce(for: 0.8, scheduler: RunLoop.main)
      .removeDuplicates()
      .map {
        //        Self.pwdCheck.evaluate(with: $0)
        $0.count > 3
      }
      .eraseToAnyPublisher()
  }
  
  private var isPasswordValidPublisher: AnyPublisher<PasswordStatus, Never> {
    Publishers.CombineLatest(isPasswordEmptyPublisher, isPasswordStrongPublisher)
      .map {
        if $0 {
          return PasswordStatus.empty
        }
        if !$1 {
          return PasswordStatus.notStrongEnough
        }
        return PasswordStatus.valid
      }
      .eraseToAnyPublisher()
  }
  
  private var isFormValidPublisher: AnyPublisher<Bool, Never> {
    Publishers.CombineLatest(isPasswordValidPublisher, isUsernameValidPublisher)
      .map { $0 == .valid && $1}
      .eraseToAnyPublisher()
  }
  
}
