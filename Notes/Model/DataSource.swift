//
//  DataSource.swift
//  Notes
//
//  Created by Aleksei Permiakov on 09.04.2023.
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
