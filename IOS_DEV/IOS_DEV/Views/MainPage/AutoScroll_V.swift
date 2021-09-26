//
//  AutoScroll.swift
//  IOS_DEV
//
//  Created by 張馨予 on 2021/5/18.
//

import SwiftUI
import UIKit
import MobileCoreServices
import SDWebImageSwiftUI
import CoreHaptics

/*
 {"genres":[{"id":28,"name":"Action"},
 {"id":12,"name":"Adventure"},
 {"id":16,"name":"Animation"},
 {"id":35,"name":"Comedy"},
 {"id":80,"name":"Crime"},
 {"id":99,"name":"Documentary"},
 {"id":18,"name":"Drama"},
 {"id":10751,"name":"Family"},
 {"id":14,"name":"Fantasy"},
 {"id":36,"name":"History"},
 {"id":27,"name":"Horror"},
 {"id":10402,"name":"Music"},
 {"id":9648,"name":"Mystery"},
 {"id":10749,"name":"Romance"},
 {"id":878,"name":"Science Fiction"},
 {"id":10770,"name":"TV Movie"},
 {"id":53,"name":"Thriller"},
 {"id":10752,"name":"War"},
 {"id":37,"name":"Western"}
 ]}
 
 */
//----------------Genre Data------------------------
var tempGenreData : [GenreData] = [
    GenreData(id:28,name:"Action"),
    GenreData(id:12,name:"Animation"),
    GenreData(id:35,name:"Comedy"),
    GenreData(id:80,name:"Crime"),
    GenreData(id:99,name:"Documentary"),
    GenreData(id:10751,name:"Family"),
    GenreData(id:14,name:"Fantasy"),
    GenreData(id:36,name:"History"),
    GenreData(id:27,name:"Horror"),
    GenreData(id:10402,name:"Music"),
]

var tempDragGenreData : [DragGenreData] = [
    DragGenreData(info:tempGenreData[0],describeImg : "https://image.tmdb.org/t/p/original/bZnOioDq1ldaxKfUoj3DenHU7mp.jpg"),
    DragGenreData(info:tempGenreData[1],describeImg : "https://image.tmdb.org/t/p/original/34nDCQZwaEvsy4CFO5hkGRFDCVU.jpg"),
    DragGenreData(info:tempGenreData[2],describeImg : "https://image.tmdb.org/t/p/original/ic0intvXZSfBlYPIvWXpU1ivUCO.jpg"),
    DragGenreData(info:tempGenreData[3],describeImg : "https://image.tmdb.org/t/p/original/oxNoVgbu2v9ETL93Kri1pw8osYf.jpg"),
    DragGenreData(info:tempGenreData[4],describeImg : "https://image.tmdb.org/t/p/original/kU3EJpMLrGrrzcZ0oIgBiFvXbpj.jpg"),
    DragGenreData(info:tempGenreData[5],describeImg : "https://image.tmdb.org/t/p/original/ic0intvXZSfBlYPIvWXpU1ivUCO.jpg"),
    DragGenreData(info:tempGenreData[6],describeImg : "https://image.tmdb.org/t/p/original/9dKCd55IuTT5QRs989m9Qlb7d2B.jpg"),
    DragGenreData(info:tempGenreData[7],describeImg : "https://image.tmdb.org/t/p/original/1JRRvx5RotvWM1maeq9r82ktdHi.jpg"),
    DragGenreData(info:tempGenreData[8],describeImg : "https://image.tmdb.org/t/p/original/dGv2BWjzwAz6LB8a8JeRIZL8hSz.jpg"),
    DragGenreData(info:tempGenreData[9],describeImg : "https://image.tmdb.org/t/p/original/mab5wPeGVjbMyYMzyzfdKKnG9cl.jpg"),
]

var tempDragDataGenre: [DragItemData] = [
    DragItemData(itemType: .Genre, genreData: tempDragGenreData[0], personData: nil),
    DragItemData(itemType: .Genre, genreData: tempDragGenreData[1], personData: nil),
    DragItemData(itemType: .Genre, genreData: tempDragGenreData[2], personData: nil),
    DragItemData(itemType: .Genre, genreData: tempDragGenreData[3], personData: nil),
    DragItemData(itemType: .Genre, genreData: tempDragGenreData[4], personData: nil),
    DragItemData(itemType: .Genre, genreData: tempDragGenreData[5], personData: nil),
    DragItemData(itemType: .Genre, genreData: tempDragGenreData[6], personData: nil),
    DragItemData(itemType: .Genre, genreData: tempDragGenreData[7], personData: nil),
    DragItemData(itemType: .Genre, genreData: tempDragGenreData[8], personData: nil),
    DragItemData(itemType: .Genre, genreData: tempDragGenreData[9], personData: nil),
]

//----------------Actor Data------------------------
var actorTemp : [Person] = [
    Person(id: 115440, name: "Sydney Sweeney", knownForDepartment: "Acting", profilePath: "/kKRVtMkxJoIqswx8gxAuEe0LZB4.jpg", knownFor: []),
    Person(id: 1136406, name: "Tom Holland", knownForDepartment: "Acting", profilePath: "/l6zPRmg8NI7Y65G5GUqwvjxFdsx.jpg", knownFor: []),
    Person(id: 73968, name: "Henry Cavill", knownForDepartment: "Acting", profilePath: "/iWdKjMry5Pt7vmxU7bmOQsIUyHa.jpg", knownFor: []),
    Person(id: 117642, name: "Jason Momoa", knownForDepartment: "Acting", profilePath: "/6dEFBpZH8C8OijsynkSajQT99Pb.jpg", knownFor: []),
    Person(id: 1372369, name: "Samara Weaving", knownForDepartment: "Acting", profilePath: "/iEciTz4yZQ6enJr5IxyyW7NQUEb.jpg", knownFor: []),
    Person(id: 25837, name: "Elisha Cuthbert", knownForDepartment: "Acting", profilePath: "/jyo887Q2c3wgME6VqY92BvhENzb.jpg", knownFor: []),
    Person(id: 2025252, name: "Ester Expósito", knownForDepartment: "Acting", profilePath: "/6wsOvUn9YewNZ3IEEBWfiDVTYOc.jpg", knownFor: []),
    Person(id: 1883366, name: "Yoo Ji-won", knownForDepartment: "Acting", profilePath: "/hpgMcqgkjadsmVpfIMQlXEBCnpL.jpg", knownFor: []),
    Person(id: 91606, name: "Tom Hiddleston", knownForDepartment: "Acting", profilePath: "/mclHxMm8aPlCPKptP67257F5GPo.jpg", knownFor: []),
    Person(id: 63436, name: "Jun Ji-hyun", knownForDepartment: "Acting", profilePath: "/qejOQBdIzN18e69yRcsiD0JQi4c.jpg", knownFor: []),
]

var tempDragDataActor: [DragItemData] = [
    DragItemData(itemType: .Actor, genreData: nil, personData: actorTemp[0]),
    DragItemData(itemType: .Actor, genreData: nil, personData: actorTemp[1]),
    DragItemData(itemType: .Actor, genreData: nil, personData: actorTemp[2]),
    DragItemData(itemType: .Actor, genreData: nil, personData: actorTemp[3]),
    DragItemData(itemType: .Actor, genreData: nil, personData: actorTemp[4]),
    DragItemData(itemType: .Actor, genreData: nil, personData: actorTemp[5]),
    DragItemData(itemType: .Actor, genreData: nil, personData: actorTemp[6]),
    DragItemData(itemType: .Actor, genreData: nil, personData: actorTemp[7]),
    DragItemData(itemType: .Actor, genreData: nil, personData: actorTemp[8]),
    DragItemData(itemType: .Actor, genreData: nil, personData: actorTemp[9]),
]

//----------------Director Data------------------------ Is There any way to get the director ?????

var DirectorTemp : [Person] = [
    Person(id: 1388848, name: "Jim Barr", knownForDepartment: "Art", profilePath: "/myLNBZXXESp1YzDkBoKQX8g4Yup.jpg", knownFor: []),
    Person(id: 32349, name: "Charles Wood", knownForDepartment: "Art", profilePath: "/lxhuwWMdbvuPzher5TSdGFsel1S.jpg", knownFor: []),
    Person(id: 1822520, name: "Michaela McAllister", knownForDepartment: "Art", profilePath: "/ys7TRFyl7RpBziYZ7JVadSfawWT.jpg", knownFor: []),
    Person(id: 1675387, name: "Adam Collins", knownForDepartment: "Art", profilePath: "/iuKuZT6xWpzdVhAouEZllgLEwgB.jpg", knownFor: []),
    Person(id: 1452349, name: "Carl Anthony Nespoli", knownForDepartment: "Art", profilePath: "/b0ZxuVSl46shI2YNq9SUyUm2wHH.jpg", knownFor: []),
    Person(id: 2178720, name: "Holly Dowell", knownForDepartment: "Art", profilePath: "/zwnrOAdqZOHvmcCSOTMJ3rifAjM.jpg", knownFor: []),
    Person(id: 1024823, name: "Brian A. Miller", knownForDepartment: "Directing", profilePath: "/8uc10NUQVOdFFgf4gymL3UeDhos.jpg", knownFor: []),
    Person(id: 17211, name: "Randall Emmett", knownForDepartment: "Production", profilePath: "/wlFuKcM85H1TeNjSshBSpjdsEVg.jpg", knownFor: []),
    Person(id: 930983, name: "David Barber", knownForDepartment: "Sound", profilePath: "/hlzzHtGS8RqZXAh0vSEZiPHLfgN.jpg", knownFor: []),
    Person(id: 929145, name: "Lorne Balfe", knownForDepartment: "Sound", profilePath: "/lHAhZC9RAUYtjhKDokKYyNNitLz.jpg", knownFor: []),
]

var tempDragDataDirector: [DragItemData] = [
    DragItemData(itemType: .Director, genreData: nil, personData: DirectorTemp[0]),
    DragItemData(itemType: .Director, genreData: nil, personData: DirectorTemp[1]),
    DragItemData(itemType: .Director, genreData: nil, personData: DirectorTemp[2]),
    DragItemData(itemType: .Director, genreData: nil, personData: DirectorTemp[3]),
    DragItemData(itemType: .Director, genreData: nil, personData: DirectorTemp[4]),
    DragItemData(itemType: .Director, genreData: nil, personData: DirectorTemp[5]),
    DragItemData(itemType: .Director, genreData: nil, personData: DirectorTemp[6]),
    DragItemData(itemType: .Director, genreData: nil, personData: DirectorTemp[7]),
    DragItemData(itemType: .Director, genreData: nil, personData: DirectorTemp[8]),
    DragItemData(itemType: .Director, genreData: nil, personData: DirectorTemp[9]),
]
//-----------------------------------------------------
enum CharacterRule : String{
    case Actor = "Actor"
    case Director = "Director"
    case Genre = "Genre"
}

