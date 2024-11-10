//
//  MaruthiGymTrainerAppUITests.swift
//  MaruthiGymTrainerAppUITests
//
//  Created by Shameera on 25/10/24.
//

import XCTest

final class GymMemberAddViewUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }

    func testNavigateToGymMemberAddView() -> XCUIElement {
//        // Step 1: Verify `ContentView` is loaded
//        XCTAssertTrue(app.otherElements["ContentView"].exists, "ContentView should be visible at launch.")
//        
        // Step 2: Tap on `ExercisesListView` (if necessary, you can include a button or navigation action here to load the list view)
        let gymMembersListView = app.otherElements["GymMembersListView"]
        XCTAssertTrue(gymMembersListView.exists, "GymMembersListView should be visible.")
        
        // Step 3: Tap the Plus button in `ExercisesListView`
        let plusButton = gymMembersListView.buttons["PlusButton"]
        XCTAssertTrue(plusButton.exists, "Plus button should be present in ExercisesListView.")
        plusButton.tap()
        
        // Step 4: Verify `GymMemberAddView` is presented
        let gymMemberAddView = app.otherElements["GymMemberAddView"]
        XCTAssertTrue(gymMemberAddView.waitForExistence(timeout: 5), "GymMemberAddView should be presented after tapping Plus.")
        
        return gymMemberAddView
    }

    func testGymMemberAddViewNameInput() {
        // Navigate to GymMemberAddView
        let _ = testNavigateToGymMemberAddView()
        
       
        
        // Enter a name in the Name text field
        let nameTextField = app.collectionViews.textFields["gymMemberAddView_basicFields_section"]
        XCTAssertTrue(nameTextField.exists, "Name text field should be visible in GymMemberAddView.")
        nameTextField.tap()
        nameTextField.typeText("John Doe")
        
//        // Verify that "Done" button is enabled for valid name input
//        let doneButton = app.buttons["Done"]
//        XCTAssertTrue(doneButton.isEnabled, "Done button should be enabled after entering a valid name.")
    }

//    func testGymMemberAddViewCancelButton() {
//        // Navigate to GymMemberAddView
//        testNavigateToGymMemberAddView()
//
//        // Tap the "Cancel" button and verify the view dismisses
//        let cancelButton = app.buttons["Cancel"]
//        XCTAssertTrue(cancelButton.exists, "Cancel button should be visible in GymMemberAddView.")
//        cancelButton.tap()
//        
//        // Verify that GymMemberAddView is dismissed
//        let gymMemberAddView = app.otherElements["GymMemberAddView"]
//        XCTAssertFalse(gymMemberAddView.exists, "GymMemberAddView should be dismissed after tapping Cancel.")
//    }
}

