//
// Created by Alex Jackson on 01/03/2021.
//

import Foundation

extension Post {
    static func loadAll(_ completion: @escaping (Result<[Post], Error>) -> Void) {
        guard let url = URL(string: URLComponents().getQuotesURL!.absoluteString) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard error == nil else {
                completion(.failure(error!))
                return
            }

            do {
                let data = data ?? Data()
                let posts = try JSONDecoder().decode([Post].self, from: data)
                completion(.success(posts))
            } catch {
                completion(.failure(error))
            }
        }

        task.resume()
    }

    static func loadPost(withID postID: Int, completion: @escaping (Result<Post, Error>) -> Void) {
        let url = URL(string: URLComponents().getQuotesURL!.absoluteString+"\(postID)")!
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
//            guard error == nil else {
//
//                completion(.failure(error!))
//                return
//            }
            
            
            

            if let error = error as? URLError {
                switch error.code {
                case .notConnectedToInternet:
                    let coreDataManagerHelper = CoreDataManagerHelper()
                    coreDataManagerHelper.fetchSetupAllItems()
                    coreDataManagerHelper.postArrayList.forEach { ele in
                        if ((ele.primitiveValue(forKey: "id") as! Int) == postID) {
                            completion(.success(Post(id: postID, title: (ele.primitiveValue(forKey: "title") as! String), body: (ele.primitiveValue(forKey: "body") as! String))))
                        }
                    }
                    print("************************************")
                case .networkConnectionLost:
                    print("------------------------------------")

                default:

                    print("nothing")
                }
            }
            
            
            
            do {
                let data = data ?? Data()
                let post = try JSONDecoder().decode(Post.self, from: data)
                completion(.success(post))
            } catch {
                completion(.failure(error))
            }
        }

        task.resume()
    }
}
