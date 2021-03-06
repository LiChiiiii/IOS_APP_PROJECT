//
//  MovieListState.swift
//  IOS_DEV
//
//  Created by Kao Li Chi on 2021/7/7.
//


import SwiftUI

class MovieListState: ObservableObject {

    @Published var movies: [Movie]?
    @Published var isLoading: Bool = false
    @Published var error: NSError?

    private let movieService: MovieService
    private let apiService : APIService
    
    init(movieService: MovieService = MovieStore.shared,apiService : APIService = APIService.shared) {
        self.movieService = movieService
        self.apiService = apiService
    }
    
    func loadMovies(with endpoint: MovieListEndpoint) {
        self.movies = nil
        self.isLoading = true
        self.movieService.fetchMovies(from: endpoint) { [weak self] (result) in
            guard let self = self else { return }
            self.isLoading = false
            switch result {
            case .success(let response):
                self.movies = response.results
                
            case .failure(let error):
                self.error = error as NSError
            }
        }
    }
    
    
    
    
}

