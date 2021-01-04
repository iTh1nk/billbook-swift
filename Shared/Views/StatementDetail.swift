//
//  StatementDetails.swift
//  Billbook-Swift
//
//  Created by Chao Feng on 12/27/20.
//

import SwiftUI

struct StatementDetail: View {
  
  @Environment(\.presentationMode) var presentationMode
  @State var cycleId: Int
  @EnvironmentObject var enObj: EnObj
  
  var body: some View {
    VStack {
      List (enObj.statement) { statement in
        Text("Balance: \(statement.balance)")
      }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color.black)
    .edgesIgnoringSafeArea(.all)
    .onTapGesture {
      presentationMode.wrappedValue.dismiss()
    }
    .onAppear{
      StatementViewModel().getStatement(cycleId: cycleId, enObj: enObj) { (cycle) -> Void in
        enObj.statement = cycle.cycle_statements
      }
    }
  }
}

struct StatementDetail_Previews: PreviewProvider {
  static var previews: some View {
    StatementDetail(cycleId: 11).environmentObject(EnObj())
      .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
  }
}
