//
//  ModeratorListViewController.swift
//  InfiniteScrollingPrefetchingAPIDemo
//
//  Created by Pawel Milek on 25/06/2018.
//  Copyright © 2018 Pawel Milek. All rights reserved.
//

import UIKit

class ModeratorListViewController: UIViewController {
  @IBOutlet var tableView: UITableView!
  
  private let activityIndicatorShared = ActivityIndicator.shared
  private var moderators: [Moderator]? {
    didSet {
      tableView.reloadData()
    }
  }
  
  private var currentPage = 1
  private var total = 0
  var searchingSiteName: String!
  
//  private weak var delegate: ModeratorsViewModelDelegate?
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
    getModerators()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setupLayout()
  }
  
}


// MARK: - Private - getModerators
private extension ModeratorListViewController {
  
  func getModerators() {
    activityIndicatorShared.startAnimating(at: view)
    
    let request = ModeratorRequest.make(from: searchingSiteName)
    WebService.shared.fetch(ModeratorResponse.self, with: request) { [weak self] response in
      switch response {
      case .success(let data):
        DispatchQueue.main.async {
          self?.moderators = data.moderators
        }
        
        
      case .failure(let error):
        error.handle()
      }
      
      self?.activityIndicatorShared.stopAnimating()
    }
  }
  
}


// MARK: - Private -
private extension ModeratorListViewController {
  
}


// MARK: - Private -
private extension ModeratorListViewController {
  
}


// MARK: - ViewSetupable protocol
extension ModeratorListViewController: ViewSetupable {
  
  func setup() {
    let nibName = ModeratorTableViewCell.reuseIdentifier
    let nib = UINib(nibName: nibName, bundle: nil)
    tableView.register(nib, forCellReuseIdentifier: nibName)
    tableView.dataSource = self
    tableView.delegate = self
    tableView.tableFooterView = UIView()
  }
  
  func setupLayout() {
    title = searchingSiteName ?? nil
  }
  
}


// MARK: - UITableViewDataSource protocol
extension ModeratorListViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return moderators?.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let moderators = moderators else { return UITableViewCell() }
    guard let cell = tableView.dequeueReusableCell(withIdentifier: ModeratorTableViewCell.reuseIdentifier, for: indexPath) as? ModeratorTableViewCell else { return UITableViewCell() }
    
    let moderatorItem = moderators[indexPath.row]
    cell.configure(with: moderatorItem)
    
    return cell
  }
  
}


// MARK: - UITableViewDelegate protocol
extension ModeratorListViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print("\(indexPath.row)")
  }
  
}
