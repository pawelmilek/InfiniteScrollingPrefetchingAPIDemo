//
//  ModeratorTableViewCell.swift
//  InfiniteScrollingPrefetchingAPIDemo
//
//  Created by Pawel Milek on 26/06/2018.
//  Copyright © 2018 Pawel Milek. All rights reserved.
//

import UIKit

class ModeratorTableViewCell: UITableViewCell {
  @IBOutlet var displayNameLabel: UILabel!
  @IBOutlet var reputationScoreLabel: UILabel!
  @IBOutlet var indicatorView: UIActivityIndicatorView!
  
  
  private var moderator: Moderator? {
    didSet {
      guard let moderator = moderator else { return }
      displayNameLabel.text = moderator.displayName
      reputationScoreLabel.text = moderator.formattedReputationScore
    }
  }
  
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setup()
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    configure(with: .none)
  }
  
}


// MARK: - ViewSetupable protocol
extension ModeratorTableViewCell: ViewSetupable {
  
  func setup() {
    indicatorView.hidesWhenStopped = true
    indicatorView.color = .red
  }
  
}


// MARK: - Configure cell
extension ModeratorTableViewCell {
  
  func configure(with item: Moderator?) {
    moderator = item
    
    if let _ = item {
      displayNameLabel.alpha = 1
      reputationScoreLabel.alpha = 1
      indicatorView.stopAnimating()
    } else {
      displayNameLabel.alpha = 0
      reputationScoreLabel.alpha = 0
      indicatorView.stopAnimating()
    }
  }
}
