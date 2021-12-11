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
           movieName:"《蜘蛛俠：不戰無歸》Spider-Man: No Way Home",
           movieType: ["科幻","動作","冒險"],
           videoPlayer:AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "spider", ofType: "mp4")!)) ,
//            videoPlayer: AVPlayer(url:URL(string: "http://127.0.0.1:8080/trailer/SpiderManNoWayHome.mp4")!),
           videoReplay: false,
           maxValue: 0),
    
//
    Trailer(id:2,
           movieName:"七龍珠第20部劇場版【七龍珠超：布羅利】",
           movieType: ["動作"],
           videoPlayer:AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "dbs", ofType: "mp4")!)) ,
//            videoPlayer: AVPlayer(url:URL(string: "http://127.0.0.1:8080/trailer/dbs.mp4")!),
           videoReplay: false,
           maxValue: 0),
    
    Trailer(id:3,
           movieName:"七龍珠第21部劇場版【七龍珠超：超級英雄】",
           movieType: ["動作","冒險"],
           videoPlayer:AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "2020dbs", ofType: "mp4")!)) ,
//            videoPlayer: AVPlayer(url:URL(string: "http://127.0.0.1:8080/trailer/2020dbs.mp4")!),
           videoReplay: false,
           maxValue: 0),
    Trailer(id:4,
           movieName:"《黑寡婦》Black Widow",
           movieType: ["科幻","動作","冒險"],
           videoPlayer:AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "bw", ofType: "mp4")!)) ,
//            videoPlayer: AVPlayer(url:URL(string: "http://127.0.0.1:8080/trailer/bw.mp4")!),
           videoReplay: false,
           maxValue: 0),
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
