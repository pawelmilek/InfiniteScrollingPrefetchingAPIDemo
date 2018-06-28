//
//  ModeratorRequest.swift
//  InfiniteScrollingPrefetchingAPIDemo
//
//  Created by Pawel Milek on 26/06/2018.
//  Copyright © 2018 Pawel Milek. All rights reserved.
//

import Foundation

struct ModeratorRequest: WebServiceRequest {
  var path = "users/moderators"
  var parameters: Parameters
  
  private init(parameters: Parameters) {
    self.parameters = parameters
  }
}


// MARK: - Get moderators
extension ModeratorRequest {
  
  static func make(from site: String, at page: Int = 1) -> ModeratorRequest {
    let defaultParameters = ["order": "desc", "sort": "reputation", "filter": "!-*jbN0CeyJHb", "page": "\(page)"]
    let parameters = ["site": "\(site)"].merging(defaultParameters, uniquingKeysWith: +)
    
    return ModeratorRequest(parameters: parameters)
  }

}
