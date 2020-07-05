//
//  AssignmentModel.swift
//  CalendarModel
//
//  Created by tùng hoàng on 7/4/20.
//  Copyright © 2020 tung hoang. All rights reserved.
//

import Foundation
struct Day: Decodable {
  let id: String
  let assignments: [AssignmentModel]
  let day: Int
  private enum CodingKeys : String, CodingKey {
      case assignments, id = "_id", day
  }
}
struct AssignmentModel: Decodable {
  let title: String
  let id: String
  let status: StatusModel
  let totalExercise: Int
  private enum CodingKeys : String, CodingKey {
      case title, id = "_id", status, totalExercise
  }
}
struct WorkoutData: Decodable {
  let data: [Day]
}
enum ResponseCase {
  case success([Day])
  case failure(Error)
}
enum StatusModel: Int, Decodable {
  case assign
  case inprogress
  case complete
}
