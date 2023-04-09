//
//  NoteDataSource.swift
//  Notes
//
//  Created by Aleksei Permiakov on 09.04.2023.
//

import CoreData

class NoteDataSource: NSObject, DataSourceProtocol {
    
    var folderId: ObjectID
    var fetchResultController: NSFetchedResultsController<Note>
    
    init(sort: SortCondition = .creationDate, folderId: ObjectID) {
        self.folderId = folderId
        self.fetchResultController = Note.createFetchedResultsController(sort: sort, folderId: folderId)
        super.init()
    }
    
    var sections: [DataSourceSection]? {
        guard let sections = fetchResultController.sections else { return nil }
        return sections.map { DataSourceSection.init(numberOfObjects: $0.numberOfObjects) }
    }
    
    var delegate: DataSourceDelegate? {
        didSet {
            if delegate == nil {
                fetchResultController.delegate = nil
            } else {
                fetchResultController.delegate = self
            }
        }
    }
    
    func object(at indexPath: IndexPath) -> DataSourceResult? {
        return fetchResultController.object(at: indexPath)
    }
    
    func perform(sort: SortCondition) {
        fetchResultController = Note.createFetchedResultsController(sort: sort, folderId: folderId)
        fetchResultController.delegate = self
        try? performFetch()
    }
    
    func performFetch() throws {
        try fetchResultController.performFetch()
    }
}

extension NoteDataSource: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        DispatchQueue.main.async {
            self.delegate?.controllerWillChangeContent()
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        DispatchQueue.main.async {
            self.delegate?.controllerDidChangeContent()
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any,
                    at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType,
                    newIndexPath: IndexPath?) {
        
        DispatchQueue.main.async {
            self.delegate?.controller(didChange: anObject,
                                      at: indexPath,
                                      for: .init(type: type),
                                      newIndexPath: newIndexPath)
        }
    }
}

