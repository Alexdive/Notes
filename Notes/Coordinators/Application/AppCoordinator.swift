//
//  AppCoordinator.swift
//  Notes
//
//

import UIKit

protocol Coordinator {
    func start()
}

final class AppCoordinator: Coordinator {
    private let router: Router
    
    init(router: Router) {
        self.router = router
    }
    
    func start() {
        FolderListCoordinator(router: router).start()
    }
}
