//
//  CycleModelView.swift
//  Billbook-Swift
//
//  Created by Chao Feng on 12/30/20.
//

import Foundation

struct CycleModelView {
  
  //  Temp Data
    static let cycleTemp: [Cycle] = [
      Cycle(date: "2019", children: [
        Cycle(date: "2019-10-09", children: nil),
        Cycle(date: "2019-11-09", children: nil),
        Cycle(date: "2019-12-09", children: nil),
        
      ]),
      Cycle(date: "2020", children: [
        Cycle(date: "2020-10-09", children: nil),
        Cycle(date: "2020-11-09", children: nil),
        Cycle(date: "2020-12-09", children: nil),
        
      ]),
      Cycle(date: "2021", children: [
        Cycle(date: "2021-10-09", children: nil),
        Cycle(date: "2021-11-09", children: nil),
        Cycle(date: "2021-12-09", children: nil),
        
      ]),
    ]
  
  
}


