//
//  Cycle.swift
//  Billbook-Swfit (iOS)
//
//  Created by Chao Feng on 12/28/20.
//

import Foundation

struct Cycle: Identifiable, Decodable {
  let id: Int
  let date: String
  let is_read: String
  let createdAt: String
  let updatedAt: String
  let cycle_statements: [Statement]
}
