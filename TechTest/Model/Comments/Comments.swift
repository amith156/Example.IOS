//
//  Comments.swift
//  TechTest
//
//  Created by Amith Narayan on 12/08/2021.
//

import Foundation
struct Comments : Codable, Equatable {
    let postId : Int
    let id : Int
    let name : String
    let email : String
    let body : String
}
extension Comments {
    static func getCommments(postID: Int, completion: @escaping (Result<[Comments], Error>) -> Void) {
        let url = URL(string: URLComponents().getQuotesURL!.absoluteString+"\(postID)/comments")!
        print(url)
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard error == nil else {
                completion(.failure(error!))
                return
            }

            do {
                let data = data ?? Data()
                let comments = try JSONDecoder().decode([Comments].self, from: data)
                completion(.success(comments))
            } catch {
                completion(.failure(error))
            }
        }

        task.resume()
    }
}
