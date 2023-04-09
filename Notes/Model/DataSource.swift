//
//  DataSource.swift
//  Notes
//
//  Created by Aleksei Permiakov on 08.04.2023.
//

import CoreData

public protocol DataSourceResult {}

public struct DataSourceSection {
    var numberOfObjects: Int
}

public protocol DataSourceProtocol {
    var sections: [DataSourceSection]? { get }
    var delegate: DataSourceDelegate? { get set }
    
    func object(at indexPath: IndexPath) -> DataSourceResult?
    func perform(sort: SortCondition)
    func performFetch() throws
}

public enum DataSourceChangeType {
    case delete, insert, move, update
}

extension DataSourceChangeType {
    init(type: NSFetchedResultsChangeType) {
        switch type {
        case .insert:
            self = .insert
        case .delete:
            self = .delete
        case .move:
            self = .move
        case .update:
            self = .update
        @unknown default:
            fatalError("Unexpected NSFetchedResultsChangeType")
        }
    }
}

public protocol DataSourceDelegate {
    func controllerWillChangeContent()
    func controllerDidChangeContent()
    func controller(didChange anObject: Any,
                    at indexPath: IndexPath?,
                    for type: DataSourceChangeType,
                    newIndexPath: IndexPath?)
}

class DataSource: NSObject, DataSourceProtocol {
    
    var fetchResultController: NSFetchedResultsController<Folder>
    
    init(sort: SortCondition) {
        self.fetchResultController = Folder.createFetchedResultsController(sort: sort)
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
        fetchResultController = Folder.createFetchedResultsController(sort: sort)
        fetchResultController.delegate = self
        try? performFetch()
    }
    
    func performFetch() throws {
        try fetchResultController.performFetch()
    }
}

extension DataSource: NSFetchedResultsControllerDelegate {
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
