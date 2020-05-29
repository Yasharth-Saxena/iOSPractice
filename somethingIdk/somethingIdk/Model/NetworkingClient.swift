//
//  NetworkingClient.swift
//  somethingIdk
//
//  Created by Yasharth Saxena on 27/05/20.
//  Copyright © 2020 Yasharth Saxena. All rights reserved.
//

import Foundation

class NetworkingClient {
    static let shared = NetworkingClient()
    fileprivate let popularBaseURL = "https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key=820016b7116f872f5f27bf56f9fdfb66"
    fileprivate let highestRatedBaseURL = "http://api.themoviedb.org/3/discover/movie?certification_country=US&certification=R&sort_by=vote_average.desc&api_key=820016b7116f872f5f27bf56f9fdfb66"
    
    var trendingArray = [MainMovieModel]()
    var popularArray = [MainMovieModel]()
    var highestRatedArray = [MainMovieModel]()
    
    func performRequest(urlString: String, completion: @escaping (Result<[MainMovieModel], Error>) -> Void) {
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let data = data, error == nil else {
                    completion(.failure(error!))
                    return
                }
                
                do {
                    let decodedData = try JSONDecoder().decode(MovieModel.self, from: data)
                    self.makeArray(with: decodedData, array: &self.trendingArray)
                    completion(.success(self.trendingArray))
                } catch {
                    completion(.failure(error))
                }
            }.resume()
        }
    }
    
    func getPopularMovies(completion: @escaping (Result<[MainMovieModel], Error>) -> Void) {
        if let url = URL(string: popularBaseURL) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let data = data, error == nil else {
                    completion(.failure(error!))
                    return
                }
                
                do {
                    let decodedData = try JSONDecoder().decode(MovieModel.self, from: data)
                    self.makeArray(with: decodedData, array: &self.popularArray)
                    completion(.success(self.popularArray))
                } catch {
                    completion(.failure(error))
                }
            }.resume()
        }
    }
    
    // gets highest rated movies rated R 
    func getHighestRatedMovies(completion: @escaping (Result<[MainMovieModel], Error>) -> Void) {
        if let url = URL(string: highestRatedBaseURL) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let data = data, error == nil else {
                    completion(.failure(error!))
                    return
                }
                
                do {
                    let decodedData = try JSONDecoder().decode(MovieModel.self, from: data)
                    self.makeArray(with: decodedData, array: &self.highestRatedArray)
                    completion(.success(self.highestRatedArray))
                } catch {
                    completion(.failure(error))
                }
            }.resume()
        }
    }
    
    func makeArray(with model: MovieModel, array: inout [MainMovieModel]) {
        for i in 0...19 {
            let id = model.results[i].id
            let name = model.results[i].name ?? model.results[i].title
            let title = model.results[i].title ?? model.results[i].name
            let imagePath = model.results[i].posterPath
            let backdropPath = model.results[i].backdropPath
            let someInstance = MainMovieModel(id: id, name: name ?? "someName", title: title ?? "someTitle", imagePath: imagePath, backdropPath: backdropPath)
            array.append(someInstance)
        }
    }
}
