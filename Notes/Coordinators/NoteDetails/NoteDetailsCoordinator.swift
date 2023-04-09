//
//  NoteCoordinator.swift
//  Notes
//
//

import UIKit
import CoreData

class NoteDetailsCoordinator: Coordinator {
    private let router: Router
    private let folderId: ObjectID
    
    init(router: Router, folderId: ObjectID) {
        self.router = router
        self.folderId = folderId
    }
    
    func start() {
        let noteController: NoteDetailsViewController = NoteDetailsViewController.instantiate()
        noteController.viewModel = NoteDetailsViewModel(folderId: folderId)
        router.push(noteController)
    }
    
    func start(_ note: Note) {
        let noteController: NoteDetailsViewController = NoteDetailsViewController.instantiate()
        noteController.viewModel = NoteDetailsViewModel(folderId: folderId)
        noteController.viewModel.note = note
        router.push(noteController)
    }
}
