//
//  StatementView.swift
//  Billbook-Swfit
//
//  Created by Chao Feng on 12/26/20.
//

import SwiftUI

struct StatementView: View {
  
  @State var cycles: [Cycle] = []
  
  var body: some View {
    
      List(cycles) { cycle in

          NavigationLink(destination: StatementDetail()) {
            HStack {
              Image(systemName: "doc.plaintext")
              Text(cycle.date)
            }
          }

        }
        .contentShape(Rectangle())
        .listStyle(SidebarListStyle())
        .onAppear{
          ApiCycle().getCycle { (cycles) in
            self.cycles = cycles
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
