//
//  FilmCell.swift
//  IMDB
//
//  Created by NXH on 4/22/21.
//

import UIKit

class FilmCell: UITableViewCell {

    @IBOutlet private weak var bannerImage: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!

    var viewModel: FilmCellViewModel? {
        didSet {
            updateView()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    private func updateView() {
        guard let viewModel = viewModel else { return }
        titleLabel.text = viewModel.film.name

        guard let link = viewModel.film.imageLink else {
            return
        }
        guard let url = URL(string: link) else { return }
        bannerImage.load(url: url)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
