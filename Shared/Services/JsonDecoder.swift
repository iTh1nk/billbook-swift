//
//  JsonDecoder.swift
//  Billbook-Swift
//
//  Created by Chao Feng on 1/3/21.
//

import Foundation

func JsonDecoder(data: Data) {
  do {
    let jsonObject = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
    if let jsonDict = jsonObject as? NSDictionary {
      print ("NSDictionary: ", jsonDict)
    }
    if let jsonArray = jsonObject as? NSArray {
      print ("NSArray: ", jsonArray)
    }
  } catch {
    print("JSON Decode Fail")
  }
}
