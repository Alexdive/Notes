//
//  FolderListCoordinatorMock.swift
//  NotesTests
//
//  Created by Aleksei Permiakov on 08.04.2023.
//

import Foundation
@testable import Notes

class FolderListCoordinatorMock: FolderListCoordinating {
    
    var listFolderId: ObjectID?
    
    func showNotesList(folderId: ObjectID) {
        listFolderId = folderId
    }
}
