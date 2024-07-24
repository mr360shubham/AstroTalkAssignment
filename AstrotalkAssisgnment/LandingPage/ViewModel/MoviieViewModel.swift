//
//  MoviieViewModel.swift
//  AstrotalkAssisgnment
//
//  Created by Shubham Baliyan on 10/07/24.
//

import Foundation

class MoviieViewModel {
    
    // MARK: Properties
    var movies: [Movie] = []
    var onMoviefetched: (() -> Void)?
    
    
    // MARK: API call 
    func fetchMovies(){
        guard let url = URL(string: "https://www.omdbapi.com/?apikey=2c0d1dab&s=dark") else {return}
            
        let task = URLSession.shared.dataTask(with: url){ [weak self] data, response, error in
            guard let data = data else {return}
            do{
                let movieResponse = try JSONDecoder().decode(MovieResponse.self, from: data)
                self?.movies = movieResponse.Search
                DispatchQueue.main.async {
                    self?.onMoviefetched?()
                }
            }catch{
                print(error)
            }
        }
        task.resume()
    }
}
