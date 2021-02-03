//
//  Formatter.swift
//  BillBook-WidgetExtension
//
//  Created by Chao Feng on 2/3/21.
//

import Foundation

func DateFormatter (for configuration: CycleCategoriesIntent, date: String) -> String {
  
  let splitDate = date.split(separator: "-");
  
  switch configuration.cycles {
  case .dot:
    return splitDate.joined(separator: ".")
  case .slash:
    return splitDate.joined(separator: "/")
  case .space:
    return splitDate.joined(separator: " ")
  case .tilde:
    return splitDate.joined(separator: "~")
  case .hash:
    return splitDate.joined(separator: "#")
  default:
    return date
  }
}
