//
//  TopologyButtonsView.swift
//  NotchMyProblem
//
//  Created by Aether on 03/03/2025.
//

import SwiftUI

/// A view that positions buttons around the physical topology of the device's top area,
/// adapting to notches, Dynamic Islands, and other screen cutouts automatically.
@available(iOS 13.0, *)
public struct TopologyButtonsView<LeadingButton: View, TrailingButton: View>: View {
    // The button that appears on the left/leading side
    let leadingButton: LeadingButton
    
    // The button that appears on the right/trailing side
    let trailingButton: TrailingButton
    
    // Environment access to any custom overrides
    @Environment(\.notchOverrides) private var environmentOverrides
    
    /// Creates a new TopologyButtonsView with custom leading and trailing buttons
    /// - Parameters:
    ///   - leadingButton: The button to display on the left side
    ///   - trailingButton: The button to display on the right side
    public init(
        @ViewBuilder leadingButton: () -> LeadingButton,
        @ViewBuilder trailingButton: () -> TrailingButton
    ) {
        self.leadingButton = leadingButton()
        self.trailingButton = trailingButton()
    }
    
    public var body: some View {
        GeometryReader { geometry in
            // Detect device topology based on safe area height
            let statusBarHeight = geometry.safeAreaInsets.top
            let hasTopCutout = statusBarHeight > 10
            
            HStack(spacing: 0) {
                // Leading button with appropriate alignment
                leadingButton
                    .frame(maxWidth: .infinity, alignment: hasTopCutout ? .center : .leading)
                    .padding(7)
                
                // Space for the device's top cutout if present
                if hasTopCutout {
                    Color.clear
                        .frame(width: getAdjustedExclusionRect().width)
                }
                
                // Trailing button with appropriate alignment
                trailingButton
                    .frame(maxWidth: .infinity, alignment: hasTopCutout ? .center : .trailing)
                    .padding(7)
            }
            // Adjust height based on device topology
            .frame(height: hasTopCutout ? statusBarHeight + 4 : 40)
            .edgesIgnoringSafeArea(.all)
            .padding(.horizontal, 15)
            .padding(.top, hasTopCutout ? 0 : 15)
        }
    }
    
    /// Gets the adjusted exclusion rect, applying any environment overrides
    private func getAdjustedExclusionRect() -> CGRect {
        if let overrides = environmentOverrides {
            // Use environment-specific overrides if available
            return NotchMyProblem.shared.adjustedExclusionRect(using: overrides)
        } else {
            // Otherwise use the instance's configured overrides
            return NotchMyProblem.shared.adjustedExclusionRect
        }
    }
}
