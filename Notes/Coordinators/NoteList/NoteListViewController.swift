//
//  NoteListViewController.swift
//  Notes
//
//

import UIKit

class NoteListViewController: UITableViewController {
    var viewModel: NoteListViewModel!
    
    @IBOutlet weak var sortButton: UIBarButtonItem!
    @IBOutlet weak var notesCountLabel: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.dataSource.delegate = self
        
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.register(UINib(nibName: NoteViewCell.nibName(), bundle: nil),
                           forCellReuseIdentifier: NoteViewCell.nibName())
        createSortMenu()
        updateToolBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setToolbarHidden(false, animated: true)
    }

    @IBAction func addNoteButtonAction(_ sender: UIBarButtonItem) {
        viewModel.addNoteTapped()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: NoteViewCell = dequeueCell(indexPath: indexPath)
        
        guard let note = viewModel.dataSource.object(at: indexPath) as? NoteProtocol else { return UITableViewCell()}
        
        cell.setupView(note: note)
        
        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataSource.sections?[section].numberOfObjects ?? 0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let note = viewModel.dataSource.object(at: indexPath) as? NoteProtocol else { return }
        
        viewModel.tappedNote(note: note)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            guard let note = viewModel.dataSource.object(at: indexPath) as? NoteProtocol else { return }
            
            viewModel.delete(note: note)
        }
    }
    
    private func createSortMenu() {
        sortButton.menu = createSortMenu(sortByName: { [weak self] _ in
            guard let self = self else { return }
            self.viewModel.sort(by: .name)
            self.tableView.reloadData()
        }, sortByDate: { [weak self] _ in
            guard let self = self else { return }
            self.viewModel.sort(by: .creationDate)
            self.tableView.reloadData()
        })
    }
    
    private func updateToolBar() {
        notesCountLabel.title = "\(viewModel.dataSource.sections?.first?.numberOfObjects ?? 0) notes"
    }
}

extension NoteListViewController: DataSourceDelegate {
    func controllerWillChangeContent() {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent() {
        updateToolBar()
        tableView.endUpdates()
    }
    
    func controller(didChange anObject: Any, at indexPath: IndexPath?, for type: DataSourceChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .left)
            }
        case .insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .automatic)
            }
        case .move:
            if let indexPath = indexPath, let newIndexPath = newIndexPath {
                tableView.moveRow(at: indexPath, to: newIndexPath)
            }
        case .update:
            if let indexPath = indexPath,
               let note = anObject as? Note,
               let cell = tableView.cellForRow(at: indexPath) as? NoteViewCell {
                cell.setupView(note: note)
            }
        }
    }
}
