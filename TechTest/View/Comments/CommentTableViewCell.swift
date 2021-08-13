//
//  CommentTableViewCell.swift
//  TechTest
//
//  Created by Amith Narayan on 12/08/2021.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    @IBOutlet weak var autherLable: UILabel!
    @IBOutlet weak var bodyLable: UILabel!
    
    func config(comment : Comments) {
        autherLable.text = comment.name
        bodyLable.text = comment.body
    }
    
}
