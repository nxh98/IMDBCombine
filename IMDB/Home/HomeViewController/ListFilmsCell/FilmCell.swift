//
//  FilmCell.swift
//  IMDB
//
//  Created by NXH on 4/22/21.
//

import UIKit

final class FilmCell: UITableViewCell {

    // MARK: - @IBOutlets
    @IBOutlet  weak var bannerImage: UIImageView!
    @IBOutlet  weak var titleLabel: UILabel!

    // MARK: - Properties
    var viewModel: FilmCellViewModel? {
        didSet {
            updateView()
        }
    }

    // MARK: - Init
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        bannerImage.image = UIImage(systemName: "livephoto")
    }

    // MARK: - Functions
    private func updateView() {
        guard let viewModel = viewModel else { return }
        titleLabel.text = "Film: " + viewModel.film.name

        guard let link = viewModel.film.imageLink else {
            return
        }
        guard let url = URL(string: link) else { return }
        bannerImage.load(url: url)
    }
}
