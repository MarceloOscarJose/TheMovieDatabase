//
//  BaseViewController.swift
//  TheMovieDatabase
//
//  Created by Marcelo José on 10/05/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import UIKit
import LPSnackbar

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupControls()
        setupConstraints()
    }

    // Mark: Override func
    func setupControls() {
    }

    func setupConstraints() {
    }

    func showSnakError(title: String, buttonText: String, completion: @escaping () -> Void) {
        let snackbar = LPSnackbar(title: title, buttonTitle: buttonText)
        snackbar.show(animated: true) {(undone) in
            if undone {
                completion()
            }
        }
    }
}
