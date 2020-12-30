//
//  Login.swift
//  Billbook-Swift
//
//  Created by Chao Feng on 12/29/20.
//

import Foundation
import Combine

class LoginViewModel: ObservableObject {
  
  @Published var username = ""
  @Published var password = ""
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
