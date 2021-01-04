//
//  StatementViewModel.swift
//  Billbook-Swift
//
//  Created by Chao Feng on 1/3/21.
//

import Foundation

class StatementViewModel: ObservableObject {
  
  func getStatement(cycleId: String, enObj: EnObj, completionHandler: @escaping ([Statement]) -> Void) {
    guard let url = URL(string: "https://vzw.api.we0mmm.site/api/v1/cycles/get/" + cycleId) else {
      print("Invalid URL")
      return
    }
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    let config = URLSessionConfiguration.default
    config.httpAdditionalHeaders = ["Authorization": UserDefaults.standard.string(forKey: "Token")!]
    URLSession(configuration: config).dataTask(with: request) { (data, resp, error) in
      if let data = data {
        JsonDecoder(data: data)
        if let deResponse = try? JSONDecoder().decode([Statement].self, from: data) {
          DispatchQueue.main.async {
            print("^%*&%^&%^&%*^%*%*&^%*&%*&%*^&%*&%*&^%^&*%*&^%&*^%*&%*^&")
            enObj.statement = deResponse
            completionHandler(deResponse)
          }
          return
        }
      }
      print("Fetch Faild: \(error?.localizedDescription ?? "Unknown Error")")
    }
    .resume()
  }
}
