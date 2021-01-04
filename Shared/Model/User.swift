//
//  User.swift
//  Billbook-Swift
//
//  Created by Chao Feng on 12/29/20.
//

import Foundation

struct User: Identifiable, Decodable {
  let id: String
  let email: String
  let profile: Profile
  let last_login: String
  let is_active: Bool
  let is_staff: Bool
  let is_superuser: Bool
  let user_activities: [Activity]
  let user_statements: [Statement]
}
