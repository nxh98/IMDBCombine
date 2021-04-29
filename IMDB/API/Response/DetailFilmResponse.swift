//
//  DetailFilmResponse.swift
//  IMDB
//
//  Created by NXH on 4/26/21.
//

import Foundation

extension ApiManager.DetailFilmResponse {
    
    static func getDetailsFilm(id: String, completion: @escaping APIDetailsFilmCompletion) {
        let path = String(format: ApiManager.DetailFilm.path, id)
        guard let url =  URL(string: path) else { return }
        let request = NSMutableURLRequest(url: url,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = ApiManager.shared.headers
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            DispatchQueue.main.async {
                let httpURLResponse = response as? HTTPURLResponse
                if httpURLResponse?.statusCode == 200 {
                    guard let data = data else { return }
                    do {
                        var casts: [Cast] = []
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        if let data = json as? [String: Any] {
                            if let titles = data["cast"] as? [[String: String]] {
                                for value in titles {
                                    let actor = value["actor"]
                                    let charactor = value["charactor"]
                                    let castId = value["actor_id"]
                                    let cast = Cast(id: castId ?? "", actor: actor ?? "", character: charactor ?? "")
                                    casts.append(cast)
                                }
//                                completion(.success(films))
                            }
                            let duration: String = data["lenght"] as? String ?? ""
                            let plot: String = data["plot"] as? String ?? ""
                            let poster: String = data["poster"] as? String ?? ""
                            let rating: Float = data["rating"] as? Float ?? 0.0
                            let ratingVotes: Int = data["rating_votes"] as? Int ?? 0 as Int
                            let title: String = data["title"] as? String ?? ""
                            let year: String = data["year"] as? String ?? ""
                            if let trailer = data["trailer"] as? [String: String] {
                                let linkTrailer = (trailer["link"] ?? "") as String
                                completion(.success(FilmDetails(title: title, casts: casts, duration: duration, plot: plot, poster: poster, rating: rating, ratingVotes: ratingVotes, trailer: linkTrailer, year: year)))
                            } else {
                                completion(.success(FilmDetails(title: title, casts: casts, duration: duration, plot: plot, poster: poster, rating: rating, ratingVotes: ratingVotes, trailer: "", year: year)))
                            }
                        }

                    } catch {
                        // Not handle
                    }
                }
            }
        })

        dataTask.resume()
    }
}
