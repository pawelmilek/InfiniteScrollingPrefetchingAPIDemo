//
//  ModeratorSearchViewController.swift
//  InfiniteScrollingPrefetchingAPIDemo
//
//  Created by Pawel Milek on 25/06/2018.
//  Copyright © 2018 Pawel Milek. All rights reserved.
//

import UIKit

class ModeratorSearchViewController: UIViewController {
  @IBOutlet private var enterSiteNameTextField: UITextField!
  @IBOutlet private var searchButton: UIButton!
  
  private var behavior: ButtonEnablingBehavior?
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setupLayout()
  }
}


// MARK: - ViewSetupable protocol
extension ModeratorSearchViewController: ViewSetupable {
  
  func setup() {
    setTitle()
    setButtonBehavior()
    addHidingKeyboardTapGesture()
  }
  
  func setupLayout() {
    setTextFieldBottomShadow()
    setSearchButton()
  }
  
}


// MARK: - Private - Set title
private extension ModeratorSearchViewController {
  
  func setTitle() {
    title = "Stock Exchange Moderators"
  }
  
}


// MARK: - Private - Set button behavior
private extension ModeratorSearchViewController {
  
  func setButtonBehavior() {
    behavior = ButtonEnablingBehavior(textFields: [enterSiteNameTextField]) { [unowned self] enable in
      if enable {
        self.searchButton.isEnabled = true
        self.searchButton.alpha = 1
      } else {
        self.searchButton.isEnabled = false
        self.searchButton.alpha = 0.6
      }
    }
  }
  
}


// MARK: - Private - Add Tap Gesture
private extension ModeratorSearchViewController {
  
  func addHidingKeyboardTapGesture() {
    let singleTap = UITapGestureRecognizer(target: self, action: #selector(ModeratorSearchViewController.hideKeyboard))
    view.addGestureRecognizer(singleTap)
  }
  
  @objc func hideKeyboard() {
    view.endEditing(false)
  }
  
}


// MARK: - Set search button and text field
extension ModeratorSearchViewController {
  
  func setTextFieldBottomShadow() {
    enterSiteNameTextField.borderStyle = .none
    enterSiteNameTextField.layer.backgroundColor = UIColor.white.cgColor
    enterSiteNameTextField.layer.masksToBounds = false
    enterSiteNameTextField.layer.shadowColor = UIColor.mint.cgColor
    enterSiteNameTextField.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
    enterSiteNameTextField.layer.shadowOpacity = 1.0
    enterSiteNameTextField.layer.shadowRadius = 0.0
  }
  
  func setSearchButton() {
    searchButton.backgroundColor = .mint
    searchButton.layer.cornerRadius = searchButton.frame.size.height / 2
  }
  
}


// MARK: - Prepare for segue
extension ModeratorSearchViewController {
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard segue.identifier == SegueIdentifierType.showModeratorList.rawValue else { return }
    guard let destinationViewController = segue.destination as? ModeratorListViewController  else { return }
    
    destinationViewController.searchingSiteName = enterSiteNameTextField.text
  }
  
}
