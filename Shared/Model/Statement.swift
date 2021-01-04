//
//  Statement.swift
//  Billbook-Swfit (iOS)
//
//  Created by Chao Feng on 12/28/20.
//

import Foundation

struct Statement: Identifiable, Decodable {
  let id: Int
  let username: String
  let balance: String
  let notes: String
  let createdAt: String
  let updatedAt: String
}
