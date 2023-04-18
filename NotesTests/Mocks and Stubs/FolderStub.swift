//
//  FolderStub.swift
//  NotesTests
//
//  Created by Aleksei Permiakov on 08.04.2023.
//

import Foundation
@testable import Notes

class ObjectIDStub: ObjectID {}

class FolderStub: FolderProtocol {
    var creationDate: Date?
    var name: String?
    var notes: NSOrderedSet?
    
    var contentObjectID: ObjectID = ObjectIDStub()
}
