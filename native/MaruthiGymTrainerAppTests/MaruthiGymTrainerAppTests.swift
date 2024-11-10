//
//  MaruthiGymTrainerAppTests.swift
//  MaruthiGymTrainerAppTests
//
//  Created by Shameera on 25/10/24.
//

import XCTest
import SwiftData
import SwiftUI
import Foundation
@testable import MaruthiGymTrainerApp

final class GymMemberAddViewModelTests:XCTestCase {
    
    var viewModel:GymMemberAddView.ViewModel!
    
    
    override func setUp() {
        super.setUp()
        
        viewModel = GymMemberAddView.ViewModel()
    }
    
    override  func tearDown() {
        super.tearDown()
        
        viewModel = nil
        super.tearDown()
    }
    
    func testEmptyNameValidation()  {
        viewModel.name = ""
        
        XCTAssertTrue(viewModel.isValidNameInputs,"Error message not shown for empty name ")
        XCTAssertFalse(viewModel.isDoneButtonEnabled,"Done Button should be disabled for an empty name")

    }
    
    func testInvalidCharactersInName(){
        
        viewModel.name = "john123!"
        XCTAssertFalse(viewModel.isValidNameInputs,"Names with numbers and special characters should be invalid")
        XCTAssertFalse(viewModel.isDoneButtonEnabled,"Done button should disabled for invalid characters in name")
    }
    
    func testValidName() {
        
        viewModel.name = "john Yacob"
        XCTAssertTrue(viewModel.isValidNameInputs,"Alphabatic name should be valid")
        XCTAssertTrue(viewModel.isDoneButtonEnabled,"Done button should be enabled for valid  name")
    }
    
    func testExceededCharacterLimitInName() {
        
        
        viewModel.name =  String(repeating: "T", count: viewModel.nameNumberOfCharacters+1)
        
        XCTAssertFalse(viewModel.isValidNameInputs,"Name exceeding character limit should be invalid")
        XCTAssertFalse(viewModel.isDoneButtonEnabled,"Done button should be disabled for name exceeding character limit ")
    }

}
