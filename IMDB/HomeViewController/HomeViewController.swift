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
        configUI()
        handleReload()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        searchFilmsTextField.endEditing(true)
    }

    // MARK: - Functions
    private func configUI() {
        configTableView()
    }

    private func handleReload() {
        viewModel.reloadPublisher.sink { _ in
            DispatchQueue.main.async {
                self.filmsTableView.reloadData()
            }
        }.store(in: &viewModel.subcriptions)
    }

    private func configTableView() {
        filmsTableView.dataSource = self
        filmsTableView.delegate = self
        let nib = UINib(nibName: "FilmCell", bundle: .main)
        filmsTableView.register(nib, forCellReuseIdentifier: "FilmCell")
    }

    @IBAction private func search(_ sender: UITextField) {
        viewModel.searchPublisher.send(sender.text ?? "")
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

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
