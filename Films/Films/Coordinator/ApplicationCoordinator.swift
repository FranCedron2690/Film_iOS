//
//  ApplicationCoordinator.swift
//  Films
//
//  Created by fjcedron@hiberus.com on 27/12/21.
//

import UIKit

class ApplicationCoordinator: Coordinator {
    let window: UIWindow
    let rootViewController: UINavigationController
    let homeCoordinator: HomeCoordinator

    init(windowScene: UIWindowScene) {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        rootViewController = UINavigationController()

        homeCoordinator = HomeCoordinator(presenter: rootViewController)

        window.windowScene = windowScene

    }

    func start() {  // 6
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
        homeCoordinator.start()
    }
}
