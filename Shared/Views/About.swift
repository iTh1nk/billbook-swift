//
//  About.swift
//  Billbook-Swift
//
//  Created by Chao Feng on 1/4/21.
//

import SwiftUI

struct About: View {
  
  @State private var angle: Double = 0
  
    var body: some View {
      Button(action: {
          self.angle += 45
      }) {
          Text("Tap here")
              .padding()
              .rotationEffect(.degrees(angle))
              .animation(.interpolatingSpring(mass: 1, stiffness: 1, damping: 0.5, initialVelocity: 5))
      }
      .onAppear{
      }
    }
}

struct About_Previews: PreviewProvider {
    static var previews: some View {
        About()
    }
}
