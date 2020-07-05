//
//  ViewController.swift
//  CalendarDemo
//
//  Created by tùng hoàng on 7/4/20.
//  Copyright © 2020 tung hoang. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
  var workoutApi: ServiceProtocol = Service(url: "https://demo2187508.mockable.io/")

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    workoutApi.request(path: "workouts") { result in
      switch result {
      case .success(let data):
        print(data)
      case .failure(let error):
        print(error)
      }
    }
  }
}

