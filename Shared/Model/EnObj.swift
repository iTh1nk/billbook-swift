//
//  EnObj.swift
//  Billbook-Swift
//
//  Created by Chao Feng on 1/3/21.
//

import Foundation

class EnObj: ObservableObject {
  
  @Published var enUsername: String = ""
  @Published var enLoggedIn: Bool = false
  @Published var totalBalance: String = "0"
  @Published var errorLogin: String = ""
}
