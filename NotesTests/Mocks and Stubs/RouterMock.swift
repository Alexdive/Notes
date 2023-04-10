//
//  RouterMock.swift
//  NotesTests
//
//  Created by Aleksei Permiakov on 10.04.2023.
//

import UIKit
@testable import Notes

class RouterMock: Routing {
    var pushedViewController: UIViewController?
    var rootViewController: UIViewController?
    
    func push(_ viewController: UIViewController) {
        pushedViewController = viewController
    }
    
    func setRootController(_ viewController: UIViewController) {
        rootViewController = viewController
    }
}
