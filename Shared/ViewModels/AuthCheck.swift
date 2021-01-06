//
//  AuthCheck.swift
//  Billbook-Swift
//
//  Created by Chao Feng on 1/5/21.
//

import Foundation
import Combine

class AuthCheck {
  
  func authCheck(enObj: EnObj) {
    guard let url = URL(string: "https://vzw.api.we0mmm.site/api/v1/auth/check/") else {
      print("Invalid URL!")
      return
    }
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    let config = URLSessionConfiguration.default
    config.httpAdditionalHeaders = ["Authorization": UserDefaults.standard.string(forKey: "Token")!]
    URLSession(configuration: config).dataTask(with: request) { (data, resp, error) in
      if let data = data {
        if let deResp = try? JSONDecoder().decode(AuthChkResp.self, from: data) {
          DispatchQueue.main.async {
            print("\(deResp)")
          }
          return
        } else {
          let dataString = String(decoding: data, as: UTF8.self)
          print("Invalid Response: \(dataString)")
          DispatchQueue.main.async {
            enObj.enLoggedIn = false
          }
          UserDefaults.standard.removeObject(forKey: "Username")
          UserDefaults.standard.removeObject(forKey: "Exp")
          UserDefaults.standard.removeObject(forKey: "UserID")
          UserDefaults.standard.removeObject(forKey: "Token")
        }
      }
      print("Fetch Failed: \(error?.localizedDescription ?? "Unknown Error!")")
    }
    .resume()
  }
  
}