//Total info for genre
struct GenreData {
    let id : Int
    let name : String
}

//GET GENRE HEERE : GET /discover/movie uisng with_genre_id:
struct DragGenreData {
    let info : GenreData
    let describeImg : String //using any image which movie can describe this Genre (URL)

    var posterImg: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\( describeImg)")!
    }
}

//Total info for Dragging data
struct DragItemData : Identifiable{
    
    let id : String = UUID().uuidString
    let itemType : CharacterRule //descrip what data in used
    let genreData : DragGenreData? //only for genre
    let personData : Person? //only for actor and director
}

//struct SearchModel : Codable,Identifiable{
//    var id : String = UUID().uuidString
//    let keyWord : String
//}

enum Tab : String {
    case Actor = "Actor"
    case Director = "Director"
    case Genre = "Genre"
}

class PreviewModle : ObservableObject {
    @Published var isShowPreview : Bool = false
    @Published var previewData : Movie? //get the movie
    @Published var previewDataList : [Movie]?
    
    @Published var fullMovieIds : [Int] = []
    @Published var Movies : [Movie] = []
    
    @Published var movie: Movie?
    @Published var error: NSError?
    @Published var fetechEndPoint : Error?
    
    private var movieIds : [Int] = [
        497698,
        80752,
        774021,
        611489,
        547565
    ]
    
    private let movieService: MovieService
    
    init(movieService: MovieService = MovieStore.shared) {
        self.movieService = movieService
        self.previewDataList = []
        
       loadListMovies(from: .nowPlaying)

    }
    
    func setUp(){
        loadMovie(id: movieIds.randomElement()!)
    }
    
    func loadMovie(id: Int){
        self.previewData = nil

        self.movieService.fetchMovie(id: id) {[weak self] (result) in
            guard let self = self else { return } //do it need here if it use weak self??

            switch result {
            case .success(let movie):
                self.previewData = movie
            case .failure(let error):
                self.error = error as NSError
            }
        }
    }
    
    func loadFullMovie(id: Int){
        self.previewData = nil

        self.movieService.fetchMovie(id: id) {[weak self] (result) in
            guard let self = self else { return } //do it need here if it use weak self??

            switch result {
            case .success(let movie):
                self.Movies.append(movie)
                
            case .failure(let error):
                self.error = error as NSError
            }
        }
    }
    
    func getFullMovie(){
        if self.previewDataList != nil{
            for data in self.previewDataList!{
                loadFullMovie(id: data.id)
            }
        }
    }
    
    func loadListMovies(from : MovieListEndpoint){
        self.movieService.fetchMovies(from: from) {[weak self] (result) in
            guard let self = self else { return } //do it need here if it use weak self??

            switch result {
            case .success(let movie):
                self.previewDataList?.append(contentsOf: movie.results)
            case .failure(let error):
                self.fetechEndPoint = error as NSError
            }
        }
    }
    
}

//class CardProvider : ObservableObject,DropDelegate {
//
//    @Published var selectedPreviewDatas : [DragItemData] = [] //here we are getting all the movies info that user is selected
//    @Published var dragActor : [DragItemData] = tempDragDataActor
//    @Published var dragDirector : [DragItemData] = tempDragDataDirector
//    @Published var dragGenre : [DragItemData] = tempDragDataGenre
//    @Published var selectedTab : Tab = .Actor
//
//    @Published var fetchingError : NSError?
//
//    @Published var previewMoviesList : [Movie]?
//    @Published var previewResult : Movie?
//
//    private let movieService: MovieService
//
//    init(movieService: MovieService = MovieStore.shared) {
//        self.movieService = movieService
//    }
//
//    func fetchData(type : CharacterRule) {
//
//        switch type {
//        case .Actor:
//            //update actor list
//
//            break
//        case .Director:
//            //update director list
//            break
//        case .Genre:
//            //update genre list
//            break
//        }
//    }
//
//    private var movieIds : [Int] = [
//        497698,
//        80752,
//        774021,
//        611489,
//        547565
//    ]
//
//    func getPreviewResult(movieID : Int){
//        movieService.fetchMovie(id: movieID){ [weak self] result in
//            guard let self = self else { return } //do it need here if it use weak self??
//
//            switch result{
//            case .success(let result):
//                // print(result)
//                self.previewResult = result
//            case .failure(let err):
//                self.fetchingError = err as NSError
//            }
//
//        }
//    }
//
//    func getAllPreviewResultList() -> NSError? {
//        return nil
//    }
//
//    func getPreview(){
//        let id = self.movieIds.randomElement()!
//        getPreviewResult(movieID: id)
//    }
//
//    func performDrop(info: DropInfo) -> Bool {
//        // just allow to drop at most 10 Card
//
//        for imgProvider in info.itemProviders(for: [String(kUTTypeURL)]){
//            if imgProvider.canLoadObject(ofClass: URL.self){
//                print("URL loaded")
//
//                //for each drop item if can load and it will provide a CardID
//                //And Seching from the list
//
//                let _ = imgProvider.loadObject(ofClass: URL.self){ (CardId,err) in
//
//                    print(CardId!)
//                    //check current selected list is exist or not
//                    let checkState = self.selectedPreviewDatas.contains{ (exist) -> Bool in
//                        return exist.id == "\(CardId!)"
//                    }
//
//                    //Get the item is exist in current list or not
//                    //If not exist append to current list
//                    if !checkState {
//                        //We need to find the current data in provider lsit first
//                        //and we can get is Actor? Director? Genre
//                        //But we don't know the card in which list
//                        // we need to figure our first
//                        let actor = self.dragActor.filter{(item) -> Bool in
//                            return item.id == "\(CardId!)"
//                        }
//
//                        let director = self.dragDirector.filter{(item) -> Bool in
//                            return item.id == "\(CardId!)"
//                        }
//
//                        let genre = self.dragGenre.filter{(item) -> Bool in
//                            return item.id == "\(CardId!)"
//                        }
//
//                        //Either one is not empty
//                        if !actor.isEmpty {
//                            //Because we are using Uquie ID ,won't have same id
//                            //There is one item only
//                            //Append to the list
//                            DispatchQueue.main.async {
//                                withAnimation(.default){
//                                    self.selectedPreviewDatas.insert(actor.first!, at: 0) //we have already check is not empty
//                                }
//
//                                //fecth the preview result
//                                //here just simulating
//                                self.getPreview()
//
//                            }
//                        }else if !director.isEmpty {
//                            //Because we are using Uquie ID ,won't have same id
//                            //There is one item only
//                            DispatchQueue.main.async {
//                                withAnimation(.default){
//                                    self.selectedPreviewDatas.insert(director.first!, at: 0) //we have already check is not empty
//                                }
//
//                                //fecth the preview result
//                                //here just simulating
//                                self.getPreview()
//                            }
//
//                        }
//                        else if !genre.isEmpty {
//                            DispatchQueue.main.async {
//                                withAnimation(.default){
//                                    self.selectedPreviewDatas.insert(genre.first!, at: 0) //we have already check is not empty
//                                }
//
//                                //fecth the preview result
//                                //here just simulating
//                                self.getPreview()
//                            }
//                        }
//                    }
//                }
//            }
//            else {
//                print("URL can't load")
//            }
//
//
//        }
//        return true
//    }
//
//    func dropUpdated(info: DropInfo) -> DropProposal? {
//        return DropProposal.init(operation: .move)
//    }
//
//}

class DragAndDropViewModel : ObservableObject,DropDelegate {
    
    //This Part is for dragAndDropCar
    @Published var selectedPreviewDatas : [DragItemData] = [] //here we are getting all the movies info that user is selected
    @Published var dragActor : [DragItemData] = tempDragDataActor
    @Published var dragDirector : [DragItemData] = tempDragDataDirector
    @Published var dragGenre : [DragItemData] = tempDragDataGenre
    @Published var selectedTab : Tab = .Actor
    
    //This part is for preview and networking
    @Published var isShowPreview : Bool = false
    @Published var previewData : Movie? //get the movie
    @Published var previewDataList : [Movie]?
    @Published var fetchingError : NSError?
    @Published var fetchPreLoading : Bool = false
    
    private let movieService: MovieService
    
    private var movieIds : [Int] = [
        497698,
        482373,
        774021,
        611489,
        547565,
        848278,
        597433,
        580489
    ]
    
    init(movieService: MovieService = MovieStore.shared) {
        self.movieService = movieService
    }
    
    func fetchData(type : CharacterRule) {
        
        switch type {
        case .Actor:
            //update actor list
            
            break
        case .Director:
            //update director list
            break
        case .Genre:
            //update genre list
            break
        }
    }

    func getPreviewResult(movieID : Int){
        movieService.fetchMovie(id: movieID){ [weak self] result in
            guard let self = self else { return } //do it need here if it use weak self??
            
            switch result{
            case .success(let result):
                // print(result)
                self.previewData = result
                self.fetchPreLoading = false
                print("data got!")
            case .failure(let err):
                self.fetchingError = err as NSError
            }
            
        }
    }
    
