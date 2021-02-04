//
//  SmallView.swift
//  BillBook-WidgetExtension
//
//  Created by Chao Feng on 2/3/21.
//

import Foundation
import SwiftUI

struct SmallView: View {
  var entry: Provider.Entry
  
  var body: some View {
    ZStack {
      Color(red: 215/255, green: 63/255, blue: 12/255)
      VStack {
        Spacer()
        Text("Current Cycle")
          .foregroundColor(.white)
          .fontWeight(.bold)
          .padding(.bottom, 5)
        Text(entry.notification)
          .foregroundColor(.white)
          .fontWeight(.heavy)
          .font(.system(size: 23))
        Spacer()
        Spacer()
      }
    }
  }
}
