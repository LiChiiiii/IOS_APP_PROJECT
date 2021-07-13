//
//  GenreTypeState.swift
//  IOS_DEV
//
//  Created by Kao Li Chi on 2021/7/8.
//

import SwiftUI
import Combine
import Foundation

class GenreTypeState: ObservableObject {
    
    @Published var genreID = ""
    @Published var movies: [Movie]?
    @Published var isLoading = false
    @Published var error: NSError?
    
    
    private var subscriptionToken: AnyCancellable?
    
    let movieService: MovieService
    
    var isEmptyResults: Bool {
        !self.genreID.isEmpty && self.movies != nil && self.movies!.isEmpty
    }
    
    init(movieService: MovieService = MovieStore.shared) {
        self.movieService = movieService
    }
    
    func genreType(genreID: String) {
        self.movies = nil
        self.isLoading = false
        self.error = nil
        
        
        guard !genreID.isEmpty else {
            return
        }
        
        self.genreID = genreID
        
        self.isLoading = true
        self.movieService.GenreType(genreID: genreID) {[weak self] (result) in
            guard let self = self, self.genreID == genreID else { return }
            
            self.isLoading = false
            switch result {
            case .success(let response):
                self.movies = response.results
            case .failure(let error):
                self.error = error as NSError
            }
        }
    }

    
    deinit {
        self.subscriptionToken?.cancel()
        self.subscriptionToken = nil
    }
}
