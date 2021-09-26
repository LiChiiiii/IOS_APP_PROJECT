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
    
//    @Published var genreID : Int
    private let movieService: MovieService
    @Published var movies: [Movie]?
    @Published var isLoading = false
    @Published var error: NSError?
    
    init(movieService: MovieService = MovieStore.shared) {
        self.movieService = movieService
    }
    
    func genreType(genreID: Int) {
        self.movies = nil
        self.isLoading = false
        self.error = nil
        self.movieService.GenreType(genreID: genreID) {[weak self] (result) in
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
    
    
    
//    private var subscriptionToken: AnyCancellable?
//
//    let movieService: MovieService
//
//    var isEmptyResults: Bool {
//        self.genreID == 0 && self.movies != nil && self.movies!.isEmpty
//    }
//
//    init(movieService: MovieService = MovieStore.shared) {
//        self.movieService = movieService
//        self.genreID = 0
//    }
//
//    func genreType(genreID: Int) {
//        self.movies = nil
//        self.isLoading = false
//        self.error = nil
//
//
//        guard (genreID == 0) else {
//            return
//        }
//
//        self.genreID = genreID
//
//        self.isLoading = true
//        self.movieService.GenreType(genreID: genreID) {[weak self] (result) in
//            guard let self = self, self.genreID == genreID else { return }
//
//            self.isLoading = false
//            switch result {
//            case .success(let response):
//                self.movies = response.results
//                print("==========")
//                print(response)
//            case .failure(let error):
//                self.error = error as NSError
//                print("==========")
//                print(error)
//            }
//        }
//    }
//
//
//    deinit {
//        self.subscriptionToken?.cancel()
//        self.subscriptionToken = nil
//    }
}
