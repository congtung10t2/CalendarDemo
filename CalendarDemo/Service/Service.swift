//
//  Service.swift
//  CalendarDemo
//
//  Created by tùng hoàng on 7/4/20.
//  Copyright © 2020 tung hoang. All rights reserved.
//

import Foundation
import Alamofire
protocol ServiceProtocol {
  var url: String { get }
  func request(path: String, completion: @escaping (ResponseCase) -> ())
}
class Service: ServiceProtocol  {
  var url: String
  init(url: String) {
    self.url = url
  }
  
  func setUrl(url: String) {
    self.url = url
  }
  
  func request(path: String, completion: @escaping (ResponseCase) -> ()) {
    AF.request(url + path, parameters: nil).responseJSON { response in
      let decoder = JSONDecoder()
      decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
          guard let data = response.data else {
            completion(.failure(NSError(domain: "com.example.everfit", code: 1, userInfo: ["message": "data nil"])))
            return
          }
          let workout = try decoder.decode(WorkoutData.self, from: data)
          completion(.success(workout.data))
        } catch {
          print(error)
          completion(.failure(error))
        }
      }
    }
}
