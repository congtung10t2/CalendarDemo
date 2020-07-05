//
//  WorkoutTableViewCell.swift
//  CalendarDemo
//
//  Created by tùng hoàng on 7/4/20.
//  Copyright © 2020 tung hoang. All rights reserved.
//

import UIKit
fileprivate struct Constant {
  static let purpleColor = UIColor(red: 0.455, green: 0.439, blue: 0.937, alpha: 1)
  static let normalDayInWeekColor = UIColor(red: 0.482, green: 0.494, blue: 0.569, alpha: 1)
  static let normalDayColor = UIColor(red: 0.118, green: 0.039, blue: 0.235, alpha: 1)
}
enum TodayStatus {
  case past
  case current
  case future
}
class WorkoutTableViewCell: UITableViewCell {
  @IBOutlet weak var exerciseTableView: UITableView!
  @IBOutlet weak var dayLabel: UILabel!
  @IBOutlet weak var dayInWeekLabel: UILabel!
  var day: Day?
  var statusToday: TodayStatus = .current
  var indexPath: Int = 0
  
  func setupView() {
    exerciseTableView.register(ExerciseTableViewCell.self)
    exerciseTableView.delegate = self
    exerciseTableView.dataSource = self
  }
  func load(day: Day, indexPath: Int) {
    self.day = day
    exerciseTableView.reloadData()
    updateConstraints()
    load(indexPath: indexPath)
  }
  
  func load(indexPath: Int) {
    self.indexPath = indexPath
    let monday = Date().getCurrentMonday()
    let indexDay = monday.getDay(from: indexPath)
    let calendar = NSCalendar.current
    let dayComponent = calendar.component(.day, from: indexDay)
    let todayComponent = calendar.component(.day, from: Date())
    if todayComponent == dayComponent {
      statusToday = .current
      dayInWeekLabel.textColor = Constant.purpleColor
      dayLabel.textColor = Constant.purpleColor
    } else {
      if  Date() > indexDay {
        statusToday = .past
      } else {
        statusToday = .future
      }
      dayInWeekLabel.textColor =  Constant.normalDayInWeekColor
      dayLabel.textColor =  Constant.normalDayColor
    }
    dayLabel.text = "\(dayComponent)"
    dayInWeekLabel.text = Weekdays(rawValue: indexPath)?.description
    
  }
  
  override func awakeFromNib() {
      super.awakeFromNib()
      setupView()
  }
  
}
extension WorkoutTableViewCell: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: ExerciseTableViewCell = tableView.dequeueReusableCell(for: indexPath)
    if let assignment = day?.assignments[indexPath.section] {
      cell.load(assignment: assignment, statusToday: statusToday)
    }
    cell.layoutIfNeeded()
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let cell = tableView.cellForRow(at: indexPath) as? ExerciseTableViewCell else {
      return
    }
    cell.tapSelect()
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    
    return day?.assignments.count ?? 0
  }
  
  // There is just one row in every section
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
  {
    let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 8))
    
    headerView.backgroundColor = .clear
    
    return headerView
  }
  
  // Set the spacing between sections
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 8
  }
}
