//
//  NetworkingClient.swift
//  tableCollectionView
//
//  Created by Yasharth Saxena on 26/05/20.
//  Copyright © 2020 Yasharth Saxena. All rights reserved.
//

import Foundation

class NetworkingClient {
    static let shared = NetworkingClient()
    fileprivate let trendingBaseURL = "https://api.themoviedb.org/3/trending/all/day?api_key=a333965f7a1c10f7dd2ba481c59c9a62"
    var trendinMovieArray = [MovieModel]()
    
    func getTrendingMovies(completion: @escaping (Result<[MovieModel], Error>) -> Void) {
        if let url = URL(string: trendingBaseURL) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let data = data, error == nil else {
                    completion(.failure(error!))
                    return
                }
                
                do {
                    let decodedData = try JSONDecoder().decode(MovieNetworkingModel.self, from: data)
                    self.createTrendingMovieArray(with: decodedData)
                    completion(.success(self.trendinMovieArray))
                } catch {
                    completion(.failure(error))
                }
            }
        }
    }
    
    func createTrendingMovieArray(with model: MovieNetworkingModel) {
        for i in 0...19 {
            let id = model.results[i].id
            let name = model.results[i].name ?? model.results[i].title
            let title = model.results[i].title ?? model.results[i].name
            let posterPath = model.results[i].posterPath
            let backdropPath = model.results[i].backdropPath
            self.trendinMovieArray.append(MovieModel(id: id, name: name ?? "someName", title: title ?? "someTitle", posterPath: posterPath, backdropPath: backdropPath))
        }
    }
    
}
