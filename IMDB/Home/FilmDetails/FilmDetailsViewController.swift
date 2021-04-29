//
//  FilmDetailsViewController.swift
//  IMDB
//
//  Created by NXH on 4/26/21.
//

import UIKit
import AVFoundation
import AVKit


final class FilmDetailsViewController: UIViewController {

    @IBOutlet private weak var posterImage: UIImageView!
    @IBOutlet private weak var pilotLabel: UILabel!
    @IBOutlet private weak var durationLabel: UILabel!
    @IBOutlet private weak var actorCollectionView: UICollectionView!

    // MARK: - Properties
    var viewModel: FilmDetailsViewModel = FilmDetailsViewModel()

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }

    // MARK: - Functions
    private func configUI() {
        navigationController?.isNavigationBarHidden = false
        title = viewModel.filmDetals?.title
        if let url = URL(string: viewModel.filmDetals?.poster ?? "") {
            posterImage.load(url: url)
        }
        durationLabel.text = viewModel.filmDetals?.duration
        pilotLabel.text = viewModel.filmDetals?.plot
    }

    // MARK: - @IBAction
    @IBAction private func watchTrailerTouchUpInside(_ sender: UIButton) {
        guard let url = URL(string: viewModel.filmDetals?.trailer ?? "") else { return }
        do {
            let myHTMLString = try String(contentsOf: url, encoding: .ascii)
            let pattern = "(https:\\/\\/imdb-video).+?(?=\\\\)"
            let regex = try NSRegularExpression(pattern: pattern, options: [])
            let nsString = myHTMLString as NSString
            let results = regex.firstMatch(in: myHTMLString,
                                                options: [], range: NSMakeRange(0, nsString.length))
            let content = results.map { nsString.substring(with: $0.range)} ?? ""
            if let videoURL = URL(string: content) {
                let player = AVPlayer(url: videoURL)
                let playerViewController = AVPlayerViewController()
                playerViewController.player = player
                self.present(playerViewController, animated: true) {
                    playerViewController.player!.play()
                    playerViewController.exitsFullScreenWhenPlaybackEnds = true
                }
            }
        } catch let error {
            print("Error: \(error)")
        }
    }
}
