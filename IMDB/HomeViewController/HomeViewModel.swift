//
//  HomeViewModel.swift
//  IMDB
//
//  Created by NXH on 4/23/21.
//

import Foundation
import Combine

final class HomeViewModel: NSObject {

    var films: [Film] = []
    var searchPublisher: PassthroughSubject<String, Never> = PassthroughSubject<String, Never>()
    var reloadPublisher: PassthroughSubject<Void, Never> = PassthroughSubject<Void, Never>()
    var subcriptions = Set<AnyCancellable>()

    override init() {
        super.init()
        self.searchFilms(text: "")
    }

    func numberOfRow() -> Int {
        return films.count
    }

    func cellForRow(indexPath: IndexPath) -> FilmCellViewModel? {
        guard 0 <= indexPath.row && indexPath.row < films.count else {
            return nil
        }
        return FilmCellViewModel(film: films[indexPath.row])
    }

    func searchFilms(text: String) {
        searchPublisher
            .debounce(for: 1.5, scheduler: DispatchQueue.main)
            .sink { (content) in
                ApiManager.SearchFilmsResponse.getFilms(name: content) { [weak self] result in
                    guard let this = self else { return }
                    switch result {
                    case .success(let response):
                        this.films = response
                        this.reloadPublisher.send()
                    case .failure:
                        break
                    }
                }
            }.store(in: &subcriptions)
    }
}
