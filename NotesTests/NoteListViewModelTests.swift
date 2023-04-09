//
//  NoteListViewModelTests.swift
//  NotesTests
//
//  Created by Aleksei Permiakov on 09.04.2023.
//

import XCTest
@testable import Notes

final class NoteListViewModelTests: XCTestCase {
    
    var odjectId = ObjectIDStub()
    var coordinator: NoteListCoordinatorMock!
    var dataBase: DataBaseMock!
    var dataSource: DataSourceMock!
    var sut: NoteListViewModel!
    
    override func setUp() {
        super.setUp()
        coordinator = .init()
        dataBase = .init()
        dataSource = .init()
        sut = .init(coordinator: coordinator, folderId: odjectId, dataSource: dataSource, dataBase: dataBase)
    }
    
    override func tearDown() {
        super.tearDown()
        coordinator = nil
        dataBase = nil
        dataSource = nil
        sut = nil
    }
    
    func test_dataSourceFetchDataOnViewModelInit() {
        XCTAssertTrue(dataSource.hasPerformedFetch)
    }
    
    func test_addNoteAction() {
        sut.addNoteTapped()
        
        XCTAssertTrue(coordinator.noteCreationHasShown)
    }
    
    func test_deleteNoteAction() {
        let noteToDelete = NoteStub()
        
        sut.delete(note: noteToDelete)
        
        XCTAssertIdentical(noteToDelete, dataBase.deletedNote)
    }
    
    func test_tapNoteAction() {
        let noteToShow = NoteStub()
        
        sut.tappedNote(note: noteToShow)
        
        XCTAssertIdentical(noteToShow, coordinator.noteForDetails)
    }
    
    func test_sortPerformedForDifferentOrder() {
        let sortOption: SortCondition = .name
        
        sut.sort(by: sortOption)
        
        XCTAssertEqual(sortOption, dataSource.performedSort)
    }
    
    func test_sortNotPerformedForSameOrder() {
        let sortOption: SortCondition = .creationDate
        
        sut.sort(by: sortOption)
        
        XCTAssertNil(dataSource.performedSort)
    }
}

