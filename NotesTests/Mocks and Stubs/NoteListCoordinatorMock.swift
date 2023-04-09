//
//  NoteListCoordinatorMock.swift
//  NotesTests
//
//  Created by Aleksei Permiakov on 09.04.2023.
//

import Foundation
@testable import Notes

class NoteListCoordinatorMock: NoteListCoordinating {
    
    var noteCreationHasShown = false
    var noteForDetails: NoteProtocol?
    
    func showNoteCreation() {
        noteCreationHasShown = true
    }
    
    func showNoteDetails(_ note: NoteProtocol) {
        noteForDetails = note
    }
}
