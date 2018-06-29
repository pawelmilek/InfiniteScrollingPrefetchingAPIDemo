//
//  ModeratorListViewController.swift
//  InfiniteScrollingPrefetchingAPIDemo
//
//  Created by Pawel Milek on 25/06/2018.
//  Copyright © 2018 Pawel Milek. All rights reserved.
//

import UIKit

class ModeratorListViewController: UIViewController {
  @IBOutlet private var tableView: UITableView!
  
  private let activityIndicatorShared = ActivityIndicator.shared
  private var moderators: [Moderator] = []
  private var currentPage = 1
  private var totalCountOfModerators = 0
  private var isFetchInProgress = false
  var searchingSiteName: String!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
    activityIndicatorShared.startAnimating(at: view)
    getModerators()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setupLayout()
  }
  
}


// MARK: - ViewSetupable protocol
extension ModeratorListViewController: ViewSetupable {
  
  func setup() {
    let nibName = ModeratorTableViewCell.reuseIdentifier
    let nib = UINib(nibName: nibName, bundle: nil)
    tableView.register(nib, forCellReuseIdentifier: nibName)
    
    tableView.dataSource = self
    tableView.delegate = self
    tableView.prefetchDataSource = self
    tableView.allowsSelection = false
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 80
    tableView.separatorColor = .mint
    tableView.tableFooterView = UIView()
  }
  
  func setupLayout() {
    title = searchingSiteName ?? nil
  }
  
}


// MARK: - Private - getModerators
private extension ModeratorListViewController {
  
  func getModerators() {
    guard !isFetchInProgress else { return }

    isFetchInProgress = true
    
    let request = ModeratorRequest.make(from: searchingSiteName, at: currentPage)
    WebService.shared.fetch(ModeratorResponse.self, with: request) { [weak self] response in
      switch response {
      case .success(let data):
        DispatchQueue.main.async {
          self?.isFetchInProgress = false
          self?.currentPage += 1
          self?.totalCountOfModerators = data.total
          self?.moderators.append(contentsOf: data.moderators)
          
          if data.page > 1 {
            let indexPathsToReload = self?.calculateIndexPathsToReload(from: data.moderators)
            self?.fetchDidComplete(with: indexPathsToReload)
          } else {
            self?.fetchDidComplete()
          }
        }
        
      case .failure(let error):
        DispatchQueue.main.async {
          self?.fetchDidFail(with: error)
          self?.isFetchInProgress = false
        }
      }
    }
  }
  
}


// MARK: - Private - Fetch completion handlers
private extension ModeratorListViewController {
  
  func fetchDidComplete(with newIndexPathsToReload: [IndexPath]? = .none) {
    if let newIndexPathsToReload = newIndexPathsToReload {
      let indexPathsToReload = visibleIndexPathsToReload(intersecting: newIndexPathsToReload)
//      tableView.beginUpdates()
      tableView.reloadRows(at: indexPathsToReload, with: .none)
//      tableView.endUpdates()
      
    } else {
      activityIndicatorShared.stopAnimating()
      tableView.reloadData()
    }
  }
  
  func fetchDidFail(with error: ErrorHandleable) {
    activityIndicatorShared.stopAnimating()
    error.handle()
  }
}


// MARK: - Private - Calculate new indexPaths to reload
private extension ModeratorListViewController {
  
  func calculateIndexPathsToReload(from newModerators: [Moderator]) -> [IndexPath] {
    let startIndex = moderators.count - newModerators.count
    let endIndex = startIndex + newModerators.count
    
    let indexPathsToReload = (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    return indexPathsToReload
  }
}


// MARK: - UITableViewDataSource protocol
extension ModeratorListViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return totalCountOfModerators
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: ModeratorTableViewCell.reuseIdentifier, for: indexPath) as? ModeratorTableViewCell else { return UITableViewCell() }
    
    if isLoadingCell(for: indexPath) {
      cell.configure(with: .none)
    } else {
      let moderatorItem = moderators[indexPath.row]
      cell.configure(with: moderatorItem)
    }
    
    return cell
  }
  
}


// MARK: - UITableViewDelegate protocol
extension ModeratorListViewController: UITableViewDelegate {

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 80
  }
  
}


// MARK: - UITableViewDataSourcePrefetching protocol
extension ModeratorListViewController: UITableViewDataSourcePrefetching {
  
  func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
    if indexPaths.contains(where: isLoadingCell) {
      getModerators()
    }
  }
  
}


// MARK: - Private - Check visible IndexPaths to reload
private extension ModeratorListViewController {
  
  func isLoadingCell(for indexPath: IndexPath) -> Bool {
    return indexPath.row >= moderators.count
  }
  
  func visibleIndexPathsToReload(intersecting indexPaths: [IndexPath]) -> [IndexPath] {
    let indexPathsForVisibleRows = tableView.indexPathsForVisibleRows ?? []
    let indexPathsIntersection = Set(indexPathsForVisibleRows).intersection(indexPaths)
    
    return Array(indexPathsIntersection)
  }
  
}
