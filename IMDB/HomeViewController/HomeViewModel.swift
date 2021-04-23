//
//  HomeViewModel.swift
//  IMDB
//
//  Created by NXH on 4/23/21.
//

import Foundation

final class HomeViewModel {

    var films: [Film] = []

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
        
    }
}
