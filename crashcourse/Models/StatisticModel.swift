//
//  StatisticModel.swift
//  crashcourse
//
//  Created by Egemen Öngel on 21.05.2024.
//

import Foundation

struct StatisticModel: Identifiable{
    let id = UUID().uuidString
    let title: String
    let value: Double
    let percentageChange: Double?

    init(title: String, value:Double, percentageChange: Double? = nil){
        self.title = title
        self.value = value
        self.percentageChange = percentageChange
    }
}
