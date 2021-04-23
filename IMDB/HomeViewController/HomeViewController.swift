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

    // MARK: - Properties
    var viewModel = HomeViewModel()

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }


    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configAninimate()
    }

    // MARK: - Functions

    private func configTableView() {
        filmsTableView.dataSource = self
        filmsTableView.delegate = self
        filmsTableView.register(FilmCell.self, forCellReuseIdentifier: "FilmCell")
    }

    private func configAninimate() {
        UIView.animateKeyframes(withDuration: 10, delay: 0.5, options: .repeat) {
            self.searchBannerLabel.frame.origin.x = self.view.bounds.width
        }
    }
}

// MARK: - extension
extension HomeViewController: UITableViewDelegate {
    #warning("handle later")
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRow()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FilmCell", for: indexPath) as? FilmCell else { return UITableViewCell()}
        cell.viewModel =  viewModel.cellForRow(indexPath: indexPath)
        return cell
    }
}

