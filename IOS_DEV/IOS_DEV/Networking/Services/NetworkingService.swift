//
//  NetworkingService.swift
//  IOS_DEV
//
//  Created by Kao Li Chi on 2021/5/18.
//

//for login and get article

import Foundation

class NetworkingService: ObservableObject {
    
    let baseUrl="http://127.0.0.1:8080"
    var token = ""
        
    //login
    func requestLogin(endpoint: String,
                 loginObject: UserLogin,
                 completion: @escaping (Result<Me, Error>) -> Void) {
        
        guard let url = URL(string: baseUrl + endpoint) else {
            completion(.failure(NetworkingError.badUrl))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let payload = try JSONEncoder().encode(loginObject)
            print("login payload \(payload)")
            URLSession.shared.uploadTask(with: request, from: payload){ (data, response, error) in
                guard let data = data else {
                    print("login failed")
                    return
                }
                let token = String(data:data, encoding: String.Encoding.utf8)
                print("login token \(String(describing:token))")
                self.token = token ?? ""
                self.setMe(token: self.token, completion: completion)
         
            }.resume()
        } catch {
            print ("Login failed during call")
        }
  

    }
    
    //驗證token,辨識user
    func setMe(token:String, completion: @escaping (Result<Me, Error>) -> Void){
        let url = URL(string: baseUrl+"/users/me")
        var request = URLRequest(url: url!)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        let result = URLSession.shared.dataTask(with: request){ (data, response, error) in
            guard let gotData = data else{
                print("failed to get data")
                return
            }
            do {
                if let user = try? JSONDecoder().decode(Me.self, from: gotData) {
                    completion(.success(user))
                }else {
                    let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: gotData)
                    completion(.failure(errorResponse))
                }
            } catch {
                print("failed to decode user objects")
            }
            
            
        }
        result.resume()
    }
    
    
    func getToken() -> String{
        return token
    }
    func getBaseURL() -> String{
        return baseUrl
    }
    
    //----------------------------------nowUser-------------------------------------//
    
    func Get_nowUser(endpoint: String,
                 completion: @escaping (Result<Me, Error>) -> Void) {
        
        guard let url = URL(string: baseUrl + endpoint) else {
            completion(.failure(NetworkingError.badUrl))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    
        nowUserResponse(for: request, completion: completion)
        
    }
    

    func nowUserResponse(for request: URLRequest,
                        completion: @escaping (Result<Me, Error>) -> Void){
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { (data, response, error) in
            
            //check the response status
            DispatchQueue.main.async {
//                guard let unwrappedResponse = response as? HTTPURLResponse else {
//                    completion(.failure(NetworkingError.badResponse))   //badResponse : 連不上伺服器
//                    return
//                }
//                print(unwrappedResponse.statusCode)
//                switch unwrappedResponse.statusCode {
//                case 200 ..< 300:   //200~300 ,NOT INCLUDE 300
//                    print("success")
//                default:
//                    print("failure")
//                }
                
                //伺服器回傳的error （事實上錯誤訊息會由data回傳）
                if let unwrappedError = error {
                    completion(.failure(unwrappedError))
                    return
                }
                
                //伺服器回傳的data （含錯誤訊息）
                if let unwrappedData = data {
                    do {
//                        // turn data into json
//                        let json = try JSONSerialization.jsonObject(with: unwrappedData, options: [])
//                        print(json)
                        
                        // decode data
                        if let me = try? JSONDecoder().decode(Me.self, from: unwrappedData) {
                            completion(.success(me))
                        } else {
                            let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: unwrappedData)
                            completion(.failure(errorResponse))

                        }
                        
                    } catch {
                        completion(.failure(error))
                    }
                }
                
            }
           
        }
        
        task.resume()
        
    }
    
    //----------------------------------article-------------------------------------//
    func handleResponse(for request: URLRequest,
                        completion: @escaping (Result<[Article], Error>) -> Void){
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { (data, response, error) in
            
            //check the response status
            DispatchQueue.main.async {
                guard let unwrappedResponse = response as? HTTPURLResponse else {
                    completion(.failure(NetworkingError.badResponse))   //badResponse : 連不上伺服器
                    return
                }
            
                print(unwrappedResponse.statusCode)
                switch unwrappedResponse.statusCode {
                case 200 ..< 300:   //200~300 ,NOT INCLUDE 300
                    print("success")
                default:
                    print("failure")
                }
                
                //伺服器回傳的error （事實上錯誤訊息會由data回傳）
                if let unwrappedError = error {
                    completion(.failure(unwrappedError))
                    return
                }
                
                //伺服器回傳的data （含錯誤訊息）
                if let unwrappedData = data {
                    do {
                        // turn data into json
                        let json = try JSONSerialization.jsonObject(with: unwrappedData, options: [])
                        print(json)

                        
                        // decode data
                        if let article = try? JSONDecoder().decode([Article].self, from: unwrappedData) {
                            completion(.success(article))
                        } else {
                            let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: unwrappedData)
                            completion(.failure(errorResponse))

                        }
                        
                    } catch {
                        completion(.failure(error))
                    }
                }
                
            }
           
        }
        
        task.resume()
        
    }
    
    
    //get article
    func request(endpoint: String,
                 completion: @escaping (Result<[Article], Error>) -> Void) {
        
        guard let url = URL(string: baseUrl + endpoint) else {
            completion(.failure(NetworkingError.badUrl))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    
        handleResponse(for: request, completion: completion)
        
    }
    
    //----------------------------------article-------------------------------------//
    
    enum NetworkingError: Error{
        case badUrl
        case badResponse
        case badEncoding
    }
}


//
//protocol SocialService {
//
//    func fetchList(query: String, completion: @escaping (Result<MovieResponse, MovieError>) -> ())
//}
//
//enum SocialError: Error, CustomNSError {
//
//    case apiError
//    case invalidEndpoint
//    case invalidResponse
//    case noData
//    case serializationError
//
//    var localizedDescription: String {
//        switch self {
//        case .apiError: return "Failed to fetch data"
//        case .invalidEndpoint: return "Invalid endpoint"
//        case .invalidResponse: return "Invalid response"
//        case .noData: return "No data"
//        case .serializationError: return "Failed to decode data"
//        }
//    }
//
//    var errorUserInfo: [String : Any] {
//        [NSLocalizedDescriptionKey: localizedDescription]
//    }
//
//}
