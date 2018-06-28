//
//  Badge.swift
//  InfiniteScrollingPrefetchingAPIDemo
//
//  Created by Pawel Milek on 26/06/2018.
//  Copyright © 2018 Pawel Milek. All rights reserved.
//

import Foundation

struct Badge {
  let bronze: Int
  let silver: Int
  let gold: Int
}


// MARK: - Decodable protocol
extension Badge: Decodable {
  
  enum CodingKeys: String, CodingKey {
    case bronze
    case silver
    case gold
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    
    self.bronze = try container.decode(Int.self, forKey: .bronze)
    self.silver = try container.decode(Int.self, forKey: .silver)
    self.gold = try container.decode(Int.self, forKey: .gold)
  }
}
