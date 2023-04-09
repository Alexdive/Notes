//
//  NotesCoordinator.swift
//  Notes
//
//

import UIKit

class NoteListCoordinator: Coordinator {
    private let router: Router
    private let folderId: ObjectID
    
    init(router: Router, folderId: ObjectID) {
        self.router = router
        self.folderId = folderId
    }
    
    func start() {
        let notesController: NoteListViewController = NoteListViewController.instantiate()
        let dataSourece = NoteDataSource(folderId: folderId)
        notesController.viewModel = NoteListViewModel(coordinator: self, folderId: folderId, dataSource: dataSourece)
        router.push(notesController)
    }
    
    func showNoteCreation() {
        NoteDetailsCoordinator(router: router, folderId: folderId).start()
    }
    
    func showNoteDetails(_ note: NoteProtocol) {
        NoteDetailsCoordinator(router: router, folderId: folderId).start(note)
    }
}
