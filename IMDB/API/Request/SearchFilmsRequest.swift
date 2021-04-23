//
//  SearchFilmsRequest.swift
//  IMDB
//
//  Created by NXH on 4/23/21.
//

extension ApiManager.SearchFilms {
    static var path: String { return ApiManager.shared.domain + "search/%@" }
}
