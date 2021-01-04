//
//  Profile.swift
//  Billbook-Swift
//
//  Created by Chao Feng on 1/3/21.
//

import Foundation

struct Profile: Identifiable, Decodable {
  let id: String
  let first_name: String
  let last_name: String
  let phone_number: String
  let age: Int
  let gender: String
}
