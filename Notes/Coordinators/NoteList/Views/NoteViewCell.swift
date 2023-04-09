//
//  NoteViewCell.swift
//  Notes
//
//

import UIKit

class NoteViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var noteTextLabel: UILabel!
    
    func setupView(note: NoteProtocol) {
        titleLabel.text = note.name
        dateLabel.text = note.creationDate?.shortDate()
        noteTextLabel.text = note.body
    }
}
