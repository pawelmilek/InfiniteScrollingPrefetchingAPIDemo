//
//  ModeratorResponse.swift
//  InfiniteScrollingPrefetchingAPIDemo
//
//  Created by Pawel Milek on 26/06/2018.
//  Copyright © 2018 Pawel Milek. All rights reserved.
//

import Foundation

struct ModeratorResponse: Decodable {
  let moderators: [Moderator]
  let hasMore: Bool
  let quotaMax: Int
  let quotaRemaining: Int
  let page: Int
  let total: Int
  
  
  enum CodingKeys: String, CodingKey {
    case moderators = "items"
    case hasMore = "has_more"
    case quotaMax = "quota_max"
    case quotaRemaining = "quota_remaining"
    case page = "page"
    case total = "total"
  }
}


//// MARK: - Decodable protocol
//extension ModeratorResponse: Decodable {
//  
//  
//  
//}

