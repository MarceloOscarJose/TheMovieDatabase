//
//  BaseViewController.swift
//  TheMovieDatabase
//
//  Created by Marcelo José on 19/05/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import LPSnackbar

class BaseViewController: UIViewController {

    var snackbar: LPSnackbar!

    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        activityIndicator.color = UIColor.ligthBlue
        activityIndicator.stopAnimating()
        return activityIndicator
    }()

    var showActivityIndicator: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: activityIndicator, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: activityIndicator, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
    }

    func toggleActivityIndicator(show: Bool) {
        showActivityIndicator = show
        if show {
            let tinyDelay = DispatchTime.now() + Double(Int64(0.2 * Float(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
            DispatchQueue.main.asyncAfter(deadline: tinyDelay) {
                if self.showActivityIndicator {
                    self.activityIndicator.startAnimating()
                }
            }
        } else {
            activityIndicator.stopAnimating()
        }
    }

    func showSnackError(title: String, buttonText: String, view: UIView, completion: @escaping () -> Void) {
        if snackbar != nil {
            snackbar.dismiss()
        }

        snackbar = LPSnackbar(title: title, buttonTitle: buttonText)
        snackbar.viewToDisplayIn = view
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
