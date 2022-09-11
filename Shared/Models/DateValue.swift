//
//  DateValue.swift
//  NoteApp
//
//  Created by Eloo on 05/09/2022.
//

import Foundation
                        
struct DateValue: Identifiable {
    let id = UUID().uuidString
    var day: Int
    var date: Date
    
}
