//
//  ApnsTokenForward.swift
//  Billbook-Swift
//
//  Created by Chao Feng on 1/6/21.
//

import Foundation

class ApnsTokenForward: ObservableObject {
  
  func forwardTokenToServer(token: Data) {
    let tokenComponents = token.map { data in String(format: "%02.2hhx", data) }
    let deviceTokenString = tokenComponents.joined()
//    print("***Device Token:\(deviceTokenString)")
    
    if UserDefaults.standard.string(forKey: "DeviceToken") != nil {
      if UserDefaults.standard.string(forKey: "DeviceToken") == deviceTokenString { return }
    }
    
    guard let url = URL(string: VarConfig.APNsTokenForward)
    else { print("Invalid URL"); return }
    let body: [String: String] = ["username": UserDefaults.standard.string(forKey: "Username") ?? "N/A", "apnsToken": deviceTokenString, "environment": "dev"]
    let codedBody = try! JSONSerialization.data(withJSONObject: body)
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.httpBody = codedBody
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    URLSession.shared.dataTask(with: request) { (data, resp, error) in
      if let data = data {
        let dataString = String(decoding: data, as: UTF8.self)
        UserDefaults.standard.setValue(deviceTokenString, forKey: "DeviceToken")
        print("***forwardTokenToServer() Response: ", dataString)
        return
      }
      print("Fetch Failed: \(error?.localizedDescription ?? "Unknown error")")
    }
    .resume()
  }
  
  func lastUseAppBasedOnDeviceToken(token: Data) {
    
//    print("############\(UserDefaults.standard.string(forKey: "DeviceTokenData") ?? "")")
    if UserDefaults.standard.data(forKey: "DeviceTokenData") == nil { return }
    
    let tokenComponents = token.map { data in String(format: "%02.2hhx", data) }
    let deviceTokenString = tokenComponents.joined()
    
    guard let url = URL(string: VarConfig.APNsTokenLastUsed + deviceTokenString) else {
      print("Invalid URL")
      return
    }
//    let body: [String: String] = ["token": deviceTokenString]
//    let codedBody = try! JSONSerialization.data(withJSONObject: body)
    var request = URLRequest(url: url)
    request.httpMethod = "PUT"
    let config = URLSessionConfiguration.default
//    config.httpAdditionalHeaders = ["Authorization" : UserDefaults.standard.string(forKey: "Token")!]
    URLSession(configuration: config).dataTask(with: request) { data, resp, error in
      if let data = data {
        let dataString = String(decoding: data, as: UTF8.self)
        print("***lastUseAppBasedOnDeviceToken: \(dataString)")
        return
      }
      print("Fetch Failed: \(error?.localizedDescription ?? "Unknown error")")
    }
    .resume()
    
    
  }
  
}
