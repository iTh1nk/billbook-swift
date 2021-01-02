//
//  Billbook_SwfitApp.swift
//  Shared
//
//  Created by Chao Feng on 12/26/20.
//

import SwiftUI

@main
struct Billbook_SwfitApp: App {
  
  @EnvironmentObject var enUser: EnUser
  
  var body: some Scene {
    WindowGroup {
      ContentView().environmentObject(EnUser())
    }
  }
}
