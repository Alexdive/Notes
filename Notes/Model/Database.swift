//
//  Database.swift
//  Notes
//
//

import Foundation
import CoreData

enum Entity {
    case folder(name: String, creationDate: Date)
    case note(name: String, body: String, creationDate: Date, folderObjectId: ObjectID)
}

protocol Persistence {
    func create(entity: Entity, completion: @escaping (Error?) -> Void)
    func delete(folder: FolderProtocol)
}

final class Database {
    static let shared = Database()
    
    let persistentContainer = NSPersistentContainer(name: "Notes")
    
    var viewContext: NSManagedObjectContext { persistentContainer.viewContext }
    
    func open(completion: @escaping () -> Void) {
        persistentContainer.loadPersistentStores(completionHandler: { [weak self] _, error in
            self?.viewContext.automaticallyMergesChangesFromParent = true
            
            DispatchQueue.main.async(execute: completion)
        })
    }

    private init() { }
}

extension Database: Persistence {
    func create(entity: Entity, completion: @escaping (Error?) -> Void) {
        switch entity {
        case .folder(let name,
                     let creationDate):
            Folder.create(name: name,
                          creationDate: creationDate,
                          completion: completion)
        case .note(let name,
                   let body,
                   let creationDate,
                   let folderObjectId):
            Note.create(name: name,
                        body: body,
                        creationDate: creationDate,
                        folderObjectId: folderObjectId as! NSManagedObjectID)
        }
    }
    
    func delete(folder: FolderProtocol) {
        guard let folder = folder as? Folder else { return }
        
        folder.delete()
    }
}
