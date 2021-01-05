//
//  ActivityView.swift
//  Billbook-Swfit
//
//  Created by Chao Feng on 12/26/20.
//

import SwiftUI

struct ActivityView: View {
  
  @EnvironmentObject var enObj: EnObj
  @StateObject var digitColor = DigitColor()
  @State private var isLoading = false
  
  private let coloumnLayout = [
    GridItem(.flexible()),
    GridItem(.flexible()),
    GridItem(.flexible())
  ]
  
  var body: some View {
    ScrollView {
      LazyVGrid(columns: coloumnLayout, spacing: 20) {
        Text("Date")
          .fontWeight(.heavy)
          .foregroundColor(.gray)
        Text("Deposite")
          .fontWeight(.heavy)
          .foregroundColor(.gray)
        Text("Balance")
          .fontWeight(.heavy)
          .foregroundColor(.gray)
      }
      .padding()
      
      if !enObj.activity.isEmpty {
        LazyVGrid(columns: coloumnLayout, spacing: 20) {
          ForEach(enObj.activity.reversed(), id: \.self.id) { activity in
            Text(activity.date)
              .fontWeight(.heavy)
            Text(activity.amount)
              .fontWeight(.heavy)
            Text(activity.totalBalance)
              .fontWeight(.heavy)
              .foregroundColor(digitColor.digitColor(digitString: activity.totalBalance) ? .none : .red)
          }
        }
        .padding(.bottom)
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
      
    }

  }
  
}

struct ActivityView_Previews: PreviewProvider {
  static var previews: some View {
    ActivityView().environmentObject(EnObj())
      .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
  }
}
