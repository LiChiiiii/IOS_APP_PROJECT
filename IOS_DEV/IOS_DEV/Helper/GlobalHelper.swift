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
var VideoList:[Traier] = [
    Traier(id:1,
           movieName:"Avernger",
           movieType: ["Horro","Super Hero","Action"],
           videoPlayer:AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "v1", ofType: "mp4")!)) ,
           videoReplay: false),

    Traier(id:2,
           movieName:"The Nun",
           movieType: ["Horro","Action"],
           videoPlayer:AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "v2", ofType: "mp4")!)) ,
           videoReplay: false),

    Traier(id:3,
           movieName:"Thor",
           movieType: ["Super Hero","Action"],
           videoPlayer:AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "v3", ofType: "mp4")!)) ,
           videoReplay: false),

    Traier(id:4,
           movieName:"Avernger 2",
           movieType: ["Horro","Super Hero","Action"],
           videoPlayer:AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "v4", ofType: "mp4")!)) ,
           videoReplay: false),

    Traier(id:5,
           movieName:"Avernger 3",
           movieType: ["Horro","Super Hero","Action"],
           videoPlayer:AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "v5", ofType: "mp4")!)) ,
           videoReplay: false),

    Traier(id:6,
           movieName:"Iron man 1",
           movieType: ["Horro","Super Hero","Action"],
           videoPlayer:AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "v6", ofType: "mp4")!)) ,
           videoReplay: false),

    Traier(id:7,movieName:"Iron man 2",
           movieType: ["Horro","Super Hero","Action"],
           videoPlayer:AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "v7", ofType: "mp4")!)) ,
           videoReplay: false),

    Traier(id:8,
           movieName:"Iron man 3",
           movieType: ["Horro","Super Hero","Action"],
           videoPlayer:AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "v8", ofType: "mp4")!)) ,
           videoReplay: false)

    
]


//let MovieList = [
//
//
//]
