//
//  About.swift
//  Billbook-Swift
//
//  Created by Chao Feng on 1/4/21.
//

import SwiftUI

struct About: View {
  
  var body: some View {
    VStack {
      Image("favicon")
        .resizable()
        .frame(width: 150, height: 150)
        .clipShape(Circle())
        //        .overlay(Circle().stroke(Color.white, lineWidth: 4))
        .shadow(radius: 20)
      Text("Version History")
          .fontWeight(.bold)
          .padding(.top)
      HStack {
        VStack(alignment: .leading, spacing: 10) {
          Text("> 1.3 (Build 1): add system widgets")
            .fontWeight(.medium)
            .padding(.leading)
//            .padding(.bottom, 0.5)
          Text("> 1.2: push nofification is online")
            .fontWeight(.medium)
            .padding(.leading)
//            .padding(.bottom, 0.5)
        }
        .padding(.leading, 30)
        .padding(.top)
        Spacer()
      }
      Text("BillBook iOS is written in SwiftUI. It is convenience for user to check monthly bill, statement and activities on iPhone. Later version may support iPad and MacOS. Any issues or concerns please send feedback to:")
        .fontWeight(.bold)
        .shadow(radius: 10)
        .rotation3DEffect(.degrees(30),axis: (x: 1, y: 0, z: 0))
        .padding(.horizontal, 42)
        .multilineTextAlignment(.center)
        .font(.system(size: 23))
        .lineSpacing(8)
      Link(destination: URL(string: "mailto:feedback@we0mmm.site")!, label: {
        Text("feedback@we0mmm.site")
          .foregroundColor(Color(red: 215/255, green: 63/255, blue: 12/255))
          .underline()
          .italic()
          .fontWeight(.bold)
          .shadow(radius: 10)
          .padding(.horizontal, 42)
          .padding(.top, 35)
          .multilineTextAlignment(.center)
          .font(.system(size: 23))
          .lineSpacing(8)
      })
      Spacer()
    }
  }
}

struct About_Previews: PreviewProvider {
  static var previews: some View {
    About()
      .preferredColorScheme(.light)
  }
}
