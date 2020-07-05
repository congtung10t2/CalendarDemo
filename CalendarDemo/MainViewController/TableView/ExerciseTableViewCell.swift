//
//  ExerciseTableViewCell.swift
//  CalendarDemo
//
//  Created by tùng hoàng on 7/4/20.
//  Copyright © 2020 tung hoang. All rights reserved.
//

import UIKit
fileprivate struct Constant {
  static let selectedColor = UIColor(red: 0.455, green: 0.439, blue: 0.937, alpha: 1)
  static let unSelectedColor = UIColor(red: 0.969, green: 0.973, blue: 0.988, alpha: 1)
  static let unSelectedTextColor = UIColor(red: 0.118, green: 0.039, blue: 0.235, alpha: 1)
  static let futureColor = UIColor(red: 0.482, green: 0.494, blue: 0.569, alpha: 1)
  static let missedText = "Missed"
}
class ExerciseTableViewCell: UITableViewCell {
  @IBOutlet weak var activityLabel: UILabel!
  @IBOutlet weak var statusLabel: UILabel!
  @IBOutlet weak var checkImage: UIImageView!
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  func load(assignment: AssignmentModel, statusToday: TodayStatus) {
    checkImage.isHidden = true

    statusLabel.text = "\(assignment.totalExercise) exercises"
    switch assignment.status {
    case .complete:
      self.contentView.backgroundColor = Constant.selectedColor
      activityLabel.textColor = .white
      statusLabel.textColor = .white
    case .assign, .inprogress:
      self.contentView.backgroundColor = Constant.unSelectedColor
      activityLabel.textColor = Constant.unSelectedTextColor
      statusLabel.textColor = Constant.unSelectedTextColor
      if statusToday == .past {
        setTextForMissed(assignment: assignment)
      } else {
        if statusToday == .future {
          activityLabel.textColor = Constant.futureColor
          statusLabel.textColor = Constant.futureColor
        }
      }
    }
    activityLabel.text = assignment.title
  }
  
  func tapSelect() {
    checkImage.isHidden = !checkImage.isHidden
  }
  
  func setTextForMissed(assignment: AssignmentModel) {
    let content = "\(Constant.missedText) . \(assignment.totalExercise) exercises"
    var myMutableString = NSMutableAttributedString()
    myMutableString = NSMutableAttributedString(string: content, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13)])
    
    myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: NSRange(location: 0, length: Constant.missedText.count))
    // set label Attribute
    statusLabel.attributedText = myMutableString
  }
}
