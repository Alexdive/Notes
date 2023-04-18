//
//  FolderDataSourceMock.swift
//  NotesTests
//
//  Created by Aleksei Permiakov on 09.04.2023.
//

import Foundation
@testable import Notes

class DataSourceMock: DataSourceProtocol {
    // recorded invocations:
    var performedSort: SortCondition?
    var hasPerformedFetch = false
    
    // interface:
    var sections: [DataSourceSection]?
    
    var delegate: DataSourceDelegate?
    
    func object(at indexPath: IndexPath) -> DataSourceResult? {
        
        return nil
    }
    
    func perform(sort: SortCondition) {
        performedSort = sort
    }
    
    func performFetch() throws {
        hasPerformedFetch = true
    }
}
