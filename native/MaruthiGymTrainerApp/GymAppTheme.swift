//
//  GymAppTheme.swift
//  MaruthiGymTrainerApp
//
//  Created by Shameera on 10/11/24.
//

import SwiftUI


struct GymAppTheme {
    
    // Universal theme color
    static var universalThemeColor: Color {
        Color(hex: ColorScheme.current == .dark ? "#1E3A8A" : "#3B82F6")
    }
    
    // Primary color for icons and buttons
    static var iconsButtonsColor: Color {
        Color(hex: ColorScheme.current == .dark ? "#1D4ED8" : "#3B82F6")
    }
    
    // Background colors for light and dark modes
    static var backgroundColor: Color {
        Color(hex: ColorScheme.current == .dark ? "#1C1C1E" : "#F3F4F6")
    }
    
    // Secondary background color
    static var secondaryBackgroundColor: Color {
        Color(hex: ColorScheme.current == .dark ? "#2C2C2E" : "#E5E7EB")
    }
    
    // Primary text color
    static var primaryTextColor: Color {
        Color(hex: ColorScheme.current == .dark ? "#FFFFFF" : "#1F2937")
    }
    
    // Secondary text color
    static var secondaryTextColor: Color {
        Color(hex: ColorScheme.current == .dark ? "#A1A1AA" : "#6B7280")
    }
}

extension ColorScheme {
    static var current: ColorScheme {
        let uiStyle = UITraitCollection.current.userInterfaceStyle
        return uiStyle == .dark ? .dark : .light
    }
}


extension Color {
    init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let red = Double((rgb >> 16) & 0xFF) / 255.0
        let green = Double((rgb >> 8) & 0xFF) / 255.0
        let blue = Double(rgb & 0xFF) / 255.0

        self.init(red: red, green: green, blue: blue)
    }
}
