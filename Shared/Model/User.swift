//
//  User.swift
//  Billbook-Swift
//
//  Created by Chao Feng on 12/29/20.
//

import Foundation

struct User: Identifiable {
  let id: String
  let username: String
  let token: String
  let loginTime: String
  let logoutTime: String
}
