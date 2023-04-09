//
//  NoteDetailsViewModelTests.swift
//  NotesTests
//
//  Created by Aleksei Permiakov on 09.04.2023.
//

import XCTest
@testable import Notes

final class NoteDetailsViewModelTests: XCTestCase {
    var dataBase: DataBaseMock!
    var sut: NoteDetailsViewModel!
    
    let testBodyString = String(repeating: "testString", count: 10)
    
    var testNameString: String { String(testBodyString.prefix(20)) }
    
    override func setUp() {
        super.setUp()
        dataBase = .init()
        sut = .init(folderId: ObjectIDStub(), dataBase: dataBase)
    }
    
    override func tearDown() {
        super.tearDown()
        dataBase = nil
        sut = nil
    }
    
    func test_updateActionReturnsIfBodyIsEmptyString() {
        let emptyString = ""
        
        sut.update(body: emptyString)
        
        XCTAssertNil(dataBase.updatedNoteName)
        XCTAssertNil(dataBase.updatedNoteBody)
        XCTAssertNil(dataBase.updatedNote)
    }
    
    func test_updateActionSaveNoteIfBodyIsNotEmptyAndNoteIsNil() {
        sut.note = nil
        
        sut.update(body: testBodyString)
        
        XCTAssertEqual(testNameString, dataBase.createdNoteName)
        XCTAssertEqual(testBodyString, dataBase.createdNoteBody)
        
        XCTAssertNil(dataBase.updatedNoteName)
        XCTAssertNil(dataBase.updatedNoteBody)
        XCTAssertNil(dataBase.updatedNote)
    }
    
    func test_updateActionUpdateNoteIfBodyIsNotEmptyAndNoteIsNotNil() {
        let note = NoteStub()
        sut.note = note
        
        sut.update(body: testBodyString)
        
        XCTAssertIdentical(note, dataBase.updatedNote)
        XCTAssertEqual(testNameString, dataBase.updatedNoteName)
        XCTAssertEqual(testBodyString, dataBase.updatedNoteBody)
        
        XCTAssertNil(dataBase.createdNoteName)
        XCTAssertNil(dataBase.createdNoteBody)
    }
}
