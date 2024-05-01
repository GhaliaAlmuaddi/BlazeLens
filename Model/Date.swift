//
//  Date.swift
//  CloudKidGameCenterTest
//
//  Created by Ghalia Mohammed Al Muaddi on 21/10/1445 AH.
//

import Foundation

struct MyDateFormatter {
    
    static func getCurrentFormattedDate() -> String {
        // Get the current date
        let currentDate = Date()

        // Create a date formatter
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy, hh:mm:ss.SS a 'UTC'"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")

        // Format the date to string
        let formattedDate = dateFormatter.string(from: currentDate)

        return formattedDate
    }
}

// Usage
let formattedDate = MyDateFormatter.getCurrentFormattedDate()


