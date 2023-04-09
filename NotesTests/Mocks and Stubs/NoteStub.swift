//
//  NoteStub.swift
//  NotesTests
//
//  Created by Aleksei Permiakov on 09.04.2023.
//

import Foundation
@testable import Notes

class NoteStub: NoteProtocol {
    var body: String?
    var creationDate: Date?
    var name: String?
    var folder: Notes.Folder?
    
    var contentObjectID: ObjectID = ObjectIDStub()
}
