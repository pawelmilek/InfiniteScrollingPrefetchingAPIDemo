//
//  ReusableView.swift
//  InfiniteScrollingPrefetchingAPIDemo
//
//  Created by Pawel Milek on 25/06/2018.
//  Copyright © 2018 Pawel Milek. All rights reserved.
//

import UIKit

protocol ReusableView: class { }

extension ReusableView where Self: UIView {
  
  static var reuseIdentifier: String {
    return "\(self)"
  }
  
}
