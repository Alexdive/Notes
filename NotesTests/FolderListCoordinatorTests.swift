//
//  FolderListCoordinatorTests.swift
//  NotesTests
//
//  Created by Aleksei Permiakov on 10.04.2023.
//

import XCTest
@testable import Notes

final class FolderListCoordinatorTests: XCTestCase {
    var router: RouterMock!
    var dataBase: DataBaseMock!
    var sut: FolderListCoordinator!
    
    override func setUp() {
        super.setUp()
        router = .init()
        dataBase = .init()
        sut = .init(router: router, dataBase: dataBase)
    }
    
    override func tearDown() {
        super.tearDown()
        router = nil
        dataBase = nil
        sut = nil
    }
    
    func test_dataBaseOpenCalledOnStart() {
        sut.start()
        
        XCTAssertTrue(dataBase.openHasCalled)
    }
    
    func test_setRootControllerOnStart() {
        sut.start()
        
        XCTAssertTrue(router.rootViewController is FolderListViewController)
    }
    
    func test_showNotesList() {
        let folderId = ObjectIDStub()
        
        sut.showNotesList(folderId: folderId)
        
        XCTAssertTrue(router.pushedViewController is NoteListViewController)
    }
    
}
