//
//  TableViewCell.swift
//  Notes
//
//

import UIKit

class FolderViewCell: UITableViewCell {
    @IBOutlet weak var notesCountLabel: UILabel!
    @IBOutlet weak var folderNameLabel: UILabel!
    
    func setupViews(folder: Folder) {
        notesCountLabel.text = String(folder.notes?.count ?? 0)
        folderNameLabel.text = folder.name
    }
}
