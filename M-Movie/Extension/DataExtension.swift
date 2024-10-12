//
//  DataExtension.swift
//  M-Movie
//
//  Created by Aung Kyaw Mon on 12/10/2567 BE.
//

import Foundation

extension Data {
    func decode<T>(modelType: T.Type) -> T? where T : Decodable{
        let decoder = JSONDecoder()
        do {
            let result = try decoder.decode(modelType, from: self)
            return result
        } catch let jsonError{
            print("an error occur while decoding . . . \(jsonError.localizedDescription) >>>>> \(modelType)")
            return nil
        }
    }
}
