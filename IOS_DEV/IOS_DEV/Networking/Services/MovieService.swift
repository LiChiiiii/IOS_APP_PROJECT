//
//  MovieService.swift
//  IOS_DEV
//
//  Created by Kao Li Chi on 2021/5/2.
//
// Interface, endpoint, error

import Foundation

protocol MovieService {

    func fetchMovies(from endpoint: MovieListEndpoint, completion: @escaping (Result<MovieResponse, MovieError>) -> ())
    func fetchMovie(id: Int, completion: @escaping (Result<Movie, MovieError>) -> ())
    func fetchMovieWithEng(id: Int, completion: @escaping (Result<Movie, MovieError>) -> ())
    func MovieReccomend(id: Int, completion: @escaping (Result<MovieResponse, MovieError>) -> ())
    func searchMovie(query: String, completion: @escaping (Result<MovieResponse, MovieError>) -> ())
    func searchPerson(query: String, completion: @escaping (Result<PersonResponse, MovieError>) -> ())
    func GenreType(genreID: Int, completion: @escaping (Result<MovieResponse, MovieError>) -> ())
    func fetchMovieImages(id: Int, completion: @escaping (Result<MovieImages, MovieError>) -> ())
    func fetchMovieResource(query: String, completion: @escaping (Result<[ResourceResponse], MovieError>) -> ())
    
}


protocol ServerAPIServerServiceInterface {
    
    //Searching and playground
    //TODO - Person data format
    func fetchActors(page : Int ,completion : @escaping (Result<PersonInfoResponse,MovieError>) ->  ())
    func fetchDirectors(page : Int ,completion : @escaping (Result<PersonInfoResponse,MovieError>) -> ())
    
    //TODO - Genre with description image of a referencing movie
    func fetchGenreById(genreID id :Int, dataSize size : Int , completion : @escaping (Result<GenreInfoResponse,MovieError>) -> ())
    func fetchAllGenres(completion : @escaping (Result<GenreInfoResponse,MovieError>) -> ())
    
    //TODO -Preview API
    func getPreviewMovie(datas : [DragItemData],completion : @escaping (Result<MoviePreviewInfo,MovieError>) -> ())
    func getPreviewMovieList(completion : @escaping (Result<[MoviePreviewInfo],MovieError>) -> ())
    
    //TODO -Search API
    func getRecommandtionSearch(query key: String,completion : @escaping (Result<Movie,MovieError>)-> ())
    func getHotSeachingList(completion : @escaping (Result<[SearchHotItem],MovieError>)->())
    
    //TODO -MovieAPI
    func getMovieCardInfoByGenre(genre:GenreType,completing : @escaping (Result<MovieCardResponse,MovieError>)->())
    
}


enum MovieListEndpoint: String, CaseIterable, Identifiable {

    var id: String { rawValue }

    case nowPlaying = "now_playing"
    case upcoming
    case topRated = "top_rated"
    case popular

    var description: String {
        switch self {
            case .nowPlaying: return "Now Playing"
            case .upcoming: return "Upcoming"
            case .topRated: return "Top Rated"
            case .popular: return "Popular"
        }
    }
}

enum MovieError: Error, CustomNSError {

    case apiError
    case invalidEndpoint
    case invalidResponse
    case noData
    case serializationError

    var localizedDescription: String {
        switch self {
        case .apiError: return "Failed to fetch data"
        case .invalidEndpoint: return "Invalid endpoint"
        case .invalidResponse: return "Invalid response"
        case .noData: return "No data"
        case .serializationError: return "Failed to decode data"
        }
    }

    var errorUserInfo: [String : Any] {
        [NSLocalizedDescriptionKey: localizedDescription]
    }

}



enum GenreType : Int{
    case Action = 28
    case Adventure = 12
    case Animation = 16
    case Comedy = 35
    case Crime = 80
    case Documentary = 99
    case Drama = 18
    case Family = 10751
    case Fantasy = 14
    case History = 36
    case Horror = 27
    case Music = 10402
    case Mystery = 9648
    case Romance = 10749
    case ScienceFiction = 878
    case TvMovie = 10770
    case Thriller = 53
    case War = 10752
    case Western = 37

}
