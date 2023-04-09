//
//  Folder+CoreDataClass.swift
//  Notes
//
//
//

import Foundation
import CoreData

public protocol FolderProtocol: AnyObject, DataSourceResult {
    var creationDate: Date? { get set }
    var name: String? { get set }
    var notes: NSOrderedSet? { get set }
    
    var contentObjectID: ObjectID { get }
}

enum FolderError: Error {
    case existingFolder
}

public enum SortCondition: String {
    case name
    case creationDate
}

@objc(Folder)
public class Folder: NSManagedObject {
        
    static func create(name: String, creationDate: Date, completion: ((Error?) -> Void)?) {
        Database.shared.persistentContainer.performBackgroundTask { context in
            let fetchRequest: NSFetchRequest<Folder> = Folder.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "name == %@", name)
            fetchRequest.fetchLimit = 1

            if let result = try? context.fetch(fetchRequest), !result.isEmpty {
                completion?(FolderError.existingFolder)
                
                return
            }

            let folder = Folder(context: context)
            folder.name = name
            folder.creationDate = creationDate

            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }

            DispatchQueue.main.async {
                completion?(nil)
            }
        }
    }
    
    static func createFetchedResultsController(sort: SortCondition) -> NSFetchedResultsController<Folder> {
        let fetchRequest: NSFetchRequest<Folder> = Folder.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: sort.rawValue, ascending: true)]
        
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest,
                                             managedObjectContext: Database.shared.viewContext,
                                             sectionNameKeyPath: nil,
                                             cacheName: nil)
        return frc
    }
    
    func delete() {
        Database.shared.persistentContainer.performBackgroundTask { context in
            let folder = context.object(with: self.objectID)
            context.delete(folder)
            try? context.save()
        }
    }
}

extension Folder: FolderProtocol {
    public var contentObjectID: ObjectID { objectID }
}
