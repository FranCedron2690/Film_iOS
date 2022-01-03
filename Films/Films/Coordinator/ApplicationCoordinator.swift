//
//  ApplicationCoordinator.swift
//  Films
//
//  Created by fjcedron@hiberus.com on 27/12/21.
//

import UIKit

class ApplicationCoordinator: Coordinator {
    let window: UIWindow  // 2
    let rootViewController: UINavigationController  //
    let homeCoordinator: HomeCoordinator

    init(windowScene: UIWindowScene) { // 4
        // creación de la ventana usada, con las proporciones de pantalla del dispositivo
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        //    kanjiStorage = KanjiStorage()
        rootViewController = UINavigationController()
        rootViewController.navigationBar.prefersLargeTitles = true

        homeCoordinator = HomeCoordinator(presenter: rootViewController)

        window.windowScene = windowScene

    }

    func start() {  // 6
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
        homeCoordinator.start()
    }
}
