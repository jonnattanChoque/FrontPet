//
//  ValidationsHelper.swift
//  FrontPet
//
//  Created by jonnattan Choque on 28/10/21.
//

import Foundation


class ValidationHelpers {
    
    static func isValidDate(dateString: String) -> Bool {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "dd/MM/yyyy"
        if let _ = dateFormatterGet.date(from: dateString) {
            return true
        } else {
            return false
        }
    }
}
