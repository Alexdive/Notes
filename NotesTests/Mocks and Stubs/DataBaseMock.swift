//
//  DataBaseMock.swift
//  NotesTests
//
//  Created by Aleksei Permiakov on 08.04.2023.
//

import Foundation
@testable import Notes

class DataBaseMock: Persistence {
    // recorded invocations:
    var openHasCalled = false
    
    var createdFolderName: String?
    var deletedFolder: FolderProtocol?
    
    var createdNoteName: String?
    var createdNoteBody: String?
    
    var deletedNote: NoteProtocol?
    
    var updatedNote: NoteProtocol?
    var updatedNoteName: String?
    var updatedNoteBody: String?
    
    // interface:
    func open(completion: @escaping () -> Void) {
        openHasCalled = true
        completion()
    }
    
    func createFolder(with name: String, creationDate: Date, completion: @escaping (Error?) -> Void) {
        createdFolderName = name
    }
    
    func createNote(with name: String, body: String, creationDate: Date, folderId: ObjectID) {
        createdNoteName = name
        createdNoteBody = body
    }
    
    func delete(folder: FolderProtocol) {
        deletedFolder = folder
    }
    
    func delete(note: NoteProtocol) {
        deletedNote = note
    }
    
    func update(note: NoteProtocol, with name: String, body: String) {
        updatedNote = note
        updatedNoteName = name
        updatedNoteBody = body
    }
    
    
}
