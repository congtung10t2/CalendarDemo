//
//  ViewController.swift
//  CalendarDemo
//
//  Created by tùng hoàng on 7/4/20.
//  Copyright © 2020 tung hoang. All rights reserved.
//

import UIKit

protocol InputMainViewProtocol {
  var data: [Day] { get set}
}
class InputViewModel: InputMainViewProtocol {
  var data: [Day] = []
}
class MainViewController: UIViewController {
  var workoutApi: ServiceProtocol?
  var input: InputMainViewProtocol = InputViewModel()
  @IBOutlet weak var workoutTableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    self.requestApi()
    
  }
  //MARK: setup UI
  func setupUI() {
    workoutTableView.register(WorkoutTableViewCell.self)
    workoutTableView.dataSource = self
    workoutTableView.delegate = self
    workoutTableView.reloadData()
  }
  //MARK: request API
  func requestApi() {
    workoutApi = Service(url: AppConfig.apiUrl)
    workoutApi?.request(path: AppConfig.apiPath) {[weak self] result in
      guard let self = self else { return }
      switch result {
      case .success(let data):
        self.input.data = data
        self.workoutTableView.reloadData()
     //   print(data)
      case .failure(let error):
        print(error)
      }
    }
  }
}
extension MainViewController: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return input.data.count > 0 ? input.data.count : 7
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell: WorkoutTableViewCell = tableView.dequeueReusableCell(for: indexPath)
    if let cellData = input.data.get(indexPath.row) {
      cell.load(day: cellData, indexPath: indexPath.row)
    } else {
      cell.load(indexPath: indexPath.row)
    }
    cell.layoutIfNeeded()
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if let cellData = input.data.get(indexPath.row) {
      return CGFloat(max(112, 112 + (cellData.assignments.count - 1) * 80))
    }
    return 112
  }
}
