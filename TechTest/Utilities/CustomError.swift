//
//  CustomErrors.swift
//  TechTest
//
//  Created by Amith Narayan on 12/08/2021.
//

import Foundation
enum CustomError : Error {
    case badURLRequest(url: URL)
    case urlSessionError(error: Error)
    case badURL
    case unknow
}

extension CustomError : LocalizedError {
    public var errorDiscription : String {
        switch self {
        case .badURLRequest(url: let url):
            return "=====> [⛔️] Bad responce from URL: \(url)"
        
        case .urlSessionError(error: let error):
            return "=====> [⛔️] Bad responce from URLSession: \(error)"
            
        case .badURL:
            return "=====> [⚠️] bad url"
            
        case .unknow:
            return "=====> [⚠️] Unknown error"
        }
    }
}
