//
//  NotesTests.swift
//  NotesTests
//
//  Created by Aleksei Permiakov on 08.04.2023.
//

import XCTest
@testable import Notes

final class FolderListViewModelTests: XCTestCase {

    var coordinator: FolderListCoordinatorMock!
    var dataBase: DataBaseMock!
    var sut: FolderListViewModel!
    
    override func setUpWithError() throws {
        coordinator = .init()
        dataBase = .init()
        sut = .init(coordinator: coordinator, dataBase: dataBase)
    }

    override func tearDownWithError() throws {
        coordinator = nil
        dataBase = nil
        sut = nil
    }

    func test_folderIsCreatedWhenNameIsNotEmpty() {
        let folderName = "Test folder"
        
        sut.createFolder(name: folderName)
        
        XCTAssertEqual(folderName, dataBase.createdFolderName)
    }
    
    func test_folderIsNotCreatedWhenNameIsEmpty() {
        let folderName = ""
        
        sut.createFolder(name: folderName)
        
        XCTAssertNil(dataBase.createdFolderName)
    }
    
    func test_showNotesListCalled() {
        let folder = FolderStub()
        
        sut.showNotesList(folder: folder)
        
        XCTAssertIdentical(folder.contentObjectID, coordinator.listFolderId)
    }
    
    func test_folderDeleteCalled() {
        let folder = FolderStub()
        
        sut.delete(folder: folder)
        
        XCTAssertIdentical(folder, dataBase.deletedFolder)
    }
}
