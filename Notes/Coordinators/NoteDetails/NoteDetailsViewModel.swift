//
//  NoteDetailsViewModel.swift
//  Notes
//
//

import Foundation

final class NoteDetailsViewModel {
    private let folderId: ObjectID
    private lazy var creationDate: Date = { note?.creationDate ?? Date() }()
    private let dataBase: Persistence
    
    var note: NoteProtocol?
    var creationDateTitle: String { creationDate.shortDate() }
    var body: String? { note?.body }
    
    init(folderId: ObjectID,
         dataBase: Persistence = Database.shared) {
        self.folderId = folderId
        self.dataBase = dataBase
    }
    
    func update(body: String) {
        guard !body.isEmpty else {
            return
        }
        
        let name = String(body.prefix(20))
        
        if let note = note {
            dataBase.update(note: note,
                            with: name,
                            body: body)
        } else {
            dataBase.createNote(with: name,
                                body: body,
                                creationDate: creationDate,
                                folderId: folderId)
        }
    }
}
