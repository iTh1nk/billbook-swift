//
//  Activity.swift
//  Billbook-Swfit (iOS)
//
//  Created by Chao Feng on 12/28/20.
//

import Foundation

struct Activity: Codable {
  let date: String
  let amount: String
  let totalBalance: String
  let is_read: String
  let createdAt: String
  let updatedAt: String
}

struct ActivityResponse: Codable {
  var events: [String: String]
}

class EnActivity: ObservableObject {
  @Published var totalBalance: String = "0"
}