    func loadMovies(with endpoint: MovieListEndpoint) {

        self.movieService.fetchMovies(from: endpoint) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.previewDataList = response.results
                
            case .failure(let error):
                self.fetchingError = error as NSError
            }
        }
    }
    
    func getPreview(){
        let id = self.movieIds.randomElement()!
        print(id)
        getPreviewResult(movieID: id)
    }

    func performDrop(info: DropInfo) -> Bool {
        // just allow to drop at most 10 Card

        for imgProvider in info.itemProviders(for: [String(kUTTypeURL)]){
            if imgProvider.canLoadObject(ofClass: URL.self){
                print("URL loaded")

                //for each drop item if can load and it will provide a CardID
                //And Seching from the list

                let _ = imgProvider.loadObject(ofClass: URL.self){ (CardId,err) in

                    print(CardId!)
                    //check current selected list is exist or not
                    let checkState = self.selectedPreviewDatas.contains{ (exist) -> Bool in
                        return exist.id == "\(CardId!)"
                    }

                    //Get the item is exist in current list or not
                    //If not exist append to current list
                    if !checkState {
                        //We need to find the current data in provider lsit first
                        //and we can get is Actor? Director? Genre
                        //But we don't know the card in which list
                        // we need to figure our first
                        
                        if self.selectedPreviewDatas.count == 10{
                            print("max!")
                            return
                        }
                        
                        
                        let actor = self.dragActor.filter{(item) -> Bool in
                            return item.id == "\(CardId!)"
                        }

                        let director = self.dragDirector.filter{(item) -> Bool in
                            return item.id == "\(CardId!)"
                        }

                        let genre = self.dragGenre.filter{(item) -> Bool in
                            return item.id == "\(CardId!)"
                        }

                        //Either one is not empty
                        if !actor.isEmpty {
                            //Because we are using Uquie ID ,won't have same id
                            //There is one item only
                            //Append to the list
                            DispatchQueue.main.async {
                                withAnimation(.default){
                                    self.selectedPreviewDatas.insert(actor.first!, at: 0) //we have already check is not empty
                                }
                                
                                //fecth the preview result
                                //here just simulating
                                self.fetchPreLoading = true
                                
                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0){
                                self.getPreview()
                                print("data fetching")
                                
                            }
                        }else if !director.isEmpty {
                            //Because we are using Uquie ID ,won't have same id
                            //There is one item only
                            DispatchQueue.main.async {
                                withAnimation(.default){
                                    self.selectedPreviewDatas.insert(director.first!, at: 0) //we have already check is not empty
                                }
                                
                                //fecth the preview result
                                //here just simulating
                                self.fetchPreLoading = true
                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0){
                                self.getPreview()
                                print("data fetching")
                                
                            }

                        }
                        else if !genre.isEmpty {
                            DispatchQueue.main.async {
                                withAnimation(.default){
                                    self.selectedPreviewDatas.insert(genre.first!, at: 0) //we have already check is not empty
                                }
                                
                                //fecth the preview result
                                //here just simulating
                                self.fetchPreLoading = true
                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0){
                                self.getPreview()
                                print("data fetching")
                               
                            }
                        }
                        let array  = [1,2,3,4]
                        let type = array.randomElement()!
                        switch type {
                        case 1:
                            self.loadMovies(with: .nowPlaying)
                        case 2:
                            self.loadMovies(with: .popular)
                        case 3:
                            self.loadMovies(with: .topRated)
                        case 4:
                            self.loadMovies(with: .upcoming)
                        default:
                            print("something wrong")
                        }

                    }
                }
            }
            else {
                print("URL can't load")
            }


        }
        return true
    }

    func dropUpdated(info: DropInfo) -> DropProposal? {
        return DropProposal.init(operation: .move)
    }

}

class SearchBarViewModel : ObservableObject{
    @Published var searchingText : String = ""
    @Published var searchResult : [Movie] = []
    @Published var isLoading : Bool = false
    @Published var fetchingError : NSError?
    
    private let movieService: MovieService
    
    init(movieService: MovieService = MovieStore.shared) {
        self.movieService = movieService
    }
    
    //fake ,just for testing
    //when searchingText is change chall it
    func getRecommandationList(){
        //when the return button is press
        movieService.searchMovie(query: searchingText){ [weak self] result in
            guard let self = self else { return }
            withAnimation(){
                self.isLoading = true
            }
            switch result{
            case.success(let response):
               
                self.searchResult = response.results
                print(self.searchResult.count)
                withAnimation(){
                    self.isLoading = false
                }
            case .failure(let error):

                self.fetchingError = error as NSError
            }
        }
        
    }
}

class SeachingViewStateManager : ObservableObject{
    //For all state in searching view
    @Published var isSeaching : Bool = false // this for opening the searhing model,for main searching page only
    @Published var isRemove : Bool = false
    @Published var isFocuse : [Bool] = [false,true] //we are only using [1] true mean open the keybody
    @Published var isEditing : Bool = false
    
    //going to share the searching text between the view
//    @Published var searchingText : String = ""
    @Published var getResult : Bool  = false
    
    @Published var previewResult : Bool = false
    @Published var previewMoreResult : Bool = false
    
    //just for try!
    @Published var searchingLoading : Bool = true
}


struct AutoScroll_V: View {
    @AppStorage("seachHistory") var history : [String] =  []
    @EnvironmentObject  var StateManager : SeachingViewStateManager
    @StateObject private var searchMV = SearchBarViewModel()
    //    @StateObject var StateManager  = SeachingViewStateManager()
    //current view state
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var selectedPhoto:UIImage? // it may remove and instead with custom view
    @State private var isCameraDisplay : Bool = false
    @State private var isShowActionSheet :Bool = false
    @EnvironmentObject var previewModel : PreviewModle
    @EnvironmentObject var DragAndDropPreview : DragAndDropViewModel
    
    //it might need to change in only this view
    init(){
        UIScrollView.appearance().keyboardDismissMode = .onDrag
    }
    
    var body: some View {
        return
            ZStack(alignment:.bottom){
                NavigationView{
                    VStack(spacing:0){
                        if self.StateManager.previewResult{
                            NavigationLink(destination:  MovieDetailView(movieId:self.DragAndDropPreview.previewData!.id, navBarHidden: .constant(true), isAction: .constant(false), isLoading: .constant(true)), isActive: self.$StateManager.previewResult){
                                EmptyView()
                                
                            }
                        }
                        //this view , is simulating the naviagation link
                        if self.StateManager.previewMoreResult && self.DragAndDropPreview.previewDataList != nil{
                            
                            NavigationLink(destination: MorePreviewResultView(isNavLink: true, backPageName: "Search", isActive: self.$StateManager.previewMoreResult,movieList: self.DragAndDropPreview.previewDataList!), isActive: self.$StateManager.previewMoreResult){EmptyView()}
                            
                        }
                        if self.StateManager.getResult{
                            NavigationLink(destination: SearchResultView(movie: self.searchMV.searchResult), isActive: self.$StateManager.getResult){EmptyView()}
       
                        }

                        SearchingBar(isCameraDisplay: self.$isCameraDisplay)
                           
                        
                        if self.StateManager.isSeaching && !self.StateManager.isEditing{
                            searchingField(history: self.history)
                                .padding(.top,5)
                                
                            
                        }else if(self.StateManager.isEditing){
                            searchingResultList()
                                .ignoresSafeArea()
                        }else{
                            SeachDragingView()
                                .padding(.top,5)
                        }
                        
                        
                    }
                    //                    .zIndex(0)
                    .edgesIgnoringSafeArea(.all)
                    .fullScreenCover(isPresented: self.$isCameraDisplay){
                        //show the phone or phone lib as sheet
                        CameraView(closeCamera : self.$isCameraDisplay)
                    }
                    .alert(isPresented: self.$StateManager.isRemove){
                        withAnimation(){
                            Alert(title: Text("Delete All Searching History"), message: Text("Are you sure?"),
                                  primaryButton: .default(Text("Cancel")){
                                    self.StateManager.isFocuse = [false,true]
                                  },
                                  secondaryButton: .default(Text("Delete")){
                                    withAnimation{
                                        UserDefaults.standard.set([],forKey: "seachHistory")
                                        self.StateManager.isFocuse = [false,true]
                                    }
                                  })
                        }
                        
                    }
                    .navigationViewStyle(DoubleColumnNavigationViewStyle())
                    .navigationTitle(self.StateManager.previewResult ? "Search" : "")
                    .navigationBarTitle(self.StateManager.previewResult ? "Search" : "")
                    .navigationBarHidden(true)
                }
            }
            .environmentObject(searchMV)
    }
    
}

struct searchingResultList :View{
    @EnvironmentObject var StateManager : SeachingViewStateManager
    @EnvironmentObject var test : PreviewModle
    @EnvironmentObject var searchMV : SearchBarViewModel
    var body: some View{
        List(){
            Button(action: {
                self.StateManager.isSeaching.toggle()
                self.StateManager.isFocuse = [false,false]
                self.StateManager.isEditing.toggle()
                withAnimation(.easeInOut(duration: 0.3)){
                    self.StateManager.getResult = true
                }
            }){
                HStack(spacing:2){
                    Text("Search:")
                        .foregroundColor(.blue)
                    Text(searchMV.searchingText)
                        .foregroundColor(.white)
                        .padding(.horizontal,5)
                    Spacer()
                }
            }
            if self.searchMV.searchResult.count > 0{
                ForEach(self.searchMV.searchResult,id:\.id){ searchData in
                    Button(action: {
                        self.searchMV.searchingText = searchData.title
                        self.StateManager.isSeaching.toggle()
                        self.StateManager.isFocuse = [false,false]
                        self.StateManager.isEditing.toggle()
                        withAnimation(.easeInOut(duration: 0.3)){
                            self.StateManager.getResult = true
                        }
                    }){
                        HStack{
                            Image(systemName: "film")
                                .font(.body)
                                .foregroundColor(.gray)
                            Text(searchData.title)
                                .bold()
                            
                            Spacer()
                            
                            Image(systemName: "arrowshape.turn.up.forward")
                        }
                    }
                }
            }
        }
        .listStyle(PlainListStyle())
    }
}

struct searchingField : View{
    @EnvironmentObject var StateManager : SeachingViewStateManager
    @EnvironmentObject var searchMV : SearchBarViewModel
    var history : [String]

    var body :some View{
        return ScrollView(.vertical, showsIndicators: false){
            //before user typing seaching thing
            //show user seaching history and recommand keyword
            HStack{
                Text("Recent:")
                    .fontWeight(.bold)
                    .font(.body)
                Spacer()

                Button(action:{
                    //to remove all
//                    UserDefaults.standard.set([],forKey: "seachHistory")
                    withAnimation(.easeInOut(duration: 0.3)){
                        self.StateManager.isRemove.toggle()
                        self.StateManager.isFocuse = [false,false]
                    }
                }){
                    Image(systemName: "trash")
                        .foregroundColor(.white)
                }

            }

            if !history.isEmpty{
                HStackLayout(list: self.history)
            }

            Spacer()
        }
        .padding(.horizontal)
        .frame(width:UIScreen.main.bounds.width)
    }
}

struct HStackLayout: View {
    @EnvironmentObject var StateManager : SeachingViewStateManager
    @EnvironmentObject var searchMV : SearchBarViewModel
    var list : [String]
    var body: some View {
        VStack{
            GeometryReader { geometry in
                self.generateContent(in: geometry)
            }
        }
    }

    private func generateContent(in g: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero

        return ZStack(alignment: .topLeading) {
            ForEach(self.list, id: \.self) { item in
                searchFieldButton(searchingText: item){
                    self.StateManager.isSeaching.toggle()
                    self.searchMV.searchingText = item
                    self.StateManager.isEditing = false
                    withAnimation(.easeOut(duration:0.7)){
                        self.StateManager.isFocuse = [false,false]
                        self.StateManager.getResult = true
                    }
                }
                .padding([.horizontal, .vertical], 4)
                .alignmentGuide(.leading, computeValue: { d in
                    if (abs(width - d.width) > g.size.width)
                    {
                        width = 0
                        height -= d.height
                    }
                    let result = width
                    if item == self.list.last! {
                        width = 0 //last item
                    } else {
                        width -= d.width
                    }
                    return result
                })
                .alignmentGuide(.top, computeValue: {d in
                    let result = height
                    if item == self.list.last! {
                        height = 0 // last item
                    }
                    return result
                })
            }
        }
    }

}

