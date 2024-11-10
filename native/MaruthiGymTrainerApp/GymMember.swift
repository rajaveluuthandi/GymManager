//
//  GymMember.swift
//  MaruthiGymTrainerApp
//
//  Created by Shameera on 10/11/24.
//


import SwiftData
import SwiftUI
@Model
final class GymMember {
    
    // Use a string for uniqueness, mapped to the enum raw value
    @Attribute(.unique) var id: UUID
    var name:String
    var joiningDate:Date
    var packageType:GymPackage
    var feesTenureType:FeesTenure
    var imageData:Data?
    
    
    
    init(id: UUID, name: String, joiningDate: Date, packageType: GymPackage = .standard, feesTenureType: FeesTenure = .monthly,imageData:Data? = nil ) throws {
        // The Gym Member name should not be empty. Although we can enforce this constraint in the UI,
        // we also add an additional check at the Swift Data model level to ensure no empty names
        // are inserted into the database.
        guard !name.isEmpty else {
            throw GymMemberError.emptyName
        }
        self.id = id
        self.name = name
        self.joiningDate = joiningDate
        self.packageType = packageType
        self.feesTenureType = feesTenureType
        self.imageData = imageData
    }
    
    var gymMemberImage:UIImage? {
       
        if let data  = imageData {
           
            return UIImage.init(data: data)
        }
        
        return nil
    }
    
    
    var joinDateString:String {
        
        let formater = DateFormatter()
        formater.dateStyle = DateFormatter.Style.medium
        return formater.string(from: joiningDate)
    }
    
    
}

extension GymMember {

    /// The Gym Member Swift Data model has constraints on certain properties.
    /// If these constraints are not met, an error may be thrown.
    
    enum GymMemberError: Error, LocalizedError {
        case emptyName
        
        var errorDescription: String? {
            switch self {
            case .emptyName:
                return "Name cannot be empty."
            }
        }
    }

}
