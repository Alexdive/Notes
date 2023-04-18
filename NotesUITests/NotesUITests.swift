//
//  NotesUITests.swift
//  NotesUITests
//
//  Created by Aleksei Permiakov on 18.04.2023.
//

import iOSSnapshotTestCase
import XCTest
@testable import Notes

final class NotesUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    func test_folderIsCreatedInEmptyListWithNonEmptyName() {
        let name = "Test Folder Name"
        givenEmptyFolderList()
        whenCreateFolder(name: name)
        thenFolderExistsInTheList(name: name)
    }
    
    func test_folderIsNotCreatedIfEnteredTheSameName() {
        let name = "Test Folder Name"
        givenEmptyFolderList()
        whenCreateFolder(name: name)
        thenFolderExistsInTheList(name: name)
        
        whenCreateFolder(name: name)
        thenFolderListItemsCout(isEqualTo: 1)
    }
    
    func test_folderIsNotCreatedInEmptyListWithEmptyName() {
        let name = ""
        givenEmptyFolderList()
        whenCreateFolder(name: name)
        thenFolderListItemsCout(isEqualTo: 0)
    }
    
    func test_notesListIsShownWhenTapOnFolder() {
        let name = "Test Folder Name"
        resetAndLaunch()
        whenCreateFolder(name: name)
        whenTapOnFolder(name: name)
        thenNotesListIsPresented()
    }
    
    func test_noteIsCreated() {
        let folderName = "Test Folder Name"
        let noteBody = "Test note body"
        resetAndLaunch()
        whenCreateFolder(name: folderName)
        whenTapOnFolder(name: folderName)
        whenCreateNote(body: noteBody)
        whenNavigateBack()
        thenNoteExistsInTheList(body: noteBody)
    }
    
    func test_snapshotEmptyFolderList() {
        resetAndLaunch()
    }
    
    func resetAndLaunch() {
        app = XCUIApplication()
        app.launchArguments = ["--NotesUITests-Reset"]
        app.launch()
    }
    
    func givenEmptyFolderList() {
        resetAndLaunch()
    }
    
    func whenCreateFolder(name: String) {
        app.buttons["createFolderButton"].tap()
        app.textFields["folderNameTextField"].typeText(name)
        app.buttons["saveFolderName"].tap()
    }
    
    func whenCreateNote(body: String) {
        app.buttons["createNoteButton"].tap()
        app.textViews["noteTextView"].tap()
        app.textViews["noteTextView"].typeText(body)
    }
    
    func whenNavigateBack() {
        app.navigationBars.buttons.element(boundBy: 0).tap()
    }
    
    func whenTapOnFolder(name: String) {
        app.tables["foldersList"].staticTexts[name].tap()
    }
    
    func thenFolderExistsInTheList(name: String) {
        XCTAssertTrue(app.tables["foldersList"].staticTexts[name].exists)
    }
    
    func thenFolderListItemsCout(isEqualTo count: Int) {
        XCTAssertTrue(app.tables["foldersList"].cells.count == count)
    }
    
    func thenNotesListIsPresented() {
        XCTAssertTrue(app.tables["notesList"].exists)
    }
    
    func thenNoteExistsInTheList(body: String) {
        XCTAssertTrue(app.tables["notesList"].staticTexts[body].exists)
    }
}
