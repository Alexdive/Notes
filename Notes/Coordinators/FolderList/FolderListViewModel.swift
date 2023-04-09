//
//  FolderViewModel.swift
//  Notes
//
//

import UIKit

class FolderListViewModel {
    private let dataBase: Persistence
    private let coordinator: FolderListCoordinating
    private var sort: SortCondition = .creationDate
    
    var dataSource: DataSourceProtocol
    
    internal init(coordinator: FolderListCoordinating,
                  dataBase: Persistence = Database.shared,
                  dataSource: DataSourceProtocol = FolderDataSource()) {
        self.coordinator = coordinator
        self.dataBase = dataBase
        self.dataSource = dataSource
        try? self.dataSource.performFetch()
    }
    
    func createFolder(name: String) {
        guard !name.isEmpty else { return }
        
        dataBase.createFolder(with: name,
                              creationDate: Date()) { _ in }
    }
    
    func delete(folder: FolderProtocol) {
        dataBase.delete(folder: folder)
    }
    
    func showNotesList(folder: FolderProtocol) {
        coordinator.showNotesList(folderId: folder.contentObjectID)
    }
    
    func sort(by sort: SortCondition) {
        guard sort != self.sort else { return }
        self.sort = sort
        
        dataSource.perform(sort: sort)
    }
}
