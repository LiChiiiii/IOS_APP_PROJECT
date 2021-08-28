//
//  TestMovie.swift
//  IOS_DEV
//
//  Created by Kao Li Chi on 2021/5/2.
//

import Foundation

struct MovieResponse: Decodable {
    
    let results: [Movie]
}

struct Movie: Decodable, Identifiable, Hashable {
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    let id: Int
    let title: String
    let backdropPath: String?
    let posterPath: String?
    let overview: String
    let voteAverage: Double
    let voteCount: Int
    let runtime: Int?
    let releaseDate: String?
    let originalLanguage: String
    
    let genres: [MovieGenre]?
    let credits: MovieCredit?
    let videos: MovieVideoResponse?
    
    static private let yearFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        return formatter
    }()
    
    static private let durationFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.allowedUnits = [.hour, .minute]
        return formatter
    }()
    
    var backdropURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(backdropPath ?? "")")!
    }
    
    var posterURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath ?? "")")!
    }
    
    var genreText: String {
        genres?.first?.name ?? "n/a"
    }
    
    var ratingText: String {
        let rating = Int(voteAverage)/2
        let ratingText = (0..<rating).reduce("") { (acc, _) -> String in
            return acc + "★"
            
        }
        
        return ratingText
    }
    
    var scoreText: String {
        guard ratingText.count > 0 else {
            return "n/a"
        }
        return "\(ratingText.count)/5"
    }
    
    var yearText: String {
        guard let releaseDate = self.releaseDate, let date = Utils.dateFormatter.date(from: releaseDate) else {
            return "n/a"
        }
        return Movie.yearFormatter.string(from: date)
    }
    
    var durationText: String {
        guard let runtime = self.runtime, runtime > 0 else {
            return "n/a"
        }
        return Movie.durationFormatter.string(from: TimeInterval(runtime) * 60) ?? "n/a"
    }
    
    var cast: [MovieCast]? {
        credits?.cast
    }
    
    var crew: [MovieCrew]? {
        credits?.crew
    }
    
    var directors: [MovieCrew]? {
        crew?.filter { $0.job.lowercased() == "director" }
    }
    
    var producers: [MovieCrew]? {
        crew?.filter { $0.job.lowercased() == "producer" }
    }
    
    var screenWriters: [MovieCrew]? {
        crew?.filter { $0.job.lowercased() == "story" }
    }
    
    var youtubeTrailers: [MovieVideo]? {
        videos?.results.filter { $0.youtubeURL != nil }
    }
    
}

struct MovieGenreID: Decodable {    //抓特定類別用的
    
    let id: Int
}

struct MovieGenre: Decodable {
    
    let id: Int
    let name: String
}


struct MovieCredit: Decodable {
    
    let cast: [MovieCast]
    let crew: [MovieCrew]
}

struct MovieCast: Decodable, Identifiable {
    let id: Int
    let character: String
    let name: String
}

struct MovieCrew: Decodable, Identifiable {
    let id: Int
    let job: String
    let name: String
}

struct MovieVideoResponse: Decodable {
    
    let results: [MovieVideo]
}

struct MovieVideo: Decodable, Identifiable {
    
    let id: String
    let key: String
    let name: String
    let site: String
    
    var youtubeURL: URL? {
        guard site == "YouTube" else {
            return nil
        }
        return URL(string: "https://youtube.com/watch?v=\(key)")
    }
}



let stubbedMovie:[Movie] = [
    Movie(id: 338762, title: "Bloodshot", backdropPath: "/ocUrMYbdjknu2TwzMHKT9PBBQRw.jpg", posterPath: "/8WUVHemHFH2ZIP6NWkwlHWsyrEL.jpg", overview: "After he and his wife are murdered, marine Ray Garrison is resurrected by a team of scientists. Enhanced with nanotechnology, he becomes a superhuman, biotech killing machine—'Bloodshot'. As Ray first trains with fellow super-soldiers, he cannot recall anything from his former life. But when his memories flood back and he remembers the man that killed both him and his wife, he breaks out of the facility to get revenge, only to discover that there's more to the conspiracy than he thought.", voteAverage: 7.1, voteCount: 2324, runtime: 250, releaseDate: "2020-03-05", originalLanguage: "en", genres: [], credits: nil, videos: nil),
    Movie(id: 338763, title: "test1", backdropPath: "/ic0intvXZSfBlYPIvWXpU1ivUCO.jpg", posterPath: "/ic0intvXZSfBlYPIvWXpU1ivUCO.jpg", overview: "After he and his wife are murdered, marine Ray Garrison is resurrected by a team of scientists. Enhanced with nanotechnology, he becomes a superhuman, biotech killing machine—'Bloodshot'. As Ray first trains with fellow super-soldiers, he cannot recall anything from his former life. But when his memories flood back and he remembers the man that killed both him and his wife, he breaks out of the facility to get revenge, only to discover that there's more to the conspiracy than he thought.", voteAverage: 7.1, voteCount: 2324, runtime: 250, releaseDate: "2020-03-05", originalLanguage: "en", genres: [], credits: nil, videos: nil),
    Movie(id: 338764, title: "test2", backdropPath: "/xing0YOUsHS4qKFu7BtFSnZfAgJ.jpg", posterPath: "/xing0YOUsHS4qKFu7BtFSnZfAgJ.jpg", overview: "After he and his wife are murdered, marine Ray Garrison is resurrected by a team of scientists. Enhanced with nanotechnology, he becomes a superhuman, biotech killing machine—'Bloodshot'. As Ray first trains with fellow super-soldiers, he cannot recall anything from his former life. But when his memories flood back and he remembers the man that killed both him and his wife, he breaks out of the facility to get revenge, only to discover that there's more to the conspiracy than he thought.", voteAverage: 7.1, voteCount: 2324, runtime: 250, releaseDate: "2020-03-05", originalLanguage: "en", genres: [], credits: nil, videos: nil)
    
]

let GenreID:[MovieGenreID] = [
    MovieGenreID(id:28),
    MovieGenreID(id:12),
    MovieGenreID(id:16),
    MovieGenreID(id:35),

]

