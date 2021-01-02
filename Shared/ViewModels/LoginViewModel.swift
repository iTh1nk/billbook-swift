//
//  Login.swift
//  Billbook-Swift
//
//  Created by Chao Feng on 12/29/20.
//

import Foundation
import Combine

class LoginViewModel: ObservableObject {
  
  @Published var user: [User] = [
    .init(username: "", token: "", loginTime: "", logoutTime: "")
  ]
  
  var didChange = PassthroughSubject<LoginViewModel, Never>()
  var authenticated = false {
    didSet {
      didChange.send(self)
    }
  }
  func checkDetails(username: String, password: String) {
    guard let url = URL(string: "https://vzw.api.we0mmm.site/api/v1/auth/login/") else { return }
    let body: [String: String] = ["email": username, "password": password]
    let finalBody = try! JSONSerialization.data(withJSONObject: body)
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.httpBody = finalBody
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    URLSession.shared.dataTask(with: request) { (data, resp, error) in
      DispatchQueue.main.async {
        guard let data = data else { return }
        let finalData = try! JSONDecoder().decode(ServerRespLogin.self, from: data)
        UserDefaults.standard.set(finalData.token, forKey: "Token")
        self.user = [.init(username: "Mac", token: finalData.token, loginTime: "", logoutTime: "")]
        print(finalData)
      }
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
      .map { $0.count >= 5 }
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
        $0.count > 4
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
