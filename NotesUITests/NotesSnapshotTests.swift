//
//  NotesSnapshotTests.swift
//  NotesUITests
//
//  Created by Aleksei Permiakov on 18.04.2023.
//

import iOSSnapshotTestCase
import XCTest

class SnapshotTestCase: FBSnapshotTestCase {
    override func setUp() {
        super.setUp()
        recordMode = false
    }
}

   //NOTE: Run on iPhone 14 Pro simulator
   //First run should be with recordMode = true to capture the snapshots
final class NotesSnapshotTests: SnapshotTestCase {

    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        resetAndLaunch()
    }
    
    func resetAndLaunch() {
        app = XCUIApplication()
        app.launchArguments = ["--NotesUITests-Reset"]
        app.launch()
    }
    
    func whenCreateFolder(name: String) {
        app.buttons["createFolderButton"].tap()
        app.textFields["folderNameTextField"].typeText(name)
        app.buttons["saveFolderName"].tap()
    }
    
    func verifyView(file: StaticString = #file, line: UInt = #line) {
        guard let croppedImage = app.screenshot().image.removingStatusBar else {
            return XCTFail("An error occurred while cropping the screenshot", file: file, line: line)
        }
        
        FBSnapshotVerifyView(UIImageView(image: croppedImage))
    }
    
    func test_emptyFolderListSnapshot() {
        verifyView()
    }
    
    func test_folderListWithOneFolder() {
        whenCreateFolder(name: "Test Folder Name")
        
        verifyView()
    }
}