struct searchFieldButton : View {
    var searchingText:String
    var action : ()->()
    var body: some View{
        return VStack{
            Button(action:action){
                Text(searchingText)
                    .font(.system(size: 15))
                    .foregroundColor(Color.black)
            }
            .frame(width:getStrWidth(searchingText),height:30)
            .padding(.horizontal,5)
            .background(Color.white)
            .cornerRadius(8)
            .shadow(color: Color.black.opacity(0.45), radius: 10, x: 0, y: 0)
        }
    }

    func getStrWidth(_ str:String)->CGFloat{
        //get current string size
        return str.widthOfStr(Font: .systemFont(ofSize: 15,weight: .bold))
    }
}

struct SearchingMode: View {
    @EnvironmentObject var StateManager : SeachingViewStateManager
    @EnvironmentObject var searchMV : SearchBarViewModel
    
    @State private var isDelete:Bool = false
    var placeholder : String = "Movie Name,Actor..."
    var body: some View {
            HStack{
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.white)
                    .padding(.horizontal,8)
                
                UITextFieldView(keybooardType: .default, returnKeytype: .search, tag: 1, placeholder:placeholder)
                    .frame(height:22)
                    .onChange(of: self.searchMV.searchingText, perform: { value in
                        if self.StateManager.isSeaching {
                            self.StateManager.isEditing = value == "" ? false : true
                        }
                    })
                
                if self.StateManager.isEditing {
                    Button(action:{
                        withAnimation{
                            self.searchMV.searchingText = ""
                        }
                    }){
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                    }
                    .transition(.move(edge: .trailing))
                }
            }
            .padding(self.StateManager.isSeaching ? 2 : 0)
    }
}

struct SeachingButton: View {
    @EnvironmentObject var StateManager : SeachingViewStateManager
    @Binding var isCameraDisplay : Bool
    var body: some View {
        HStack(spacing:0){
            Button(action:{
                //TO EXPAND THE SEACHING BAR
                self.StateManager.isSeaching.toggle()
                self.StateManager.isFocuse = [false,true]
            }){
                Image(systemName: "magnifyingglass")
                    .padding(10)
                    .foregroundColor(.black)
            }
            .background(Color.white.clipShape(CustomeConer(coners: [.topLeft,.bottomLeft])))

            Button(action:{
                withAnimation{
                    //just toggle the camera viesw
                    self.isCameraDisplay.toggle()
                }
            }){
                Image(systemName: "camera")
                    .padding(10)
                    .foregroundColor(.white)
            }
            .background(Color("DropBoxColor").clipShape(CustomeConer(coners: [.topRight,.bottomRight])))
        }
    }
}

struct SearchingBar: View {
    @EnvironmentObject var StateManager : SeachingViewStateManager
    @EnvironmentObject var searchMV : SearchBarViewModel
    
    @Binding var isCameraDisplay :Bool
    var body: some View {
        HStack(spacing:0){
            if !self.StateManager.isSeaching {
                Text("Seach Playground")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.white)

                Spacer()
            }

            HStack{
                if self.StateManager.isSeaching {
                    HStack{
                        Button(action: {
                            self.StateManager.isSeaching.toggle()
                            withAnimation(.easeInOut){
                                self.searchMV.searchingText = "" //for currrent view only
                                
                                self.StateManager.isEditing = false
                                self.StateManager.isFocuse = [false,false]
                            }
                            
                        }) {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.white)
                        }
                        .padding(.trailing, 2)
                        .transition(.move(edge: .trailing))
                        .animation(.default)
                        
                        SearchingMode()
                    }

                }
                else {
                    SeachingButton(isCameraDisplay: self.$isCameraDisplay)
                }
            }
            .padding(self.StateManager.isSeaching ? 2 : 0)
//            .cornerRadius(25)
        }
//        .padding(.top, 50 )
        .padding(.horizontal)
        .padding(.bottom,5)
        .padding(.top,UIApplication.shared.windows.first?.safeAreaInsets.top)
        .background(Color("DarkMode2"))
    }
}

struct SeachItem : Identifiable,Hashable{
    let id :String = UUID().uuidString
    let itemName : String
}



let testList  : [MovieRule] = [
    MovieRule(name: "Action", rule: .Genre, postURL: "https://www.themoviedb.org/t/p/original/ppiL13JJx2LkyoNb8JM0h7nxYmk.jpg"),
    MovieRule(name: "Adventure", rule: .Genre, postURL: "https://www.themoviedb.org/t/p/original/9dKCd55IuTT5QRs989m9Qlb7d2B.jpg"),
    MovieRule(name: "Comedy", rule: .Genre, postURL: "https://www.themoviedb.org/t/p/original/cycDz68DtTjJrDJ1fV8EBq2Xdpb.jpg"),
    MovieRule(name: "Crime", rule: .Genre, postURL: "https://www.themoviedb.org/t/p/original/ky8Fua6PD7FyyOA7JACh3GDETli.jpg"),
    MovieRule(name: "Fantasy", rule: .Genre, postURL: "https://www.themoviedb.org/t/p/original/dkokENeY5Ka30BFgWAqk14mbnGs.jpg"),
    MovieRule(name: "Horror", rule: .Genre, postURL: "https://www.themoviedb.org/t/p/original/bShgiEQoPnWdw4LBrYT5u18JF34.jpg"),
    MovieRule(name: "Science Fiction", rule: .Genre, postURL: "https://www.themoviedb.org/t/p/original/78wC6ZWhTlqaCNL0rS7jl7dAV85.jpg"),
    MovieRule(name: "Comedy", rule: .Genre, postURL: "https://www.themoviedb.org/t/p/original/cycDz68DtTjJrDJ1fV8EBq2Xdpb.jpg"),
    MovieRule(name: "Crime", rule: .Genre, postURL: "https://www.themoviedb.org/t/p/original/ky8Fua6PD7FyyOA7JACh3GDETli.jpg"),
    MovieRule(name: "Fantasy", rule: .Genre, postURL: "https://www.themoviedb.org/t/p/original/dkokENeY5Ka30BFgWAqk14mbnGs.jpg"),
    MovieRule(name: "Horror", rule: .Genre, postURL: "https://www.themoviedb.org/t/p/original/bShgiEQoPnWdw4LBrYT5u18JF34.jpg"),
    MovieRule(name: "Science Fiction", rule: .Genre, postURL: "https://www.themoviedb.org/t/p/original/78wC6ZWhTlqaCNL0rS7jl7dAV85.jpg"),
    MovieRule(name: "Comedy", rule: .Genre, postURL: "https://www.themoviedb.org/t/p/original/cycDz68DtTjJrDJ1fV8EBq2Xdpb.jpg"),
    MovieRule(name: "Crime", rule: .Genre, postURL: "https://www.themoviedb.org/t/p/original/ky8Fua6PD7FyyOA7JACh3GDETli.jpg"),
    MovieRule(name: "Fantasy", rule: .Genre, postURL: "https://www.themoviedb.org/t/p/original/dkokENeY5Ka30BFgWAqk14mbnGs.jpg"),
    MovieRule(name: "Horror", rule: .Genre, postURL: "https://www.themoviedb.org/t/p/original/bShgiEQoPnWdw4LBrYT5u18JF34.jpg"),
    MovieRule(name: "Science Fiction", rule: .Genre, postURL: "https://www.themoviedb.org/t/p/original/78wC6ZWhTlqaCNL0rS7jl7dAV85.jpg"),
    MovieRule(name: "Comedy", rule: .Genre, postURL: "https://www.themoviedb.org/t/p/original/cycDz68DtTjJrDJ1fV8EBq2Xdpb.jpg"),
    MovieRule(name: "Crime", rule: .Genre, postURL: "https://www.themoviedb.org/t/p/original/ky8Fua6PD7FyyOA7JACh3GDETli.jpg"),
    MovieRule(name: "Fantasy", rule: .Genre, postURL: "https://www.themoviedb.org/t/p/original/dkokENeY5Ka30BFgWAqk14mbnGs.jpg"),
    MovieRule(name: "Horror", rule: .Genre, postURL: "https://www.themoviedb.org/t/p/original/bShgiEQoPnWdw4LBrYT5u18JF34.jpg"),
    MovieRule(name: "Science Fiction", rule: .Genre, postURL: "https://www.themoviedb.org/t/p/original/78wC6ZWhTlqaCNL0rS7jl7dAV85.jpg"),
    MovieRule(name: "Comedy", rule: .Genre, postURL: "https://www.themoviedb.org/t/p/original/cycDz68DtTjJrDJ1fV8EBq2Xdpb.jpg"),
    MovieRule(name: "Crime", rule: .Genre, postURL: "https://www.themoviedb.org/t/p/original/ky8Fua6PD7FyyOA7JACh3GDETli.jpg"),
    MovieRule(name: "Fantasy", rule: .Genre, postURL: "https://www.themoviedb.org/t/p/original/dkokENeY5Ka30BFgWAqk14mbnGs.jpg"),
    MovieRule(name: "Horror", rule: .Genre, postURL: "https://www.themoviedb.org/t/p/original/bShgiEQoPnWdw4LBrYT5u18JF34.jpg"),
    MovieRule(name: "Science Fiction", rule: .Genre, postURL: "https://www.themoviedb.org/t/p/original/78wC6ZWhTlqaCNL0rS7jl7dAV85.jpg")
]

//struct AutoScroll_V_Previews: PreviewProvider
//{
//    static var previews: some View{
//       Text("a")
//            .preferredColorScheme(.dark)
////        }
//
//    }
//}



struct ResultList : View{
    var result : [Movie]
    @Binding var isShowDetail : Bool
    @Binding var selectedID : Int?
    var body: some View{
        HStack{
            ForEach(self.result){ item in
                ResultCardView(isShowDetail: self.$isShowDetail, selectedID: self.$selectedID, movie: item)
            }
        }
    }
}

struct SearchResultView: View {
    @AppStorage("seachHistory") var history : [String] =  []
    
    @EnvironmentObject var StateManager : SeachingViewStateManager
    @EnvironmentObject var searchMV : SearchBarViewModel

    @State private var page = 1
    @State private var showAsList : Bool = false

