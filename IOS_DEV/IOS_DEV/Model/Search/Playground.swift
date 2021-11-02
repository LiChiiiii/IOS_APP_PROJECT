//
//  Playground.swift
//  IOS_DEV
//
//  Created by Jackson on 30/10/2021.
//

import Foundation

struct PersonInfoResponse : Decodable {
    let response : [PersonInfo]
}

struct GenreInfoResponse : Decodable {
    let response : [GenreInfo]
}

struct GenreInfo : Codable,Identifiable {
    var id : Int //genre id
    var name : String //genre name
    var describe_img : String //using any image which movie can describe this Genre (URL)
    
    var posterImg: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\( describe_img)")!
    }
}


struct MoviePreviewInfo : Codable,Identifiable{
    var id: Int?
    var title: String?
    var poster_path: String?
    var overview: String?
    var run_time: Int?
    var release_date: String?
    var original_language: String?
    var genres : [MovieGenre]?
    var casts : [MovieCast]?
    
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
    

    var posterURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(poster_path ?? "")")!
    }
    
    var genreText: String {
        genres?.first?.name ?? "n/a"
    }
    
    var yearText: String {
        guard let releaseDate = self.release_date, let date = Utils.dateFormatter.date(from: releaseDate) else {
            return "n/a"
        }
        return MoviePreviewInfo.yearFormatter.string(from: date)
    }
    
    var durationText: String {
        guard let runtime = self.run_time, runtime > 0 else {
            return "n/a"
        }
        return MoviePreviewInfo.durationFormatter.string(from: TimeInterval(runtime) * 60) ?? "n/a"
    }
    
//    var cast: [MovieCast]? {
//        casts?.cast
//    }
    
//    var crew: [MovieCrew]? {
//        credits?.crew
//    }
    
//    var directors: [MovieCrew]? {
//        crew?.filter { $0.job.lowercased() == "director" }
//    }
//    
//    var producers: [MovieCrew]? {
//        crew?.filter { $0.job.lowercased() == "producer" }
//    }
//    
//    var screenWriters: [MovieCrew]? {
//        crew?.filter { $0.job.lowercased() == "story" }
//    }
//    
//    var youtubeTrailers: [MovieVideo]? {
//        videos?.results.filter { $0.youtubeURL != nil }
//    }
}
