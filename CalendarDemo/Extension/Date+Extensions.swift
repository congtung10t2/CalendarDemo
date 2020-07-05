//
//  Date+Extensions.swift
//  CalendarDemo
//
//  Created by tùng hoàng on 7/5/20.
//  Copyright © 2020 tung hoang. All rights reserved.
//

import Foundation
extension Date {
  func getDay(from number: Int) -> Date {
    return Calendar.current.date(byAdding: .day, value: number, to: self) ?? self
  }
  func isSunday() -> Bool {
    let today = Calendar.current.dateComponents([.weekday], from: Date()).weekday
    return today == 1
  }
  
  func getCurrentMonday() -> Date {
      if isSunday() {
        return getPreviousMonthDay()
      }
      let cal = Calendar.current
      var comps = cal.dateComponents([.weekOfYear, .yearForWeekOfYear], from: self)
      comps.weekday = 2 // Monday
      let mondayInWeek = cal.date(from: comps)!
      return mondayInWeek
  }
  func getPreviousMonthDay() -> Date {
    return Date.today().previous(.monday)
  }
}
fileprivate extension Date {

  static func today() -> Date {
      return Date()
  }

  func next(_ weekday: Weekday, considerToday: Bool = false) -> Date {
    return get(.next,
               weekday,
               considerToday: considerToday)
  }

  func previous(_ weekday: Weekday, considerToday: Bool = false) -> Date {
    return get(.previous,
               weekday,
               considerToday: considerToday)
  }

  func get(_ direction: SearchDirection,
           _ weekDay: Weekday,
           considerToday consider: Bool = false) -> Date {

    let dayName = weekDay.rawValue

    let weekdaysName = getWeekDaysInEnglish().map { $0.lowercased() }

    assert(weekdaysName.contains(dayName), "weekday symbol should be in form \(weekdaysName)")

    let searchWeekdayIndex = weekdaysName.firstIndex(of: dayName)! + 1

    let calendar = Calendar(identifier: .gregorian)

    if consider && calendar.component(.weekday, from: self) == searchWeekdayIndex {
      return self
    }

    var nextDateComponent = calendar.dateComponents([.hour, .minute, .second], from: self)
    nextDateComponent.weekday = searchWeekdayIndex

    let date = calendar.nextDate(after: self,
                                 matching: nextDateComponent,
                                 matchingPolicy: .nextTime,
                                 direction: direction.calendarSearchDirection)

    return date!
  }

}

// MARK: Helper methods
fileprivate extension Date {
  func getWeekDaysInEnglish() -> [String] {
    var calendar = Calendar(identifier: .gregorian)
    calendar.locale = Locale(identifier: "en_US_POSIX")
    return calendar.weekdaySymbols
  }

  enum Weekday: String {
    case monday, tuesday, wednesday, thursday, friday, saturday, sunday
  }

  enum SearchDirection {
    case next
    case previous

    var calendarSearchDirection: Calendar.SearchDirection {
      switch self {
      case .next:
        return .forward
      case .previous:
        return .backward
      }
    }
  }
}
