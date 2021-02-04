//
//  LargeView.swift
//  BillBook-WidgetExtension
//
//  Created by Chao Feng on 2/3/21.
//

import Foundation
import SwiftUI
import WidgetKit

struct LargeView: View {
  var entry: Provider.Entry
  
  var body: some View {
    ZStack {
      Color(red: 215/255, green: 63/255, blue: 12/255)
      VStack {
        
        ZStack {
          Image("fireworks")
            .resizable()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .aspectRatio(contentMode: .fill)
            .mask(LinearGradient(gradient: Gradient(colors: [Color.clear, Color.black]), startPoint: .bottom, endPoint: .top))
          //                .blur(radius: 1)
          VStack {
            Text("STAY ACTIVE")
              .font(.system(size: 30))
              .fontWeight(.heavy).foregroundColor(Color.white)
              .shadow(color: .black, radius: 2)
              .padding(.top, 50)
            Text("CLOSE YOUR RINGS")
              .font(.system(size: 30))
              .fontWeight(.heavy).foregroundColor(Color.white)
              .shadow(color: .black, radius: 2)
              .padding(.top, 5)
          }
        }
        .frame(height: 100)
        Spacer()
        VStack {
          Link(destination: URL(string: "m0bb://tab=3")!) {
            HStack {
              Image("favicon")
                .resizable()
                .frame(width: 60, height: 60)
                .clipShape(Circle())
              VStack {
                Text("BillBook")
                  .foregroundColor(.white)
                  .font(.system(size: 12))
                  .fontWeight(.bold)
                Text("@We0mmm")
                  .foregroundColor(.white)
                  .font(.system(size: 8))
              }
            }
          }
          Link(destination: URL(string: "m0bb://tab=1")!) {
            VStack {
              Text("Current Cycle")
                .foregroundColor(.white)
                .fontWeight(.bold)
                .padding(.bottom, 5)
                .shadow(color: .black, radius: 1)
              Text(entry.notification)
                .foregroundColor(.white)
                .fontWeight(.heavy)
                .font(.system(size: 23))
                .shadow(color: .black, radius: 1)
            }
          }
        }
        .padding(.top)
        Spacer()
      }
    }
  }
}

struct LargeView_Previews: PreviewProvider {
  static var previews: some View {
    LargeView(entry: SimpleEntry(date: Date(), notification: "2021-01-09"))
      .previewContext(WidgetPreviewContext(family: .systemLarge))
  }
}
