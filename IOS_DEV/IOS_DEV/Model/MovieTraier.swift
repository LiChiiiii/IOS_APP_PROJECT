//
//  Movie.swift
//  IOS_DEV
//
//  Created by Jackson on 7/4/2021.

import Foundation
import SwiftUI
import AVKit

struct Trailer:Identifiable{
    var id : Int
    var movieName:String
    var movieType:[String]
    var videoPlayer:AVPlayer
    var videoReplay:Bool
  //  var isLike:Bool
}

struct MovieInfo:Identifiable{
    var id = UUID().uuidString //To identify each movie
    let movieName:String //Current  MovieName
    let adult:Bool //18+?
    let desscription:String
    let movieLanguage:String
    let releaseDate:Date
    let movireTrainer:[Trailer]?
    let moviePoster:[String]?
    let movieBackDrop:[String]?
    let movieType:[String]
    let movieActor:[MovieActor]
    let movieRank:Float?
}



struct MovieActor{
    let actorName :String!
    let actorAvatorImage : String!
    let actorCharactorName : String!
}

struct MovieStuff{
    let actorName :String!
    let actorAvatorImage : String!
    let actorCharactorName : String!
}


struct MovieCapture{
    let CaptureImage:String!
}


