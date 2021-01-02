//
//  GithubService.swift
//  Github
//
//  Created by Максим Алексеев on 02.01.2021.
//

import Foundation
import RxSwift
import RxCocoa

class GithubService {
    // MARK:- Properties
    let baseUrl = "api.github.com"
    
    // MARK:- Methods
    func getUser(_ username: String) -> Observable<User> {
        guard let url = URL(string: "\(baseUrl)/users/\(username)") else { return Observable.error(NetworkErrors.unrecognizedError) }
        
        return Observable.create { observer in
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                do {
                    if let response = response as? HTTPURLResponse, response.statusCode == 200, let data = data {
                        let decoder = JSONDecoder()
                        let user = try decoder.decode(User.self, from: data)
                        observer.onNext(user)
                    }
                } catch {
                    observer.onError(NetworkErrors.cantDecode)
                }
                observer.onCompleted()
            }
            
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
}


public class RequestObservable {
    private lazy var jsonDecoder = JSONDecoder()
    private var urlSession: URLSession
    public init(config:URLSessionConfiguration) {
        urlSession = URLSession(configuration:
                                    URLSessionConfiguration.default)
    }
    //MARK: function for URLSession takes
    public func callAPI<ItemModel: Decodable>(request: URLRequest)
    -> Observable<ItemModel> {
        //MARK: creating our observable
        return Observable.create { observer in
            //MARK: create URLSession dataTask
            let task = self.urlSession.dataTask(with: request) { (data,
                                                                  response, error) in
                if let httpResponse = response as? HTTPURLResponse{
                    let statusCode = httpResponse.statusCode
                    do {
                        let _data = data ?? Data()
                        if (200...399).contains(statusCode) {
                            let objs = try self.jsonDecoder.decode(ItemModel.self, from:
                                                                    _data)
                            //MARK: observer onNext event
                            observer.onNext(objs)
                        }
                        else {
                            observer.onError(error!)
                        }
                    } catch {
                        //MARK: observer onNext event
                        observer.onError(error)
                    }
                }
                //MARK: observer onCompleted event
                observer.onCompleted()
            }
            task.resume()
            //MARK: return our disposable
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
