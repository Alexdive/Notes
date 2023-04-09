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
    private let router: Router
    
    init(router: Router) {
        self.router = router
    }
    
    func start() {
        Database.shared.open { 
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
