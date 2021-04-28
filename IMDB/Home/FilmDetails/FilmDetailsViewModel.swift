//
//  FilmDetailsViewModel.swift
//  IMDB
//
//  Created by NXH on 4/26/21.
//

import Foundation

final class FilmDetailsViewModel {

    var filmDetals: FilmDetails?

    func getDetailFilm(id: String, completion: @escaping APICompletion) {
        ApiManager.DetailFilmResponse.getDetailsFilm(id: id) { [weak self] (result) in
            guard let this = self else { return }
            switch result {
            case .success(let value):
                this.filmDetals = value
                completion(.success)
            case .failure:
                break
            }
        }
    }
}
