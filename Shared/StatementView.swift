//
//  StatementView.swift
//  Billbook-Swfit
//
//  Created by Chao Feng on 12/26/20.
//

import Foundation
import SwiftUI

struct StatementView: View {
  var body: some View {
    NavigationView {
      VStack() {
        List{
          NavigationLink(destination: StatementDetails()) {
            Text("2021")
          }
          Text("2020")
          Text("2019")
        }
        .navigationTitle(Text("Cycles"))
      }
    }
  }
}

struct StatementView_Previews: PreviewProvider {
  static var previews: some View {
    StatementView()
      .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
  }
}
