//
//  DetailFilmRequest.swift
//  IMDB
//
//  Created by NXH on 4/23/21.
//

import Foundation

extension ApiManager.DetailFilm {
    static var path: String { return ApiManager.shared.domain + "film/%@" }
}
