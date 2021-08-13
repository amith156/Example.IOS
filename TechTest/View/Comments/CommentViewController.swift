//
//  CommentViewController.swift
//  TechTest
//
//  Created by Amith Narayan on 12/08/2021.
//

import Foundation
import UIKit

class CommentViewController : UIViewController  {
    
    @IBOutlet weak var tableView: UITableView!

    
    var commentObjArray : [Comments] = []
    
    var postId : Int!
        
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "CommentTableViewCell", bundle: nil), forCellReuseIdentifier: "commentCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.title = "Comments"
        
        Comments.getCommments(postID: postId) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let comment):
                    print("com => \(comment.count)")
                    self.commentObjArray = comment
                    self.tableView.reloadData()
                case .failure(let error):
                    print("====> \(error)")
                    break
                }
            }
        }
        
    }
    
}
extension CommentViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.commentObjArray.count
//        return i.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath) as? CommentTableViewCell {
            print("=====> \(indexPath.row)")
            cell.autherLable.text = self.commentObjArray[indexPath.row].name
            cell.bodyLable.text = self.commentObjArray[indexPath.row].body
//            cell.autherLable.text = i[1]
//            cell.bodyLable.text = i[1]
//            self.tableView.reloadData()
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}


