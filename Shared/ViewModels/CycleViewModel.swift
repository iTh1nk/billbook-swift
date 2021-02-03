//
//  CycleModelView.swift
//  Billbook-Swift
//
//  Created by Chao Feng on 12/30/20.
//

import Foundation

class ApiCycle {
  
  func getCycle(enObj: EnObj, completion: @escaping ([Cycle]) -> ()) {
    guard let url = URL(string: "https://vzw.api.we0mmm.site/api/v1/cycles/get/?format=json") else { return }
    URLSession.shared.dataTask(with: url) { (data, _, _) in
      let cycles = try! JSONDecoder().decode([Cycle].self, from: data!)
      DispatchQueue.main.async {
        enObj.cycle = cycles
        completion(cycles)
      }
    }
    .resume()
  }
  
}
