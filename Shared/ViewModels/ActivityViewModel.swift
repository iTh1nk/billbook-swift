//
//  ActivityViewModel.swift
//  Billbook-Swift
//
//  Created by Chao Feng on 1/3/21.
//

import Combine
import Foundation

class ActivityViewModel {
  
  func getBalance(userId: String, completionHandler: @escaping (Activity) -> Void) {
    guard let url = URL(string: "https://vzw.api.we0mmm.site/api/v1/activities/get/user/" + userId)
    else { print("Invalid URL"); return }
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    let config = URLSessionConfiguration.default
    config.httpAdditionalHeaders = ["Authorization" : UserDefaults.standard.string(forKey: "Token")!]
    URLSession(configuration: config).dataTask(with: request) { (data, resp, error) in
      if let data = data {
//        JsonDecoder(data: data)
        if let decodedResponse = try? JSONDecoder().decode(Activity.self, from: data) {
          DispatchQueue.main.async {
//            print("***Final Activity Data: ", decodedResponse)
            completionHandler(decodedResponse)
          }
          return
        }
      }
      print("Fetch Failed: \(error?.localizedDescription ?? "Unknown error")")
    }
    .resume()
  }
  
  func getActivity(userId: String, completionHandler: @escaping (User) -> Void) {
    guard let url = URL(string: "https://vzw.api.we0mmm.site/api/v1/auth/get/" + userId)
    else { print("Invalid URL"); return }
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    let config = URLSessionConfiguration.default
    config.httpAdditionalHeaders = ["Authorization" : UserDefaults.standard.string(forKey: "Token")!]
    URLSession(configuration: config).dataTask(with: request) { (data, resp, error) in
      if let data = data {
//        JsonDecoder(data: data)
        if let decodedResponse = try? JSONDecoder().decode(User.self, from: data) {
          DispatchQueue.main.async {
//            print("***Final Activity Data: ", decodedResponse)
            completionHandler(decodedResponse)
          }
          return
        }
      }
      print("Fetch Failed: \(error?.localizedDescription ?? "Unknown error")")
    }
    .resume()
  }
  
}
