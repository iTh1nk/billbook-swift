//
//  Statement.swift
//  Billbook-Swfit (iOS)
//
//  Created by Chao Feng on 12/28/20.
//

import Foundation

struct Statement: Identifiable {
  let id = UUID()
  let user: String
  let balance: String
  let notes: String
}
