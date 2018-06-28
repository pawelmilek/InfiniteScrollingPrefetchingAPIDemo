//
//  WebService.swift
//  InfiniteScrollingPrefetchingAPIDemo
//
//  Created by Pawel Milek on 26/06/2018.
//  Copyright © 2018 Pawel Milek. All rights reserved.
//

import Foundation

final class WebService {
  static let shared = WebService()
  
  private let sessionShared: URLSession
  private lazy var baseURL: URL = {
    return URL(string: "http://api.stackexchange.com/2.2/")!
  }()
  
  
  private init() {
    self.sessionShared = URLSession.shared
  }
}


extension WebService {
  
  func fetch<M: Decodable>(_ typeOf: M.Type, with request: WebServiceRequest, completionHandler: @escaping (WebServiceResultType<M, WebServiceError>) -> ()) {
    let urlRequest = URLRequest(url: baseURL.appendingPathComponent(request.path))
    let encodedURLRequest = urlRequest.encode(with: request.parameters)
    
    sessionShared.dataTask(with: encodedURLRequest) { (data, _, error) in
      guard error == nil else {
        completionHandler(.failure(.requestFailed))
        return
      }
      
      guard let data = data else {
        completionHandler(.failure(.dataNotAvailable))
        return
      }
      
      completionHandler(Parser<M>.parseJSON(data))
      }.resume()
  }
}
