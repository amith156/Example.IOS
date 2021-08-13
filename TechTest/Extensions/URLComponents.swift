//
//  URLComponents.swift
//  TechTest
//
//  Created by Amith Narayan on 12/08/2021.
//

import Foundation

extension URLComponents {
    
    var getQuotesURL : URL? {
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "jsonplaceholder.typicode.com"
        components.path = "/posts/"

        
        return components.url
        
    }
    
    
    
}
