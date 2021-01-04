//
//  DigitColor.swift
//  Billbook-Swift
//
//  Created by Chao Feng on 1/3/21.
//

import Foundation

class DigitColor: ObservableObject {
  
  func digitColor(digitString: String) -> Bool {
    guard let digit = Float(digitString) else { print("Color Convert Fail!"); return false }
    if digit >= 0 {
      return true
    } else {
      return false
    }
  }
}
