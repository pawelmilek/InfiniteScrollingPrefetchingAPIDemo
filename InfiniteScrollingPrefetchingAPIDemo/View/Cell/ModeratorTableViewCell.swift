//
//  ModeratorTableViewCell.swift
//  InfiniteScrollingPrefetchingAPIDemo
//
//  Created by Pawel Milek on 26/06/2018.
//  Copyright © 2018 Pawel Milek. All rights reserved.
//

import UIKit
import SDWebImage

class ModeratorTableViewCell: UITableViewCell {
  @IBOutlet private weak var profileImageView: UIImageView! {
    didSet {
      profileImageView.layer.cornerRadius = profileImageView.frame.size.height / 2
      profileImageView.layer.borderWidth = 1.0
      profileImageView.layer.borderColor = UIColor.mint.cgColor
      profileImageView.layer.masksToBounds = true
    }
  }
  
  @IBOutlet private weak var displayNameLabel: UILabel!
  @IBOutlet private weak var reputationScoreLabel: UILabel!
  @IBOutlet private weak var indicatorView: UIActivityIndicatorView!
  
  
  private var moderator: Moderator? {
    didSet {
      guard let moderator = moderator else { return }
      
      profileImageView.sd_setIndicatorStyle(.gray)
      profileImageView.sd_setImage(with: URL(string: moderator.profileImage))
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
    indicatorView.color = .mint
  }
  
}


// MARK: - Configure cell
extension ModeratorTableViewCell {
  
  func configure(with item: Moderator?) {
    moderator = item
    
    if let _ = item {
      profileImageView.alpha = 1
      displayNameLabel.alpha = 1
      reputationScoreLabel.alpha = 1
      indicatorView.stopAnimating()
    } else {
      profileImageView.alpha = 0
      displayNameLabel.alpha = 0
      reputationScoreLabel.alpha = 0
      indicatorView.startAnimating()
    }
  }
}
