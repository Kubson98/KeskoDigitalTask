//
//  String+Extension.swift
//  KeskoSenukaiDigitalTask
//
//  Created by Jakub Sędal on 11/04/2024.
//

import Foundation

extension String {
    func formatedDate() -> String? {
        let inputFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let outputFormat = "MMMM dd, yyyy"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = inputFormat
        
        if let date = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = outputFormat
            let formattedString = dateFormatter.string(from: date)
            return formattedString
        } else {
            return nil
        }
    }
}
