//
//  DataBaseMock.swift
//  NotesTests
//
//  Created by Aleksei Permiakov on 08.04.2023.
//

import Foundation
@testable import Notes

class DataBaseMock: Persistence {
    var createdFolderName: String?
    var deletedFolder: FolderProtocol?
    
    func create(entity: Notes.EntityType, completion: @escaping (Error?) -> Void) {
        switch entity {
        case .folder(let name, _):
            createdFolderName = name
        case .note(let name, let body, let creationDate, let folderObjectId):
            break
        }
    }
    
    func delete(folder: FolderProtocol) {
        deletedFolder = folder
    }
}
