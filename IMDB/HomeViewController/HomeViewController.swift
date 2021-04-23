//
//  HomeViewController.swift
//  IMDB
//
//  Created by NXH on 4/22/21.
//

import UIKit

final class HomeViewController: UIViewController {

    // MARK: - @IBOutlets
    @IBOutlet weak var searchBannerLabel: UILabel!
    @IBOutlet weak var searchFilmsTextField: UITextField!
    @IBOutlet weak var filmsTableView: UITableView!

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }


    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configAninimate()
    }

    // MARK: - Functions

    private func configUI() {

    }

    private func configAninimate() {
        UIView.animateKeyframes(withDuration: 7, delay: 0.5, options: .repeat) {
            self.searchBannerLabel.frame.origin.x = self.view.bounds.width
        }
    }
}
