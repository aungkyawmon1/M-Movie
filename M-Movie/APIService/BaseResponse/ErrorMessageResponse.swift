//
//  ErrorMessageResponse.swift
//  M-Movie
//
//  Created by Aung Kyaw Mon on 12/10/2567 BE.
//

import Foundation

struct ErrorMessageResponse: Codable {
    let status : Int?
    let message : String?
    
    enum CodingKeys : String , CodingKey {
        case status
        case message
    }
}

