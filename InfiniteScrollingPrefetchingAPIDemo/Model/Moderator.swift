//
//  Moderator.swift
//  InfiniteScrollingPrefetchingAPIDemo
//
//  Created by Pawel Milek on 26/06/2018.
//  Copyright © 2018 Pawel Milek. All rights reserved.
//

import Foundation

struct Moderator {
  let badgesCount: Badge
  let reputationScore: Int
  let profileImage: String
  let displayName: String
}


// MARK: - Formatted reputation score
extension Moderator {
  
  var formattedReputationScore: String {
    let formatter = NumberFormatter()
    formatter.numberStyle = NumberFormatter.Style.decimal
    
    return formatter.string(for: reputationScore) ?? String(reputationScore)
  }
  
}


// MARK: - Decodable protocol
extension Moderator: Decodable {
  
  enum CodingKeys: String, CodingKey {
    case badgesCount = "badge_counts"
    case reputationScore = "reputation"
    case profileImage = "profile_image"
    case displayName = "display_name"
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    
    self.badgesCount = try container.decode(Badge.self, forKey: .badgesCount)
    self.reputationScore = try container.decode(Int.self, forKey: .reputationScore)
    self.profileImage = try container.decode(String.self, forKey: .profileImage)
    self.displayName = try container.decode(String.self, forKey: .displayName)
  }
}
