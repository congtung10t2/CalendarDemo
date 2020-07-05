//
//  AppConfig.swift
//  CalendarDemo
//
//  Created by tùng hoàng on 7/5/20.
//  Copyright © 2020 tung hoang. All rights reserved.
//

import Foundation
class AppConfig {
  static let apiUrl = "https://demo2187508.mockable.io/"
  static let apiPath = "workouts"
}
enum Weekdays: Int {
  case Mon
  case Tue
  case Wed
  case Thu
  case Fri
  case Sat
  case Sun
}
extension Weekdays {
  var description: String {
    switch self {
    case .Mon:
      return "MON"
    case .Tue:
      return "TUE"
    case .Wed:
      return "WED"
    case .Thu:
      return "THU"
    case .Fri:
      return "FRI"
    case .Sat:
      return "SAT"
    case .Sun:
      return "SUN"
    }
  }
}
