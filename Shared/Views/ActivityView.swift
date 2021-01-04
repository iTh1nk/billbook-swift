//
//  ActivityView.swift
//  Billbook-Swfit
//
//  Created by Chao Feng on 12/26/20.
//

import SwiftUI

struct ActivityView: View {
  
  @EnvironmentObject var enObj: EnObj
  
  var body: some View {
    
    List (enObj.activity) { activity in
      
      Section(header: Text("\(activity.date)")) {
        Text("Amount: \(activity.amount)")
        .padding(.leading)
        Text("Total Balance: \(activity.totalBalance)")
        .padding(.leading)
      }
    }
    .listStyle(SidebarListStyle())
    
  }
  
}

struct ActivityView_Previews: PreviewProvider {
  static var previews: some View {
    ActivityView().environmentObject(EnObj())
      .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
  }
}
