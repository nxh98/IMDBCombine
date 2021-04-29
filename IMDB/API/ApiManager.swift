//
//  ApiManager.swift
//  IMDB
//
//  Created by NXH on 4/23/21.
//

import Foundation

typealias APISearchCompletion = (APISearchResponse) -> ()
typealias APICompletion = (APIResponse) -> ()
typealias APIDetailsFilmCompletion = (APIDetailsFilm) -> ()


enum APISearchResponse {
    case success([Film])
    case failure
}

enum APIDetailsFilm {
    case success(FilmDetails)
    case failure
}

enum APIResponse {
    case success
    case failure
}

final class ApiManager {
    static var shared: ApiManager = ApiManager()

    let domain: String = "https://imdb-internet-movie-database-unofficial.p.rapidapi.com/"
    let headers = [
        "x-rapidapi-key": "b69cf18969mshda644dc8af839b8p1c60ccjsn8216e836a0db",
        "x-rapidapi-host": "imdb-internet-movie-database-unofficial.p.rapidapi.com"]
    
    // Request
    struct SearchFilms {}
    struct DetailFilm {}

    // Response
    struct SearchFilmsResponse {}
    struct DetailFilmResponse {}
}
