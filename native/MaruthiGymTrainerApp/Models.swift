//
//  Item.swift
//  MaruthiGymTrainerApp
//
//  Created by Shameera on 25/10/24.
//

import Foundation
import SwiftData
import SwiftUI

struct GymPricingHandler {
    
    let package:GymPackage
    let feesTenure:FeesTenure
    
     var fees:Decimal {
        switch package {
        case .standard:
            return 750
        case .advanced:
            return 900
        }
    }
    
    private var calculatedFees:Decimal {
        // For Exampe (750 - (750*(10/100))) * 12
        return (fees - fees*(feesTenure.discount/100)) * Decimal(feesTenure.rawValue)
    }
    
    private var calculatedFeesInRupees:NumberFormatter {
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "INR"
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    var calculatedFeesString:String {
        
        return calculatedFeesInRupees.string(for: calculatedFees) ?? "Unknown"
    }
}
/// Standard - Only Manual equipments , No Electronic Appliances allowed to use. More than 1 hour not allowed
/// Advanced - Manual and Electronic Appliances allowed to use. More than 1 hour allowed.
enum GymPackage:String,Codable,CaseIterable {
    
    case standard,advanced
    
    var title:String {
        switch self {
        case .standard:
            return "Standard"
        case .advanced:
            return "Advanced"
        }
    }
    
   
}

/// monthly - Monthly Fees
/// sixMonthOnce - 6 Month one time fees
/// Yearly - Yearly Fees payment
enum FeesTenure:Int,Codable,CaseIterable {
    case monthly = 1 ,sixMonthOnce = 6 ,Yearly = 12
    
    var title:String {
        switch self {
        case .monthly:
            return "Monthly"
        case .sixMonthOnce:
            return "Half Yearly"
        case .Yearly:
            return "Yearly"
            
        }
    }
    
     var discount:Decimal {
        
        switch self {
        case .monthly:
            return 0 // No discount means 0%
        case .sixMonthOnce:
            return 10 // 10%
        case .Yearly:
            return 20 // 20%
        }
    }
    
    
}

