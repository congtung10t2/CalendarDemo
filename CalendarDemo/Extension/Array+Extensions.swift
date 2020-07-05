//
//  Array+Extensions.swift
//  CalendarDemo
//
//  Created by tùng hoàng on 7/5/20.
//  Copyright © 2020 tung hoang. All rights reserved.
//
extension Array {
    func get(_ index: Int) -> Element? {
        return (index >= 0 && index < self.count) ? self[index] : nil
    }
}
