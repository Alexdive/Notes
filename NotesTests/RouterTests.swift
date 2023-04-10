//
//  RouterTests.swift
//  NotesTests
//
//  Created by Aleksei Permiakov on 10.04.2023.
//

import XCTest
@testable import Notes

final class RouterTests: XCTestCase {
    var rootViewController: UINavigationController!
    var sut: Router!
    
    override func setUp() {
        super.setUp()
        rootViewController = .init()
        sut = .init(rootViewController: rootViewController)
    }
    
    override func tearDown() {
        super.tearDown()
        rootViewController = nil
        sut = nil
    }
    
    func test_rootViewControllerIsNotNilAndEmptyOnInit() {
        XCTAssertEqual(sut.exposedRootVC, rootViewController)
        XCTAssertTrue(sut.exposedRootVC.viewControllers.isEmpty)
    }
    
    func test_viewControllerPushed() {
        let vcToPush = UIViewController()
        
        sut.push(vcToPush)
        
        XCTAssertEqual(sut.exposedRootVC.viewControllers.last, vcToPush)
    }
    
    func test_rootViewControllerDidSet() {
        let newRootVC = UIViewController()
        
        sut.setRootController(newRootVC)
        
        XCTAssertEqual(sut.exposedRootVC.viewControllers.last, newRootVC)
    }
}