    @State private var isShowDetail : Bool = false
    @State private var selectedID : Int?
    var movie : [Movie]
    var body: some View {
        ZStack{
            VStack(spacing:0){
                HStack{
                        Button(action: {
                            withAnimation(){
                                if !self.StateManager.isSeaching {
                                    self.StateManager.getResult = false
                                    self.searchMV.searchingText = ""
                                }
                                
                                if !self.StateManager.isEditing{
                                    self.StateManager.getResult = false
                                }
                            }
                            self.StateManager.isSeaching = false
                            self.StateManager.isEditing = false
                            
                        }) {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.white)
                        }
                        .padding(.trailing, 2)
                        
                        if !self.StateManager.isSeaching {
                            HStack{
                                HStack{
                                    Text(self.searchMV.searchingText)
                                        .foregroundColor(.white)
                                        .padding(.leading,5)
                                        .lineLimit(1)
                                    Spacer()
                                }
                                .frame(maxWidth:.infinity)
                                .background(Color.black.opacity(0.05))
                                .onTapGesture {
                                    self.StateManager.isSeaching = true
                                    self.StateManager.isFocuse = [false,true]
                                    self.StateManager.isEditing = true
                                }
                                Spacer()
                                Button(action:{
                                    withAnimation(){
                                        //Clean the text and turn on the search mode
                                        //now is nothing to do
                                        withAnimation(){
                                            self.StateManager.isSeaching = true
                                            self.searchMV.searchingText = ""
                                            self.StateManager.isFocuse = [false,true]
                                        }
                                    }
                                }){
                                    Image(systemName: "xmark")
                                        .foregroundColor(.white)
                                        .padding(.horizontal,3)
                                }
                                //A toggle button to toggle show tag a list or a silder
                                Button(action:{
                                    withAnimation(){
                                        self.showAsList.toggle()
                                    }
                                }){
                                    Image(systemName: "list.and.film")
                                        .foregroundColor(.white)
                                        .padding(.horizontal,3)
                                }
                            }
                            .transition(.identity)
                            .padding(.vertical,5)
                        }else{
                            SearchingMode(placeholder:"Recommand to you....Iron man!")
                                .padding(.vertical,5)
                        }
                        
                    
                }
                .padding(.horizontal,8)
                .padding(.vertical,5)
                .background(Color("DarkMode2").edgesIgnoringSafeArea(.all))

                Divider()
                
                if self.StateManager.isSeaching && !self.StateManager.isEditing{
                    //show history view
                    searchingField(history: self.history)
                        .padding(.top,5)
                    //                            .transition(.identity)
                    
                }else if(self.StateManager.isEditing){
                    //show seaching recommandation view
                    searchingResultList()
                    
                }else if !self.showAsList{
                    if self.StateManager.searchingLoading{
                        VStack{
                            Spacer()
                            HStack{
                                ActivityIndicatorView()
                                Text("Loading...")
                                    .bold()
                                    .font(.caption)
                            }
                            Spacer()
                        }
                        .onAppear{
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
                                withAnimation(){
                                    self.StateManager.searchingLoading = false
                                }
                            }
                        }
                        
                    }else{
                        MovieSeachResultView(isShowDetail: self.$isShowDetail, selectedID: self.$selectedID, movie: movie)
                            .onDisappear{
                                if !isShowDetail{
                                    self.StateManager.searchingLoading = true
                                }
                            }
                    }
                    
                }else{
                    MovieResultList(movies: movie, isShowDetail: self.$isShowDetail, selectedID: self.$selectedID)
                        .transition(AnyTransition.asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .leading)))
                }
                
                
                
            }
            .navigationTitle(self.isShowDetail ? "Search" : "")
            .navigationBarTitle(self.isShowDetail ? "Search" : "")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            
            if self.selectedID != nil{
                NavigationLink(destination:  MovieDetailView(movieId:self.selectedID!, navBarHidden: .constant(true), isAction: .constant(false), isLoading: .constant(true)) , isActive: self.$isShowDetail){
                    EmptyView()

                }
            }
            
        }
        
    }
}

struct MovieResultList : View {
    let movies :[Movie]
    @Binding var isShowDetail : Bool
    @Binding var selectedID : Int?
    var body: some View{
        List{
            ForEach(movies,id:\.self){ movie in
                Button(action:{
                    withAnimation(){
                        self.selectedID = movie.id
                        self.isShowDetail.toggle()
                    }
                }){
                    MovieResultListCell(movie: movie)
                }
            }
            
        }
        .listStyle(PlainListStyle())
    }
}

struct MovieResultListCell : View {
    let movie : Movie
    var body: some View{
        HStack(alignment:.top){
            WebImage(url: movie.posterURL)
                .resizable()
                .placeholder{
                    Text(movie.title)
                }
                .indicator(.activity) // Activity Indicator
                .transition(.fade(duration: 0.5)) // Fade Transition with duration
                .aspectRatio(contentMode: .fill)
                .frame(width:UIScreen.main.bounds.width / 3.5)
                .clipped()
                .shadow(color: Color.black.opacity(0.5), radius: 10, x: 6, y: 6)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.red, lineWidth: 1)
                )
                .cornerRadius(10)
            
            
            
