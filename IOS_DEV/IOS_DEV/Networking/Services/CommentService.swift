//
//  CommentService.swift
//  IOS_DEV
//
//  Created by Kao Li Chi on 2021/6/3.
//

//just for comment

import Foundation


class CommentService: ObservableObject {
    
    let baseUrl="http://127.0.0.1:8080"
    let networkingService = NetworkingService()
    
    
    func handleResponse(for request: URLRequest,
                        completion: @escaping (Result<[Comment], Error>) -> Void){
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { (data, response, error) in
            
            //check the response status
            DispatchQueue.main.async {
                guard let unwrappedResponse = response as? HTTPURLResponse else {
                    completion(.failure(NetworkingError.badResponse))   //badResponse : 連不上伺服器
                    return
                }
            
                print(unwrappedResponse.statusCode)
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
                        // turn data into json
                        //let json = try JSONSerialization.jsonObject(with: unwrappedData, options: [])
                       // print(json)

                        
                        // decode data
                        if let comment = try? JSONDecoder().decode([Comment].self, from: unwrappedData) {
                            completion(.success(comment))
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
    
    //get comment
    func GETrequest(endpoint: String,
                 completion: @escaping (Result<[Comment], Error>) -> Void) {
        
        guard let url = URL(string: baseUrl + endpoint) else {
            completion(.failure(NetworkingError.badUrl))
            return
        }
        let token =  networkingService.getToken()
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    
        handleResponse(for: request, completion: completion)
        
    }
    
    //post comment
    func POSTrequest(endpoint: String,
                 RegisterObject: CommentTodo,
                 completion: @escaping (Result<CommentRes, Error>) -> Void) {
        
        guard let url = URL(string: baseUrl + endpoint) else {
            completion(.failure(NetworkingError.badUrl))
            return
        }
        
        var request = URLRequest(url: url)
       
        do {
            let userData = try JSONEncoder().encode(RegisterObject)
            request.httpBody = userData
            
        } catch {
            completion(.failure(NetworkingError.badEncoding))
        }
        
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        Response(for: request, completion: completion)
        
    }
    
    
    func Response(for request: URLRequest,
                        completion: @escaping (Result<CommentRes, Error>) -> Void){
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { (data, response, error) in
            
            //check the response status
            DispatchQueue.main.async {
                guard let unwrappedResponse = response as? HTTPURLResponse else {
                    completion(.failure(NetworkingError.badResponse))   //badResponse : 連不上伺服器
                    return
                }
            
                print(unwrappedResponse.statusCode)
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
                        // turn data into json
                        //let json = try JSONSerialization.jsonObject(with: unwrappedData, options: [])
                       // print(json)

                        // decode data
                        if let comment = try? JSONDecoder().decode(CommentRes.self, from: unwrappedData) {
                            completion(.success(comment))
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
    
    
    
    
    enum NetworkingError: Error{
        case badUrl
        case badResponse
        case badEncoding
    }
}

