//
//  NotesViewModel.swift
//  Notes
//
//

import UIKit

class NoteListViewModel {
    private let coordinator: NoteListCoordinating
    private var sort: SortCondition = .creationDate
    private let dataBase: Persistence
    
    var dataSource: DataSourceProtocol
    
    init(coordinator: NoteListCoordinating,
         dataSource: DataSourceProtocol,
         dataBase: Persistence = Database.shared) {
        self.coordinator = coordinator
        self.dataBase = dataBase
        self.dataSource = dataSource
        
        try? self.dataSource.performFetch()
    }

    func addNoteTapped() {
        coordinator.showNoteCreation()
    }
    
    func delete(note: NoteProtocol) {
        dataBase.delete(note: note)
    }
    
    func tappedNote(note: NoteProtocol) {
        coordinator.showNoteDetails(note)
    }
    
    func sort(by sort: SortCondition) {
        guard sort != self.sort else { return }
        self.sort = sort
        
        dataSource.perform(sort: sort)
    }
}
