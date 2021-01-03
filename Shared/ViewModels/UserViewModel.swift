//
//  UserViewModel.swift
//  Billbook-Swift
//
//  Created by Chao Feng on 1/2/21.
//

import Foundation
import SwiftUI

class UserViewModel: ObservableObject {
  
//  @EnvironmentObject var enUser: EnUser
//
//  func setEnUser(token: String) {
//    enUser.enUsername = try! decode(jwtToken: token)["username"] ?? ""
//    UserDefaults.standard.set(enUser.enUsername, forKey: "Username")
//  }
//
//  func decode(jwtToken jwt: String) throws -> [String: String] {
//
//    enum DecodeErrors: Error {
//      case badToken
//      case other
//    }
//
//    func base64Decode(_ base64: String) throws -> Data {
//      let padded = base64.padding(toLength: ((base64.count + 3) / 4) * 4, withPad: "=", startingAt: 0)
//      guard let decoded = Data(base64Encoded: padded) else {
//        throw DecodeErrors.badToken
//      }
//      return decoded
//    }
//
//    func decodeJWTPart(_ value: String) throws -> [String: String] {
//      let bodyData = try base64Decode(value)
//      let json = try JSONSerialization.jsonObject(with: bodyData, options: [])
//      guard let payload = json as? [String: String] else {
//        throw DecodeErrors.other
//      }
//      return payload
//    }
//
//    let segments = jwt.components(separatedBy: ".")
//    return try decodeJWTPart(segments[1])
//  }
  
}
