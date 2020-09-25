//
//  MovieController.swift
//  MovieSearch
//
//  Created by Jordan Bryant on 9/25/20.
//  Copyright © 2020 Jordan Bryant. All rights reserved.
//

import Foundation
import UIKit.UIImage

class MovieController {
    
    static let shared = MovieController()
    
    var favoriteMovies: [Movie] = []
    
    struct StringConstants {
        fileprivate static let apiKey = "ec1e4f4dc2af22e07876dbacf423ecd9"
        
        //base urls
        fileprivate static let baseUrl = "https://api.themoviedb.org/3/"
        fileprivate static let imageBaseUrl = "https://image.tmdb.org/t/p/w500/"
        
        //components
        fileprivate static let searchComponent = "search"
        fileprivate static let movieComponent = "movie"
        
        //query parameters
        fileprivate static let queryParam = "query"
        fileprivate static let apiKeyParam = "api_key"
    }
    
    //MARK: - API Calls
    
    static func searchMovies(searchText: String, completion: @escaping (Result <[Movie], MovieServiceError>) -> Void) {
        //URL Setup
        guard let url = URL(string: StringConstants.baseUrl) else { return completion(.failure(.invalidURL)) }
        let searchMoviesUrl = url.appendingPathComponent(StringConstants.searchComponent).appendingPathComponent(StringConstants.movieComponent)
        
        var components = URLComponents(url: searchMoviesUrl, resolvingAgainstBaseURL: true)
        let apiKeyQueryItem = URLQueryItem(name: StringConstants.apiKeyParam, value: StringConstants.apiKey)
        let searchQueryItem = URLQueryItem(name: StringConstants.queryParam, value: searchText)
        
        components?.queryItems = [apiKeyQueryItem, searchQueryItem]
        
        guard let finalUrl = components?.url else { return completion(.failure(.invalidURL)) }
        print(finalUrl.absoluteString)
        
        //API Call
        URLSession.shared.dataTask(with: finalUrl) { (data, _, error) in
            DispatchQueue.main.async {
                if let error = error {
                    return completion(.failure(.thrownError(error)))
                }
                
                guard let data = data else { return completion(.failure(.noData)) }
                
                do {
                    let topLevelDict = try JSONDecoder().decode(TopLevelDictionary.self, from: data)
                    completion(.success(topLevelDict.results))
                } catch {
                    return completion(.failure(.thrownError(error)))
                }
            }
        }.resume()
    }
    
    static func fetchImageForPath(imagePath: String, completion: @escaping (Result<UIImage, MovieServiceError>) -> Void) {
        //URL Setup
        guard let url = URL(string: StringConstants.imageBaseUrl) else { return completion(.failure(.invalidURL)) }
        let finalUrl = url.appendingPathComponent(imagePath)
        
        //API Call
        URLSession.shared.dataTask(with: finalUrl) { (data, _, error) in
            DispatchQueue.main.async {
                if let error = error {
                    return completion(.failure(.thrownError(error)))
                }
                
                guard let data = data else { return completion(.failure(.noData)) }
                guard let image = UIImage(data: data) else { return completion(.failure(.unableToDecodeImage)) }
                completion(.success(image))
            }
        }.resume()
    }
    
    //Handling Favoriting Movies
    func favoriteMovie(movie: Movie) {
        favoriteMovies.append(movie)
        saveToPersistentStore()
    }
    
    func unfavoriteMovie(movie: Movie) {
        guard let indexOfMovie = favoriteMovies.firstIndex(of: movie) else { return }
        favoriteMovies.remove(at: indexOfMovie)
        saveToPersistentStore()
    }
    
    //MARK: - Persistence
    
    //Get the url where we are saving our data
    func fileURL() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = paths[0]
        let filename = "favoriteMovies.json"
        let fullURL = documentDirectory.appendingPathComponent(filename)
        
        return fullURL
    }
    
    //Save the data at that url
    func saveToPersistentStore() {
        let encoder = JSONEncoder()
        
        do {
            let data = try encoder.encode(favoriteMovies)
            try data.write(to: fileURL())
        } catch let error {
            print("Error saving playlist: \(error.localizedDescription)")
        }
    }
    
    //Fetch the data from the url
    func loadFromPersistentStore() {
        let decoder = JSONDecoder()
        
        do {
            let data = try Data(contentsOf: fileURL())
            let favoriteMovies = try decoder.decode([Movie].self, from: data)
            self.favoriteMovies = favoriteMovies
        } catch let error {
            print("Error loading from storage: \(error.localizedDescription)")
        }
    }
}
