//
//  FoldersCoordintor.swift
//  Notes
//
//

import UIKit

protocol FolderListCoordinating {
    func showNotesList(folderId: ObjectID)
}

class FolderListCoordinator: Coordinator {
    private let router: Routing
    let dataBase: Persistence
    
    init(router: Routing, dataBase: Persistence = Database.shared) {
        self.router = router
        self.dataBase = dataBase
    }
    
    func start() {
        dataBase.open {
            let folderController: FolderListViewController = FolderListViewController.instantiate()
            folderController.viewModel = FolderListViewModel(coordinator: self)
            
            self.router.setRootController(folderController)
        }
    }
}

extension FolderListCoordinator: FolderListCoordinating {
    func showNotesList(folderId: ObjectID) {
        NoteListCoordinator(router: router, folderId: folderId).start()
    }
}
