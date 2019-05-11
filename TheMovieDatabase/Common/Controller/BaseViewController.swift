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

    var snackbar: LPSnackbar!

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
        if snackbar != nil {
            snackbar.dismiss()
        }

        snackbar = LPSnackbar(title: title, buttonTitle: buttonText)
        snackbar.view.titleLabel.font = UIFont.systemFont(ofSize: 15)
        snackbar.view.button.titleLabel?.font = UIFont.systemFont(ofSize: 15)

        snackbar.show(animated: true) {(undone) in
            if undone {
                completion()
                self.snackbar = nil
            }
        }
    }
}
