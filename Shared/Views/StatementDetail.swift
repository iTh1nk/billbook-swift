//
//  StatementDetails.swift
//  Billbook-Swift
//
//  Created by Chao Feng on 12/27/20.
//

import SwiftUI

struct StatementDetail: View {
  
  @Environment(\.presentationMode) var presentationMode
  
  @EnvironmentObject var enObj: EnObj
  
  var body: some View {
    VStack {
      Text("Hello")
//      List (enObj.statement) { statement in
//        Text("Hello: \(statement.balance)")
//      }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color.black)
    .edgesIgnoringSafeArea(.all)
    .onTapGesture {
      presentationMode.wrappedValue.dismiss()
    }
    .onAppear {
      print(enObj.statement)
    }
  }
}

struct StatementDetail_Previews: PreviewProvider {
  static var previews: some View {
    StatementDetail().environmentObject(EnObj())
      .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
  }
}
