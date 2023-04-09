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
    var dataSource: DataSourceMock!
    var sut: FolderListViewModel!
    
    override func setUp() {
        super.setUp()
        coordinator = .init()
        dataBase = .init()
        dataSource = .init()
        sut = .init(coordinator: coordinator, dataBase: dataBase, dataSource: dataSource)
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
