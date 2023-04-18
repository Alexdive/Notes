//
//  NoteListCoordinatorTests.swift
//  NotesTests
//
//  Created by Aleksei Permiakov on 10.04.2023.
//

import XCTest
@testable import Notes

final class NoteListCoordinatorTests: XCTestCase {
    var folderId: ObjectIDStub!
    var router: RouterMock!
    var sut: NoteListCoordinator!
    
    override func setUp() {
        super.setUp()
        folderId = .init()
        router = .init()
        sut = .init(router: router, folderId: folderId)
    }
    
    override func tearDown() {
        super.tearDown()
        folderId = nil
        router = nil
        sut = nil
    }
    
    func test_pushNotesListControllerOnStart() {
        sut.start()
       
        XCTAssertTrue(router.pushedViewController is NoteListViewController)
    }
    
    func test_pushNoteDetailControllerOnNoteCreationWithNoteIsNil() {
        sut.showNoteCreation()
        
        guard let noteDetailVC = router.pushedViewController as? NoteDetailsViewController else {
            XCTFail("Unexpectedly wrong type or missing view controller")
            return
        }
        
        XCTAssertEqual(router.pushedViewController, noteDetailVC)
        XCTAssertNil(noteDetailVC.viewModel.note)
    }
    
    func test_pushNoteDetailControllerOnNoteEditingWithTheNote() {
        let note = NoteStub()
        sut.showNoteDetails(note)
        
        guard let noteDetailVC = router.pushedViewController as? NoteDetailsViewController else {
            XCTFail("Unexpectedly wrong type or missing view controller")
            return
        }
        
        XCTAssertEqual(router.pushedViewController, noteDetailVC)
        XCTAssertIdentical(noteDetailVC.viewModel.note, note)
    }
}
