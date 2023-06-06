//
//  DateFormated.swift
//  Steamgames
//
//  Created by Rodomil on 29.05.2023.
//

import Foundation

extension Date {
    static func timeIntervalConvertString(time: Double) -> String {
        let date = NSDate(timeIntervalSince1970: time)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd YYYY hh:mm a"
        return dateFormatter.string(from: date as Date)
    }
}
