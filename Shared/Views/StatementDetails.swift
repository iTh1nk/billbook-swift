//
//  StatementDetails.swift
//  Billbook-Swift
//
//  Created by Chao Feng on 12/27/20.
//

import SwiftUI

struct StatementDetails: View {
  @Environment(\.presentationMode) var presentationMode

      var body: some View {
          VStack {
              Text("Statement Details View")
          }
          .frame(maxWidth: .infinity, maxHeight: .infinity)
          .background(Color.black)
          .edgesIgnoringSafeArea(.all)
          .onTapGesture {
              presentationMode.wrappedValue.dismiss()
          }
      }
}

struct StatementDetails_Previews: PreviewProvider {
  static var previews: some View {
    StatementDetails()
      .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
  }
}
