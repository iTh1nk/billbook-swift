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
  @State var cycleDate: String
  @EnvironmentObject var enObj: EnObj
  
  var data: [Statement] = [
    Statement(id: 1, username: "mac", balance: "120", notes: "NA", createdAt: "00", updatedAt: "00"),
    Statement(id: 2, username: "9299", balance: "102", notes: "NA", createdAt: "00", updatedAt: "00"),
    Statement(id: 3, username: "6223", balance: "12", notes: "One-time fee $30 for the 1st month", createdAt: "00", updatedAt: "00"),
    Statement(id: 4, username: "8731", balance: "-112", notes: "NA", createdAt: "00", updatedAt: "00"),
    Statement(id: 5, username: "8350", balance: "12", notes: "NA", createdAt: "00", updatedAt: "00"),
    Statement(id: 6, username: "0467", balance: "-123", notes: "NA", createdAt: "00", updatedAt: "00"),
    Statement(id: 7, username: "9099", balance: "127", notes: "NA", createdAt: "00", updatedAt: "00"),
  ]
  
  var body: some View {
    
    VStack {
      LazyVGrid(columns: [GridItem(.flexible())]) {
        Text("Billing Cycle: \(cycleDate)")
          .fontWeight(.heavy)
          .padding(.bottom, 20)
        LazyHGrid(rows: [GridItem(.flexible())], spacing: 90) {
          Text("User")
            .fontWeight(.heavy)
            .foregroundColor(.gray)
          Text("Balance")
            .fontWeight(.heavy)
            .foregroundColor(.gray)
          Text("Notes")
            .fontWeight(.heavy)
            .foregroundColor(.gray)
        }
      }
      .padding(.vertical)
      
      ScrollView {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 30) {
          ForEach(enObj.statement, id: \.self.id) { statement in
            Text("\(String(statement.username.dropLast(12)))")
              .fontWeight(.heavy)
            Text("\(statement.balance)")
              .fontWeight(.heavy)
            Text("\(statement.notes)")
              .fontWeight(.heavy)
          }
        }
      }
    }
    .padding(.bottom)
    //    .frame(maxWidth: .infinity, maxHeight: .infinity)
    //    .background(Color.black)
    //    .edgesIgnoringSafeArea(.all)
    //    .onTapGesture {
    //      presentationMode.wrappedValue.dismiss()
    //    }
        .onAppear{
          StatementViewModel().getStatement(cycleId: cycleId, enObj: enObj) { (cycle) -> Void in
            enObj.statement = cycle.cycle_statements
          }
        }
    
  }
}

struct StatementDetail_Previews: PreviewProvider {
  static var previews: some View {
    StatementDetail(cycleId: 1, cycleDate: "TBD").environmentObject(EnObj())
      .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
  }
}
