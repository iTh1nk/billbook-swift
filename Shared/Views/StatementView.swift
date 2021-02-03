//
//  StatementView.swift
//  Billbook-Swfit
//
//  Created by Chao Feng on 12/26/20.
//

import SwiftUI

struct StatementView: View {
  
  @State var cycles: [Cycle] = []
  @State private var isLoading = false
  
  @EnvironmentObject var enObj: EnObj
  
  var body: some View {
    
    VStack {
      if !enObj.cycle.isEmpty {
        Text(" ")
        List(cycles) { cycle in
          NavigationLink(destination: StatementDetail(cycleId: cycle.id, cycleDate: cycle.date).environmentObject(enObj)) {
            HStack {
              Image(systemName: "doc.plaintext")
              Text(cycle.date)
            }
          }
        }
        //      .animation(.spring(response: 0.3, dampingFraction: 0.3, blendDuration: 0.3))
        .contentShape(Rectangle())
        .listStyle(SidebarListStyle())
      } else {
        VStack {
          Text("Loading...")
            .fontWeight(.heavy)
            .font(.system(size: 23))
            .padding(.bottom, 20)
          
          ZStack {
            RoundedRectangle(cornerRadius: 3)
              .stroke(Color(.systemGray5), lineWidth: 3)
              .frame(width: 250, height: 3)
            
            RoundedRectangle(cornerRadius: 3)
              .stroke(Color.green, lineWidth: 3)
              .frame(width: 30, height: 3)
              .offset(x: isLoading ? 110 : -110, y: 0)
              .animation(Animation.linear(duration: 1.6).repeatForever(autoreverses: false))
          }
          .onAppear() {
            self.isLoading = true
          }
        }
        .padding(.vertical, 200)
      }
      Spacer()
    }
    .onAppear{
      ApiCycle().getCycle(enObj: enObj) { (cycles) in
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
