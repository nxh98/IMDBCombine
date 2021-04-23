//
//  SearchFilmsResponse.swift
//  IMDB
//
//  Created by NXH on 4/23/21.
//
import Foundation

extension ApiManager.SearchFilmsResponse {
    static func getFilms(name: String, completion: @escaping APISearchCompletion) {
        var films: [Film] = []
        let path = String(format: ApiManager.SearchFilms.path, name)
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
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        if let data = json as? [String: Any] {
                            if let titles = data["titles"] as? [[String: String]] {
                                for value in titles {
                                    let name = value["title"]
                                    let image = value["image"]
                                    let film = Film(name: name ?? "", imageLink: image)
                                    films.append(film)
                                }
                                completion(.success(films))
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
