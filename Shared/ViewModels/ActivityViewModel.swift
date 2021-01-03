//
//  ActivityViewModel.swift
//  Billbook-Swift
//
//  Created by Chao Feng on 1/3/21.
//

import Combine
import Foundation

class ActivityViewModel {
  
  func getBalance(userId: String) {
    guard let url = URL(string: "https://vzw.api.we0mmm.site/api/v1/activities/get/user/" + userId)
    else { print("Invalid URL"); return }
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    let config = URLSessionConfiguration.default
    config.httpAdditionalHeaders = ["Authorization" : "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiMjZiNDQ4MjAtMmMzYi00OTQwLTgxMjgtMTI1MWFiMmM2M2M1IiwidXNlcm5hbWUiOiJtYWNAbWFjLmNvbSIsImV4cCI6MTYwOTcyMDU2NywiZW1haWwiOiJtYWNAbWFjLmNvbSJ9.lXCQSLmUHYnc9lbPrTzJOfua9pjITl_a-vFNaUct6oY"]
    URLSession(configuration: config).dataTask(with: request) { (data, resp, error) in
      if let data = data {
        JsonDecoder(data: data)
        if let decodedResponse = try? JSONDecoder().decode(Activity.self, from: data) {
          DispatchQueue.main.async {
            print("***Final Activity Data: ", decodedResponse)
          }
          return
        }
      }
      print("Fetch Failed: \(error?.localizedDescription ?? "Unknown error")")
    }
    .resume()
  }
  
}
