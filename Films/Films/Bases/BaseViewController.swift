//
//  BaseViewController.swift
//  Films
//
//  Created by fjcedron@hiberus.com on 3/1/22.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    func showAlertError (errorMessage: String) {
        let alert = UIAlertController(title: "ERROR", message: errorMessage, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
    }
}
