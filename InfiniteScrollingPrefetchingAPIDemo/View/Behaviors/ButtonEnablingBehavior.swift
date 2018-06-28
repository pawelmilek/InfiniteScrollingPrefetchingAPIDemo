//
//  ButtonEnablingBehavior.swift
//  InfiniteScrollingPrefetchingAPIDemo
//
//  Created by Pawel Milek on 25/06/2018.
//  Copyright © 2018 Pawel Milek. All rights reserved.
//

import Foundation
import UIKit

final class ButtonEnablingBehavior: NSObject {
  private let textFields: [UITextField]
  let onChange: (Bool) -> Void
  
  
  init(textFields: [UITextField], onChange: @escaping (Bool) -> Void) {
    self.textFields = textFields
    self.onChange = onChange
    super.init()
    setup()
  }
}


// MARK: - Setup behavior
private extension ButtonEnablingBehavior {
  
  func setup() {
    textFields.forEach {
      $0.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    onChange(false)
  }
  
}


// MARK: - Text field did change
private extension ButtonEnablingBehavior {
  
  @objc func textFieldDidChange(_ textField: UITextField) {
    var enable = true
    for textField in textFields {
      guard let text = textField.text, !text.isEmpty else {
        enable = false
        break
      }
    }
    onChange(enable)
  }
  
}
