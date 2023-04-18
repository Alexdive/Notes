//
//  Database.swift
//  Notes
//
//

import Foundation
import CoreData

protocol Persistence {
    func open(completion: @escaping () -> Void)
    func createFolder(with name: String, creationDate: Date, completion: @escaping (Error?) -> Void)
    func createNote(with name: String, body: String, creationDate: Date, folderId: ObjectID)
    func delete(folder: FolderProtocol)
    func delete(note: NoteProtocol)
    func update(note: NoteProtocol, with name: String, body: String)
}

final class Database: Persistence {
    static let shared = Database()
    private init() { }
    
    let persistentContainer = NSPersistentContainer(name: "Notes")
    
    var viewContext: NSManagedObjectContext { persistentContainer.viewContext }
    
    func open(completion: @escaping () -> Void) {
        persistentContainer.loadPersistentStores(completionHandler: { [weak self] _, error in
            self?.viewContext.automaticallyMergesChangesFromParent = true
            
            DispatchQueue.main.async(execute: completion)
        })
    }

    func createFolder(with name: String, creationDate: Date, completion: @escaping (Error?) -> Void) {
        Folder.create(name: name,
                      creationDate: creationDate,
                      completion: completion)
    }
   
    func createNote(with name: String, body: String, creationDate: Date, folderId: ObjectID) {
        Note.create(name: name,
                    body: body,
                    creationDate: creationDate,
                    folderObjectId: folderId)
    }
    
    func delete(folder: FolderProtocol) {
        guard let folder = folder as? Folder else { return }
        
        folder.delete()
    }
    
    func delete(note: NoteProtocol) {
        guard let note = note as? Note else { return }
        
        note.delete()
    }
    
    func update(note: NoteProtocol, with name: String, body: String) {
        guard let note = note as? Note else { return }
        
        note.update(name: name, body: body)
    }
}
