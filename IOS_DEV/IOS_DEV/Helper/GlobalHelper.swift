//
//  GlobalHelper.swift
//  IOS_DEV
//
//  Created by Jackson on 10/4/2021.
//

import Foundation
import SwiftUI
import AVKit

//USE FOR FAKE DATA TO TEST UI

//USE LOCAL VIDEO URL
//Trainer list"
var VideoList:[Trailer] = [
    Trailer(id:1,
           movieName:"Avernger",
           movieType: ["Horro","Super Hero","Action"],
           videoPlayer:AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "v1", ofType: "mp4")!)) ,
           videoReplay: false),

    Trailer(id:2,
           movieName:"The Nun",
           movieType: ["Horro","Action"],
           videoPlayer:AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "v2", ofType: "mp4")!)) ,
           videoReplay: false),

    Trailer(id:3,
           movieName:"Thor",
           movieType: ["Super Hero","Action"],
           videoPlayer:AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "v3", ofType: "mp4")!)) ,
           videoReplay: false),

    Trailer(id:4,
           movieName:"Avernger 2",
           movieType: ["Horro","Super Hero","Action"],
           videoPlayer:AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "v4", ofType: "mp4")!)) ,
           videoReplay: false),

    Trailer(id:5,
           movieName:"Avernger 3",
           movieType: ["Horro","Super Hero","Action"],
           videoPlayer:AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "v5", ofType: "mp4")!)) ,
           videoReplay: false),

    Trailer(id:6,
           movieName:"Iron man 1",
           movieType: ["Horro","Super Hero","Action"],
           videoPlayer:AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "v6", ofType: "mp4")!)) ,
           videoReplay: false),

    Trailer(id:7,movieName:"Iron man 2",
           movieType: ["Horro","Super Hero","Action"],
           videoPlayer:AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "v7", ofType: "mp4")!)) ,
           videoReplay: false),

    Trailer(id:8,
           movieName:"Iron man 3",
           movieType: ["Horro","Super Hero","Action"],
           videoPlayer:AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "v8", ofType: "mp4")!)) ,
           videoReplay: false),

//    Trailer(id:9,
//           movieName:"Iron man 3",
//           movieType: ["Horro","Super Hero","Action"],
//           videoPlayer:AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "test", ofType: "mp4")!)) ,
//           videoReplay: false)
]


//let MovieList = [
//
//
//]



var ActorLists = [
    MovieActor(actorName: "Jackson", actorAvatorImage: "https://www.themoviedb.org/t/p/original/k1ALgZkOApYt7PIUBkUitmknXQC.jpg", actorCharactorName: "Iron Man"),
    MovieActor(actorName: "Tommy.TR", actorAvatorImage: "https://www.themoviedb.org/t/p/original/eLaZrxKKIbYTEAtGMebvETM688w.jpg", actorCharactorName: "Iron Man"),
    MovieActor(actorName: "Jackson", actorAvatorImage: "https://www.themoviedb.org/t/p/original/vJAUHFDb6Md0b38RrKN52FW99xI.jpg", actorCharactorName: "Iron Man"),
    MovieActor(actorName: "Jackson", actorAvatorImage: "https://www.themoviedb.org/t/p/original/jqMBPYP8qw3bZZ5Yx1hdDAekPY.jpg", actorCharactorName: "Iron Man"),
    MovieActor(actorName: "Jackson", actorAvatorImage: "https://www.themoviedb.org/t/p/original/gnjhCg36OlcUpXyUPbtNSBavoim.jpg", actorCharactorName: "Iron Man"),
    MovieActor(actorName: "Jackson", actorAvatorImage: "https://www.themoviedb.org/t/p/original/7g8md7KfgVfP6gAFB2mqt2cnUNY.jpg", actorCharactorName: "Iron Man"),
    MovieActor(actorName: "Jackson", actorAvatorImage: "https://www.themoviedb.org/t/p/original/nRNMJlqR33j84cGdB0RxstV3NYm.jpg", actorCharactorName: "Iron Man"),
    MovieActor(actorName: "Jackson", actorAvatorImage: "https://www.themoviedb.org/t/p/original/8Jh7IFVByBuZSYRtcqC7us36QVB.jpg", actorCharactorName: "Iron Man"),
    MovieActor(actorName: "Jackson", actorAvatorImage: "https://www.themoviedb.org/t/p/original/jnQTP4RRkoWnyO3yL2PgRHZi0tK.jpg", actorCharactorName: "Iron Man")
]

var CaptureLists = [
    MovieCapture(CaptureImage:"https://www.themoviedb.org/t/p/original/gzJnMEMkHowkUndn9gCr8ghQPzN.jpg"),
    MovieCapture(CaptureImage:"https://www.themoviedb.org/t/p/original/3ombg55JQiIpoPnXYb2oYdr6DtP.jpg"),
    MovieCapture(CaptureImage:"https://www.themoviedb.org/t/p/original/3WQqRrrctYQZC1Ub7OhI8BybScM.jpg"),
    MovieCapture(CaptureImage:"https://www.themoviedb.org/t/p/original/jxYROBerNLUExmqFb2yArglwIHd.jpg"),
    MovieCapture(CaptureImage:"https://www.themoviedb.org/t/p/original/bJCb1wNJ2EMMFIsWeixRlF7XDHA.jpg"),
    MovieCapture(CaptureImage:"https://www.themoviedb.org/t/p/original/7cGsa6sqTFsrws322p0QaIe7GUX.jpg")
]
//
//var MovieList:[MovieInfo] = [
//    MovieInfo(movieName: "Iron Mane", adult: false, desscription: "is a movie", movieLanguage: "english", releaseDate: Date(timeIntervalSince1970: .leastNormalMagnitude), movireTrainer: VideoList, moviePoster: [], movieBackDrop: [], movieType: ["Action",""], movieActor: <#T##[MovieActor]#>, movieRank: <#T##Float?#>),
//]
