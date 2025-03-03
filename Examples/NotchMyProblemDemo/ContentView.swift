//
//  ContentView.swift
//  NotchMyProblemDemo
//
//  Created by Aether on 03/03/2025.
//

import SwiftUI
import NotchMyProblem

struct ContentView: View  {
    var body: some View {
        ZStack {
            // Your main content here
            
            // Buttons positioned around the notch/island
            TopologyButtonsView(
                leadingButton: {
                    Button(action: { print("Left button tapped") }) {
                        Image(systemName: "gear")
                        // for demo purposes - button sizing/styling coming soon
                            .lineLimit(1)
                            .labelStyle(.iconOnly)
                            .frame(width: 65, height: 30)
                            .font(.footnote.weight(.semibold))
                            .background(.thinMaterial)
                            .foregroundStyle(Color.primary)
                            .clipShape(Capsule())
                    }
                },
                trailingButton: {
                    Button(action: { print("Right button tapped") }) {
                        Text("Save")
                        // for demo purposes - button sizing/styling coming soon
                            .lineLimit(1)
                            .labelStyle(.iconOnly)
                            .frame(width: 65, height: 30)
                            .font(.footnote.weight(.semibold))
                            .background(.thinMaterial)
                            .foregroundStyle(Color.primary)
                            .clipShape(Capsule())
                    }
                }
            )
            .tint(Color.white)
        }
        .background(LinearGradient(colors: [Color.teal, Color.blue], startPoint: .top, endPoint: .bottom))
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .previewDevice(PreviewDevice(rawValue: "iPhone 16 Pro Max"))
                .previewDisplayName("iPhone 16 Pro Max (Dynamic Island)")
            
            ContentView()
                .previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro"))
                .previewDisplayName("iPhone 13 Pro Max (Notch)")
            
            ContentView()
                .previewDevice(PreviewDevice(rawValue: "iPhone 12 Pro"))
                .previewDisplayName("iPhone 12 Pro (Larger Notch)")

            ContentView()
                .previewDevice(PreviewDevice(rawValue: "iPhone SE (3rd generation)"))
                .previewDisplayName("iPhone SE (No Notch)")

        }
    }
}

