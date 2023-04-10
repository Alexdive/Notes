//
//  Router.swift
//  Notes
//
//

import UIKit

protocol Routing {
    func push(_ viewController: UIViewController)
    func setRootController(_ viewController: UIViewController)
}

final class Router: Routing {
    private let rootViewController: UINavigationController
    
    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }
    
    func push(_ viewController: UIViewController) {
        rootViewController.pushViewController(viewController, animated: true)
    }
    
    func setRootController(_ viewController: UIViewController) {
        UIView.transition(with: rootViewController.view,
                          duration: 0.3,
                          options: .transitionCrossDissolve,
                          animations: { [weak self] in
                            self?.rootViewController.setViewControllers([viewController], animated: false)
                          })
    }
}

#if DEBUG
extension Router {
    var exposedRootVC: UINavigationController { return rootViewController }
}
#endif