            VStack(alignment:.leading,spacing:10){
                Text(movie.title)
                    .bold()
                    .font(.headline)
                    .lineLimit(1)
                
                Text("Language: \(movie.originalLanguage)")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                    .lineLimit(1)
                
                //Genre
                HStack(spacing:0){
                    Text("Genre: ")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                    
                    if self.movie.genres != nil{
                        HStack(spacing:0){
                            ForEach(0..<(movie.genres!.count >= 2 ? 2 : movie.genres!.count)){ i in
                                
                                Text(movie.genres![i].name)
                                    .font(.system(size: 14))
                                    .foregroundColor(.gray)
                                
                                if i != (movie.genres!.count >= 2 ? 1 : movie.genres!.count - 1){
                                    Text(",")
                                        .font(.system(size: 14))
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                        .lineLimit(1)
                    }else{
                        Text("n/a")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                    }
                }
                
                //actor
                HStack(spacing:0){
                    //at most show 2 genre!
                    Text("Actor: ")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)

                    if self.movie.cast != nil{
                        HStack(spacing:0){
                            ForEach(0..<(self.movie.cast!.count >= 2 ? 2 :  self.movie.cast!.count) ){ i in

                                Text(self.movie.cast![i].name)
                                    .font(.system(size: 14))
                                    .foregroundColor(.gray)

                                if i != (movie.cast!.count >= 2 ? 1 : self.movie.cast!.count - 1){
                                    Text(",")
                                        .font(.system(size: 14))
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                        .lineLimit(1)
                    }else{
                        Text("n/a")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                    }

                }
//
                Text("Release: \(movie.releaseDate ?? "Coming soon...")")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                    .lineLimit(1)
                Text("Time: \(movie.durationText)")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                    .lineLimit(1)
            }
            .padding(.top,5)
            
            Spacer()
        }

    }
}

struct MovieSeachResultView : View{
    @State private var page = 0
    
    @Binding var isShowDetail : Bool
    @Binding var selectedID : Int?
    var movie : [Movie]
    var body : some View{
        return
            ZStack{
                TabView(selection:$page){
                    ForEach(movie.indices,id:\.self){ i in
                        GeometryReader{proxy in
                            WebImage(url:  movie[i].posterURL)
                                .resizable()
                                .aspectRatio(contentMode:.fill)
                                .frame(width:proxy.size.width,height:proxy.size.height)
                                .cornerRadius(1)
                        }
                        .offset(y:-100)
                    }

                }
                .edgesIgnoringSafeArea(.top)
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .animation(.easeInOut)
                .overlay(
                    LinearGradient(gradient: Gradient(colors: [
                        Color.clear,
                        Color.black.opacity(0.2),
                        Color.black.opacity(0.4),
                        Color.black,
                        Color.black,
                        Color.black,

                    ]), startPoint: .top, endPoint: .bottom)
                )
                
                GeometryReader{proxy in
                    UIHScrollList(width: proxy.frame(in: .global).width, hegiht: proxy.frame(in: .global).height, cardsCount: movie.count, page: self.$page){
                        ResultList(result: movie, isShowDetail: self.$isShowDetail, selectedID: self.$selectedID)
                    }
                }

            }
    }
}

struct ResultCardView: View{
    @Binding var isShowDetail : Bool
    @Binding var selectedID : Int?
    let movie : Movie
    var body : some View{
        VStack{
            VStack(spacing:10){
                Text(movie.title)
                    .bold()
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding(.vertical,3)
                    .padding(.top,5)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                
                
                //max 3 only
                if movie.genres != nil{
                    HStack(alignment:.center){
                        
                        ForEach(0..<(movie.genres!.count > 3 ? 3 : movie.genres!.count)){i in
                            Text(movie.genres![i].name)
                                .bold()
                                .font(.subheadline)
                                .foregroundColor(.gray)
                                .padding(.horizontal,3)
                            if i != (self.movie.genres!.count > 3 ? 2 : movie.genres!.count - 1){
                                Circle()
                                    .frame(width: 5, height: 5, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    .foregroundColor(.red)
                            }
                            
                        }
                    }
                    .padding(.bottom)
                }else{
                    HStack(alignment:.center){
                        Text("Genre:N/A")
                            .bold()
                            .font(.caption)
                            .foregroundColor(.gray)
                            .padding(.horizontal,3)
                    }
                    .padding(.bottom)
                    
                }
            
                
                WebImage(url: movie.posterURL)
                    .resizable()
                    .placeholder{
                        Text(movie.title)
                    }
                    .indicator(.activity) // Activity Indicator
                    .transition(.fade(duration: 0.5)) // Fade Transition with duration
                    .aspectRatio(contentMode: .fit)
                    .frame(width:UIScreen.main.bounds.width / 1.65)
                    .clipped()
                    .cornerRadius(15)
                    .shadow(color: Color.black.opacity(0.5), radius: 10, x: 6, y: 6)
                    .padding(.bottom)
                    
                
                
                HStack(alignment:.center){
                    VStack(alignment:.leading,spacing:3){
                        Text("RELEASE")
                        Text(movie.releaseDate ?? "Comming soon...")
                            .font(.system(size: 13))
                            .foregroundColor(.white)
                        
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing, spacing: 3){
                        Text("PLAY TIME")
                        Text(movie.durationText)
                            .font(.system(size: 13))
                            .foregroundColor(.white)
                    }
                    
                }
                .foregroundColor(.gray)
                .font(.caption)
                .padding(.horizontal,30)
                
                VStack{
                    
                    HStack(){
                        
                        SmallRectButton(title: "Like", icon: "heart", textColor: .white){
                            
                        }
                        
                        Spacer()
                        
                        SmallRectButton(title: "Detail", icon: "ellipsis.circle",buttonColor: Color("BluttonBulue2")){
                            withAnimation(){
                                self.isShowDetail.toggle()
                                self.selectedID = movie.id
                            }
                        }
                       
                    }
                    .padding(.horizontal,20)
                }

                
            }
            .padding(.vertical,15)
            .background(BlurView().cornerRadius(20))
            .padding()
            
        }
        .padding(.horizontal,10)
        .padding(.leading,5)
    }
}

struct SeachDragingView : View{

    @State private var offset : CGFloat = 0.0
    @EnvironmentObject var DragAndDropPreview : DragAndDropViewModel //Using previeModle
    var body : some View{
        return
            VStack(spacing:0){
                Group{
                    Text(DragAndDropPreview.selectedTab.rawValue)
                        .bold()
                        .font(.subheadline)
                        .padding(.vertical,3)
                    CustomePicker(selectedTabs: $DragAndDropPreview.selectedTab)
                }

                Divider()
                switch(DragAndDropPreview.selectedTab){
                case .Genre:
                    ScrollableCardGrid(list: self.$DragAndDropPreview.dragGenre,beAbleToUpdate: false)
                    
                case .Actor:
                    ScrollableCardGrid(list: self.$DragAndDropPreview.dragActor)
                    
                case .Director:
                    ScrollableCardGrid(list: self.$DragAndDropPreview.dragDirector)
                }
                Divider()
                Spacer()

                //Drop area
                //Make a drop area as a box for dropping any cardItem user is wanted
                VStack(alignment:.trailing){
                    if !DragAndDropPreview.selectedPreviewDatas.isEmpty{
                        HStack{
                            Button(action:{
                                withAnimation(){
                                    self.DragAndDropPreview.selectedPreviewDatas.removeAll()
                                }
                            }){
                                HStack{
                                    Text("Trash All")
                                        .foregroundColor(.red)
                                        .font(.body)

                                    Image(systemName: "trash.circle")
                                        .foregroundColor(.white)
                                }
                            }

                            Spacer()
                            
                            if DragAndDropPreview.selectedPreviewDatas.count == 10{
                                Text("FULLED!")
                                    .bold()
                                    .font(.caption)
                                
                                Spacer()
                            }
                            Button(action:{
                                withAnimation(){
                                    self.DragAndDropPreview.isShowPreview.toggle() //using envronment object
                                }
                            }){
                                HStack{
                                    Image(systemName: "arrow.up.circle")
                                        .foregroundColor(.white)

                                    Text("Preview")
                                }
                            }
                        }
                        .padding(.horizontal)

                    }

                    ZStack{
                        //If not card is dropped
                        if DragAndDropPreview.selectedPreviewDatas.isEmpty{
                            Text("Drop image here")
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                                .transition(.identity)
                        }

                        ScrollView(.horizontal, showsIndicators: false){
                            HStack{
                                ForEach(DragAndDropPreview.selectedPreviewDatas,id:\.id){card in
//                                    ZStack(alignment: .topTrailing){
                                    VStack(spacing:3){
                                        if card.itemType == CharacterRule.Genre{
                                            WebImage(url: card.genreData!.posterImg)
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width:60,height:85)
                                                .cornerRadius(10)
                                                .clipped()
                                                .onTapGesture(count: 2){
                                                    withAnimation(.default){
                                                        self.DragAndDropPreview.selectedPreviewDatas.removeAll{ (checking) in
                                                            return checking.id == card.id
                                                        }}
                                                }
                                                .padding(.top,3)

                                            Text(card.genreData!.info.name)
                                                .font(.caption)
                                                .frame(width:55,height:13)
                                                .lineLimit(1)
                                        }else{
                                            WebImage(url: card.personData!.ProfileImageURL)
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width:60,height:85)
                                                .cornerRadius(10)
                                                .clipped()
                                                .onTapGesture(count: 2){
                                                    withAnimation(.default){
                                                        self.DragAndDropPreview.selectedPreviewDatas.removeAll{ (checking) in
                                                            return checking.id == card.id
                                                        }}
                                                }
                                                .padding(.top,3)

                                            Text(card.personData!.name)
                                                .font(.caption)
                                                .frame(width:55,height:13)
                                                .lineLimit(1)
                                        }

                                    }

                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    .frame(height: self.DragAndDropPreview.selectedPreviewDatas.isEmpty ? 50 : 100)
                    .padding(.bottom,10)
                    .padding(.top,10)
                    .background(self.DragAndDropPreview.selectedPreviewDatas.isEmpty ? Color("OrangeColor") : Color("DropBoxColor"))
                    .cornerRadius(20
                    )
                    .edgesIgnoringSafeArea(.all)
                    .shadow(color: Color.black.opacity(0.5), radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: 1.0, y: 1.0 )
                    .padding(.horizontal)
                    .onDrop(of: [String(kUTTypeURL)], delegate: DragAndDropPreview)

                    if !DragAndDropPreview.selectedPreviewDatas.isEmpty{
                        Text("Double tab to remove!")
                            .font(.caption)
                            .foregroundColor(.red)
                            .bold()
                            .padding(.horizontal)
                    }
                }
                .padding(.vertical)
                .background(BlurView())
                .cornerRadius(25)
                .padding(.horizontal)
                .padding(.bottom,5)
            }

//            .edgesIgnoringSafeArea(.all)
    }
}

/// <#Description#>
//struct BottomSheet : View{
//    @EnvironmentObject var previewModle : PreviewModle
//    @EnvironmentObject var searchStateManager : SeachingViewStateManager
//    @EnvironmentObject var DragAndDropPreview : DragAndDropViewModel //Using previeModle
//
////    @Binding var isPreview : Bool
//    @State private var cardOffset:CGFloat = 0
//    var body : some View{
//        VStack{
//            Spacer()
//            VStack(spacing:12){
//
//                Capsule()
//                    .fill(Color.gray)
//                    .frame(width: 60, height: 4)
//
//                Text("PREVIEW RESULT")
//                    .bold()
//                    .foregroundColor(.gray)
//
//                //the preview result must not empty
//                if previewModle.previewData != nil{
//                    VStack{
//                        HStack(){
//                            //Movie Image Cover Here
//                            HStack(alignment:.top){
//                                WebImage(url: self.previewModle.previewData!.posterURL)
//                                    .resizable()
//                                    .aspectRatio(contentMode: .fit)
//                                    .frame(width: 135)
//                                    .cornerRadius(10)
//                                    .clipped()
//                                //Movie Deatil
//
//                                //OR MORE...
//                                //Name,Genre,Actor,ReleaseDate,Time, Langauge etc
//                                VStack(alignment:.leading,spacing:10){
//                                    Text(self.previewModle.previewData!.title)
//                                        .bold()
//                                        .font(.headline)
//                                        .lineLimit(1)
//                                    HStack(spacing:0){
//                                        //at most show 2 genre!
//                                        Text("Genre: ")
//                                            .font(.system(size: 14))
//                                            .foregroundColor(.gray)
////                                            .lineLimit(1)
//
//                                        if self.previewModle.previewData!.genres != nil{
//                                            HStack(spacing:0){
//                                                ForEach(0..<(self.previewModle.previewData!.genres!.count >= 2 ? 2 : self.previewModle.previewData!.genres!.count)){i in
//
//                                                    Text(self.previewModle.previewData!.genres![i].name)
//                                                        .font(.system(size: 14))
//                                                        .foregroundColor(.gray)
//
//                                                    if i != (self.previewModle.previewData!.genres!.count >= 2 ? 1 : self.previewModle.previewData!.genres!.count-1){
//                                                        Text(",")
//                                                            .font(.system(size: 14))
//                                                            .foregroundColor(.gray)
//                                                    }
//                                                }
//                                            }
//                                            .lineLimit(1)
//                                        }else{
//                                            Text("n/a")
//                                                .font(.system(size: 14))
//                                                .foregroundColor(.gray)
//                                        }
//
//                                    }
//
//                                    Text("Language: \(self.previewModle.previewData!.originalLanguage)")
//                                        .font(.system(size: 14))
//                                        .foregroundColor(.gray)
//                                        .lineLimit(1)
//
//                                    HStack(spacing:0){
//                                        //at most show 2 genre!
//                                        Text("Actor: ")
//                                            .font(.system(size: 14))
//                                            .foregroundColor(.gray)
////                                            .lineLimit(1)
//                                        if self.previewModle.previewData!.cast != nil{
//                                            HStack(spacing:0){
//                                                ForEach(0..<(self.previewModle.previewData!.cast!.count >= 2 ? 2 : self.previewModle.previewData!.cast!.count)){i in
//
//                                                    Text(self.previewModle.previewData!.cast![i].name)
//                                                        .font(.system(size: 14))
//                                                        .foregroundColor(.gray)
//
//                                                    if i != (self.previewModle.previewData!.cast!.count >= 2 ? 1 : self.previewModle.previewData!.cast!.count-1){
//                                                        Text(",")
//                                                            .font(.system(size: 14))
//                                                            .foregroundColor(.gray)
//                                                    }
//                                                }
//                                            }
//                                            .lineLimit(1)
//
//                                        }else{
//                                            Text("n/a")
//                                                .font(.system(size: 14))
//                                                .foregroundColor(.gray)
//                                        }
//
//                                    }
//
//                                    Text("Release: \(self.previewModle.previewData!.releaseDate!)")
//                                        .font(.system(size: 14))
//                                        .foregroundColor(.gray)
//                                        .lineLimit(1)
//                                    Text("Time: \(self.previewModle.previewData!.durationText)")
//                                        .font(.system(size: 14))
//                                        .foregroundColor(.gray)
//                                        .lineLimit(1)
//                                }
//                                .padding(.top)
//
//                                Spacer()
//
//                            }.padding(.horizontal)
//                            .frame(width:UIScreen.main.bounds.width,height: UIScreen.main.bounds.height / 4)
//
//
////                            Spacer()
//                        }
////                        .padding(.horizontal)
//
//                        VStack(alignment:.leading){
//                            Text("Overview:")
//                                .bold()
//                                .font(.subheadline)
//                                .lineLimit(1)
//
//                            if self.previewModle.previewData!.overview != "" {
//                                HStack(spacing:0){
//                                    Text(self.previewModle.previewData!.overview)
//
//                                        .font(.footnote)
//                                        .lineLimit(3)
//
//                                    Spacer()
//                                }
//                                .frame(maxWidth:.infinity)
//                            }else{
//                                HStack(spacing:0){
//                                    Text("Opps! Overview is comming soon...")
//                                        .font(.footnote)
//                                        .lineLimit(3)
//
//                                    Spacer()
//                                }
//                                .frame(maxWidth:.infinity)
//                            }
//                        }
//                        .padding(.horizontal)
//
//                        HStack(spacing:45){
//
//                            SmallRectButton(title: "Detail", icon: "ellipsis.circle"){
//                                withAnimation(){
//                                    //it need to toggle preview state too
//                                    self.searchStateManager.previewResult.toggle()
//                                    self.previewModle.isShowPreview.toggle()
//                                }
//                            }
//
//                            SmallRectButton(title: "More", icon: "magnifyingglass", textColor: .white, buttonColor: Color("BluttonBulue2")){
//                                withAnimation(){
//                                    self.searchStateManager.previewMoreResult.toggle()
//                                    self.previewModle.isShowPreview.toggle()
//                                }
//                            }
//
//                        }
//                        .padding(.horizontal)
//                    }
//                    //                .padding(.horizontal,5)
//                    .padding(.top,10)
//                    .padding(.bottom)
//                    .padding(.bottom,UIApplication.shared.windows.first?.safeAreaInsets.bottom)
//                }
//                else{
//                    VStack{
//                        Text("Empty Result!")
//                            .foregroundColor(.gray)
//                            .frame(width:UIScreen.main.bounds.width,height: UIScreen.main.bounds.height / 4)
//                    }
//                    .padding(.top,10)
//                    .padding(.bottom)
//                    .padding(.bottom,UIApplication.shared.windows.first?.safeAreaInsets.bottom)
//                }
//                //The preview result here
//            }
////            .padding(.horizontal,5) ??
//            .padding(.top)
//            .background(BlurView().clipShape(CustomeConer(width: 20, height: 20,coners: [.topLeft,.topRight])))
//            .offset(y:cardOffset)
//            .gesture(
//                DragGesture()
//                    .onChanged(self.onChage(value:))
//                    .onEnded(self.onEnded(value:))
//            )
//            .offset(y:self.previewModle.isShowPreview ? 0 : UIScreen.main.bounds.height)
//        }
//        .ignoresSafeArea()
//        .background(Color
//                        .black
//                        .opacity(self.previewModle.isShowPreview ? 0.3 : 0)
//                        .onTapGesture {
//
//                            withAnimation(){                                self.previewModle.isShowPreview.toggle()
//                            }
//                        }
//                        .ignoresSafeArea().clipShape(CustomeConer(width: 20, height: 20,coners: [.topLeft,.topRight])))
//
//    }
//
//    private func onChage(value : DragGesture.Value){
//        print(value.translation.height)
//        if value.translation.height > 0 {
//            self.cardOffset = value.translation.height
//        }
//    }
//
//    private func onEnded(value : DragGesture.Value){
//        if value.translation.height > 0 {
//            withAnimation(){
//                let cardHeight = UIScreen.main.bounds.height / 4
//
//                if value.translation.height > cardHeight / 2.8 {
//                    self.previewModle.isShowPreview.toggle()
//                }
//                self.cardOffset = 0
//            }
//        }
//    }
//
//}

struct BottomSheet : View{
    @EnvironmentObject var searchStateManager : SeachingViewStateManager
    @EnvironmentObject var DragAndDropPreview : DragAndDropViewModel //Using previeModle

//    @Binding var isPreview : Bool
    @State private var cardOffset:CGFloat = 0
    var body : some View{
        VStack{
            Spacer()
            VStack(spacing:12){

                Capsule()
                    .fill(Color.gray)
                    .frame(width: 60, height: 4)

                Text("PREVIEW RESULT")
                    .bold()
                    .foregroundColor(.gray)
                
                //the preview result must not empty
                if self.DragAndDropPreview.fetchPreLoading {
                    HStack{
                        ActivityIndicatorView()
                        Text("loading")
                            .foregroundColor(.gray)
                            .font(.system(size: 14))
                           
                    }
                    .frame(width:UIScreen.main.bounds.width,height: UIScreen.main.bounds.height / 4)
                    .padding(.top,10)
                    .padding(.bottom)
                    .padding(.bottom,UIApplication.shared.windows.first?.safeAreaInsets.bottom)
                } else {
                    if DragAndDropPreview.previewData != nil{
                        VStack{
                            HStack(){
                                //Movie Image Cover Here
                                HStack(alignment:.top){
                                    WebImage(url: self.DragAndDropPreview.previewData!.posterURL)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 135)
                                        .cornerRadius(10)
                                        .clipped()
                                    //Movie Deatil
                                    
                                    //OR MORE...
                                    //Name,Genre,Actor,ReleaseDate,Time, Langauge etc
                                    VStack(alignment:.leading,spacing:10){
                                        Text(self.DragAndDropPreview.previewData!.title)
                                            .bold()
                                            .font(.headline)
                                            .lineLimit(1)
                                        HStack(spacing:0){
                                            //at most show 2 genre!
                                            Text("Genre: ")
                                                .font(.system(size: 14))
                                                .foregroundColor(.gray)
                                            //                                            .lineLimit(1)
                                            
                                            if self.DragAndDropPreview.previewData!.genres != nil{
                                                HStack(spacing:0){
                                                    ForEach(0..<(self.DragAndDropPreview.previewData!.genres!.count >= 2 ? 2 : self.DragAndDropPreview.previewData!.genres!.count)){i in
                                                        
                                                        Text(self.DragAndDropPreview.previewData!.genres![i].name)
                                                            .font(.system(size: 14))
                                                            .foregroundColor(.gray)
                                                        
                                                        if i != (self.DragAndDropPreview.previewData!.genres!.count >= 2 ? 1 : self.DragAndDropPreview.previewData!.genres!.count-1){
                                                            Text(",")
                                                                .font(.system(size: 14))
                                                                .foregroundColor(.gray)
                                                        }
                                                    }
                                                }
                                                .lineLimit(1)
                                            }else{
                                                Text("n/a")
                                                    .font(.system(size: 14))
                                                    .foregroundColor(.gray)
                                            }
                                            
                                        }
                                        
                                        Text("Language: \(self.DragAndDropPreview.previewData!.originalLanguage)")
                                            .font(.system(size: 14))
                                            .foregroundColor(.gray)
                                            .lineLimit(1)
                                        
                                        HStack(spacing:0){
                                            //at most show 2 genre!
                                            Text("Actor: ")
                                                .font(.system(size: 14))
                                                .foregroundColor(.gray)
                                            //                                            .lineLimit(1)
                                            if self.DragAndDropPreview.previewData!.cast != nil{
                                                HStack(spacing:0){
                                                    ForEach(0..<(self.DragAndDropPreview.previewData!.cast!.count >= 2 ? 2 : self.DragAndDropPreview.previewData!.cast!.count)){i in
                                                        
                                                        Text(self.DragAndDropPreview.previewData!.cast![i].name)
                                                            .font(.system(size: 14))
                                                            .foregroundColor(.gray)
                                                        
                                                        if i != (self.DragAndDropPreview.previewData!.cast!.count >= 2 ? 1 : self.DragAndDropPreview.previewData!.cast!.count-1){
                                                            Text(",")
                                                                .font(.system(size: 14))
                                                                .foregroundColor(.gray)
                                                        }
                                                    }
                                                }
                                                .lineLimit(1)
                                                
                                            }else{
                                                Text("n/a")
                                                    .font(.system(size: 14))
                                                    .foregroundColor(.gray)
                                            }
                                            
                                        }
                                        
                                        Text("Release: \(self.DragAndDropPreview.previewData!.releaseDate!)")
                                            .font(.system(size: 14))
                                            .foregroundColor(.gray)
                                            .lineLimit(1)
                                        Text("Time: \(self.DragAndDropPreview.previewData!.durationText)")
                                            .font(.system(size: 14))
                                            .foregroundColor(.gray)
                                            .lineLimit(1)
                                    }
                                    .padding(.top)
                                    
                                    Spacer()
                                    
                                }.padding(.horizontal)
                                .frame(width:UIScreen.main.bounds.width,height: UIScreen.main.bounds.height / 4)
                                
                                
                                //                            Spacer()
                            }
                            //                        .padding(.horizontal)
                            
                            VStack(alignment:.leading){
                                Text("Overview:")
                                    .bold()
                                    .font(.subheadline)
                                    .lineLimit(1)
                                
                                if self.DragAndDropPreview.previewData!.overview != "" {
                                    HStack(spacing:0){
                                        Text(self.DragAndDropPreview.previewData!.overview)
                                            
                                            .font(.footnote)
                                            .lineLimit(3)
                                        
                                        Spacer()
                                    }
                                    .frame(maxWidth:.infinity)
                                }else{
                                    HStack(spacing:0){
                                        Text("Opps! Overview is comming soon...")
                                            .font(.footnote)
                                            .lineLimit(3)
                                        
                                        Spacer()
                                    }
                                    .frame(maxWidth:.infinity)
                                }
                            }
                            .padding(.horizontal)
                            
                            HStack(spacing:45){
                                
                                SmallRectButton(title: "Detail", icon: "ellipsis.circle"){
                                    withAnimation(){
                                        //it need to toggle preview state too
                                        self.searchStateManager.previewResult.toggle()
                                        self.DragAndDropPreview.isShowPreview.toggle()
                                    }
                                }
                                
                                SmallRectButton(title: "More", icon: "magnifyingglass", textColor: .white, buttonColor: Color("BluttonBulue2")){
                                    withAnimation(){
                                        self.searchStateManager.previewMoreResult.toggle()
                                        self.DragAndDropPreview.isShowPreview.toggle()
                                    }
                                }
                                
                            }
                            .padding(.horizontal)
                        }
                        //                .padding(.horizontal,5)
                        .padding(.top,10)
                        .padding(.bottom)
                        .padding(.bottom,UIApplication.shared.windows.first?.safeAreaInsets.bottom)
                    }
                    else{
                        VStack{
                            Text("Empty Result!")
                                .foregroundColor(.gray)
                                .frame(width:UIScreen.main.bounds.width,height: UIScreen.main.bounds.height / 4)
                        }
                        .padding(.top,10)
                        .padding(.bottom)
                        .padding(.bottom,UIApplication.shared.windows.first?.safeAreaInsets.bottom)
                        
                        
                        
                    }
                    
                }

                
                //The preview result here
            }
//            .padding(.horizontal,5) ??
            .padding(.top)
            .background(BlurView().clipShape(CustomeConer(width: 20, height: 20,coners: [.topLeft,.topRight])))
            .offset(y:cardOffset)
            .gesture(
                DragGesture()
                    .onChanged(self.onChage(value:))
                    .onEnded(self.onEnded(value:))
            )
            .offset(y:self.DragAndDropPreview.isShowPreview ? 0 : UIScreen.main.bounds.height)
        }
        .ignoresSafeArea()
        .background(Color
                        .black
                        .opacity(self.DragAndDropPreview.isShowPreview ? 0.3 : 0)
                        .onTapGesture {
                            
                            withAnimation(){                                self.DragAndDropPreview.isShowPreview.toggle()
                            }
                        }
                        .ignoresSafeArea().clipShape(CustomeConer(width: 20, height: 20,coners: [.topLeft,.topRight])))

    }

    private func onChage(value : DragGesture.Value){
        print(value.translation.height)
        if value.translation.height > 0 {
            self.cardOffset = value.translation.height
        }
    }

    private func onEnded(value : DragGesture.Value){
        if value.translation.height > 0 {
            withAnimation(){
                let cardHeight = UIScreen.main.bounds.height / 4

                if value.translation.height > cardHeight / 2.8 {
                    self.DragAndDropPreview.isShowPreview.toggle()
                }
                self.cardOffset = 0
            }
        }
    }

}

struct CustomeConer : Shape {
    var width :CGFloat = 30
    var height :CGFloat = 30
    var coners : UIRectCorner

    func path(in rect: CGRect) -> Path {
        //set coner and coner radius
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: coners, cornerRadii: CGSize(width: width, height: height))
        return Path(path.cgPath)
    }
}

struct CustomePicker : View {
    @Binding var selectedTabs : Tab
    @Namespace var animateTab
    var body: some View {
        VStack{
            HStack{
                Image(systemName: "globe")
                    .font(.system(size: 22,weight:.bold))
                    .foregroundColor(self.selectedTabs == .Genre ? .black : .white)
                    .frame(width: 70, height: 35)
                    .background(
                        ZStack{
                            if self.selectedTabs != .Genre {
                                Color.clear
                            }else{
                                Color.white.matchedGeometryEffect(id: "Tab", in: animateTab)
                            }

                        }
                    )
                    .cornerRadius(10)
                    .onTapGesture {
                        withAnimation{
                            self.selectedTabs = .Genre
                        }
                    }

                Image(systemName: "signature")
                    .font(.system(size: 22,weight:.bold))
                    .foregroundColor(self.selectedTabs == .Actor ? .black : .white)
                    .frame(width: 70, height: 35)
                    .background(
                        ZStack{
                            if self.selectedTabs != .Actor {
                                Color.clear
                            }else{
                                Color.white.matchedGeometryEffect(id: "Tab", in: animateTab)
                            }

                        }
                    )
                    .cornerRadius(10)
                    .onTapGesture {
                        withAnimation{
                            self.selectedTabs = .Actor
                        }
                    }

                Image(systemName: "squareshape.controlhandles.on.squareshape.controlhandles")
                    .font(.system(size: 22,weight:.bold))
                    .foregroundColor(self.selectedTabs == .Director ? .black : .white)
                    .frame(width: 70, height: 35)
                    .background(
                        ZStack{
                            if self.selectedTabs != .Director {
                                Color.clear
                            }else{
                                Color.white.matchedGeometryEffect(id: "Tab", in: animateTab)
                            }

                        }
                    )
                    .cornerRadius(10)
                    .onTapGesture {
                        withAnimation{
                            self.selectedTabs = .Director
                        }
                    }
            }
            .background(Color.white.opacity(0.15))
            .cornerRadius(15)
//
//            Text(self.selectedTabs)
//                .bold()
//                .font(.title3)
//                .padding(.vertical,5)
           // Spacer()
        }
        .edgesIgnoringSafeArea(.all)
        .padding(.vertical,10)

    }

}

struct ScrollableCardGrid: View{
    @State private var coreHaptics : CHHapticEngine?
    let comlums = Array(repeating: GridItem(.flexible(),spacing: 10), count: 2)
    @Binding var list : [DragItemData]
    @State private var isFetchingData : Bool = false
    @State private var offset:CGFloat = 0.0
    var beAbleToUpdate : Bool = true
    var body : some View{
//        ScrollView(.vertical, showsIndicators: false){
//        }
        DragRefreshableScrollView(
            dataType : list[0].itemType ,
            datas:self.$list,
            isFetchingData: self.$isFetchingData,
            beAbleToUpdate : beAbleToUpdate,
            content: {
                VStack{
                    LazyVGrid(columns: comlums){
                        if self.list[0].itemType == CharacterRule.Genre{
                            ForEach(self.list,id:\.id){ data in
                                if data.genreData!.describeImg != ""{ //here we are know that is genre type
                                    //redner the cell
                                    //Some Drag issue here
                                    VStack(spacing:3){
                                        WebImage(url: data.genreData!.posterImg)
                                            .resizable()
                                            .indicator(.activity)
                                            .transition(.fade(duration: 0.5))
                                            .aspectRatio(contentMode: .fit)
                                            .frame(height:200)
                                            .cornerRadius(25)
                                            .onDrag{
                                                EngineSuccess()
                                                return NSItemProvider(contentsOf: URL(string: data.id))! }
                                        //
                                        Text(data.genreData!.info.name)
                                            .frame(width:120,height:50,alignment:.center)
                                            .lineLimit(2)
                                    }
                                    .padding(.top)
                                }
                            }
                        }else{
                            ForEach(self.list,id:\.id){ data in
                                if data.personData!.profilePath != ""{ //here we are know that is genre type
                                    //redner the cell
                                    //Some Drag issue here
                                    VStack(spacing:3){
                                        WebImage(url: data.personData!.ProfileImageURL)
                                            .resizable()
                                            .indicator(.activity)
                                            .transition(.fade(duration: 0.5))
                                            .aspectRatio(contentMode: .fit)
                                            .frame(height:200)
                                            .cornerRadius(25)
                                            .onDrag{
                                                EngineSuccess()
                                                return NSItemProvider(contentsOf: URL(string: data.id))! }
                                        //
                                        Text(data.personData!.name)
                                            .frame(width:120,height:50,alignment:.center)
                                            .lineLimit(2)
                                    }
                                    .padding(.top)
                                }
                            }
                        }
                    }
                    
                    if isFetchingData && beAbleToUpdate{
                        VStack{
                            ActivityIndicatorView()
                        }
                        .padding(.vertical)
                        
                    }
                }
                //                .padding(.bottom,150)
                //                .modifier(OffsetModifier(offset: self.$offset))
                .padding(.horizontal)
            }, onRefresh: {control in
                if beAbleToUpdate{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        self.list.insert(contentsOf: fakeDataFetch(type: list[0].itemType), at: 0)
                        control.endRefreshing()
                    }
                }
                
            })

        
        .onAppear(perform: initEngine)
    }

    func fakeDataFetch(type : CharacterRule) -> [DragItemData] {
        switch type {
        case .Genre:
            let genreTest : [DragItemData] = [
                DragItemData(itemType: .Genre, genreData: tempDragGenreData[0], personData: nil),
                DragItemData(itemType: .Genre, genreData: tempDragGenreData[1], personData: nil),
                DragItemData(itemType: .Genre, genreData: tempDragGenreData[2], personData: nil),
                DragItemData(itemType: .Genre, genreData: tempDragGenreData[3], personData: nil),
                DragItemData(itemType: .Genre, genreData: tempDragGenreData[4], personData: nil),
                DragItemData(itemType: .Genre, genreData: tempDragGenreData[5], personData: nil),
                DragItemData(itemType: .Genre, genreData: tempDragGenreData[6], personData: nil),
                DragItemData(itemType: .Genre, genreData: tempDragGenreData[7], personData: nil),
                DragItemData(itemType: .Genre, genreData: tempDragGenreData[8], personData: nil),
                DragItemData(itemType: .Genre, genreData: tempDragGenreData[9], personData: nil),
            ]
            return genreTest.shuffled()
            
        case .Actor:
            let actorTest: [DragItemData] = [
                DragItemData(itemType: .Actor, genreData: nil, personData: actorTemp[0]),
                DragItemData(itemType: .Actor, genreData: nil, personData: actorTemp[1]),
                DragItemData(itemType: .Actor, genreData: nil, personData: actorTemp[2]),
                DragItemData(itemType: .Actor, genreData: nil, personData: actorTemp[3]),
                DragItemData(itemType: .Actor, genreData: nil, personData: actorTemp[4]),
                DragItemData(itemType: .Actor, genreData: nil, personData: actorTemp[5]),
                DragItemData(itemType: .Actor, genreData: nil, personData: actorTemp[6]),
                DragItemData(itemType: .Actor, genreData: nil, personData: actorTemp[7]),
                DragItemData(itemType: .Actor, genreData: nil, personData: actorTemp[8]),
                DragItemData(itemType: .Actor, genreData: nil, personData: actorTemp[9]),
            ]
            
            return actorTest.shuffled()
           
        case .Director:
            let directorTest: [DragItemData] = [
                DragItemData(itemType: .Director, genreData: nil, personData: DirectorTemp[0]),
                DragItemData(itemType: .Director, genreData: nil, personData: DirectorTemp[1]),
                DragItemData(itemType: .Director, genreData: nil, personData: DirectorTemp[2]),
                DragItemData(itemType: .Director, genreData: nil, personData: DirectorTemp[3]),
                DragItemData(itemType: .Director, genreData: nil, personData: DirectorTemp[4]),
                DragItemData(itemType: .Director, genreData: nil, personData: DirectorTemp[5]),
                DragItemData(itemType: .Director, genreData: nil, personData: DirectorTemp[6]),
                DragItemData(itemType: .Director, genreData: nil, personData: DirectorTemp[7]),
                DragItemData(itemType: .Director, genreData: nil, personData: DirectorTemp[8]),
                DragItemData(itemType: .Director, genreData: nil, personData: DirectorTemp[9]),
            ]
            
            return directorTest.shuffled()
        
        }
    }
    

    private func initEngine(){
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else {
            return
        }

        do {
            self.coreHaptics = try CHHapticEngine()
            try coreHaptics?.start()
        }catch {
            print("Engine Start Error:\(error.localizedDescription)")
        }
    }

    private func EngineSuccess(){
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else {
            return
        }

        var engineEvent = [CHHapticEvent]()

        let intensitySetting = CHHapticEventParameter(parameterID: .hapticIntensity, value: 100)
        let sharpnessSetting = CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.5)

        let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensitySetting,sharpnessSetting], relativeTime: 0)

        engineEvent.append(event)

        do{
            let pattern = try CHHapticPattern(events: engineEvent, parameters: [])
            let player = try self.coreHaptics?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        }catch{
            print("Failed to player pattern")
        }
    }
}

struct MovieRule : Identifiable,Hashable{
    let id :String = UUID().uuidString //for now just dummy id
    let name : String
    let rule : CharacterRule
    let postURL : String
}


