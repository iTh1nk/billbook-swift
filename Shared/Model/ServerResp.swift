//
//  ServerResp.swift
//  Billbook-Swift
//
//  Created by Chao Feng on 1/1/21.
//

import Foundation

struct ServerRespLogin: Decodable {
  let status: Int
  let message: String
  let token: String
//  let non_field_errors: Array<String>
}
