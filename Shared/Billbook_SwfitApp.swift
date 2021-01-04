//
//  Billbook_SwfitApp.swift
//  Shared
//
//  Created by Chao Feng on 12/26/20.
//

import SwiftUI

@main
struct Billbook_SwfitApp: App {
  
  @StateObject private var enObj = EnObj()
  
  var body: some Scene {
    WindowGroup {
      ContentView().environmentObject(enObj)
    }
  }
}
