//
//  NotesCoordinator.swift
//  Notes
//
//

import UIKit

protocol NoteListCoordinating {
    func start()
    func showNoteCreation()
    func showNoteDetails(_ note: NoteProtocol)
}

final class NoteListCoordinator: Coordinator, NoteListCoordinating {
    private let router: Routing
    private let folderId: ObjectID
    
    init(router: Routing, folderId: ObjectID) {
        self.router = router
        self.folderId = folderId
    }
    
    func start() {
        let notesController: NoteListViewController = NoteListViewController.instantiate()
        let dataSourece = NoteDataSource(folderId: folderId)
        notesController.viewModel = NoteListViewModel(coordinator: self, dataSource: dataSourece)
        router.push(notesController)
    }
    
    func showNoteCreation() {
        NoteDetailsCoordinator(router: router, folderId: folderId).start()
    }
    
    func showNoteDetails(_ note: NoteProtocol) {
        NoteDetailsCoordinator(router: router, folderId: folderId).start(note)
    }
}
