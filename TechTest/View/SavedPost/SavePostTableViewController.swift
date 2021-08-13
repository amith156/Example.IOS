//
//  SavePostTableViewController.swift
//  TechTest
//
//  Created by Amith Narayan on 12/08/2021.
//

import Foundation
import UIKit

class SavePostTableViewController: UIViewController {
    
    
    @IBOutlet var saveTableView: UITableView!
    private var savedPosts: [Post] = []
    var coreDataManagerHelper : CoreDataManagerHelper = CoreDataManagerHelper()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        coreDataManagerHelper.fetchSetupAllItems()
        saveTableView.register(UINib(nibName: "PostTableViewCell", bundle: nil), forCellReuseIdentifier: "SavedCell")
        title = "Saved Post"
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        coreDataManagerHelper.fetchSetupAllItems()
        saveTableView.reloadData()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        coreDataManagerHelper.fetchSetupAllItems()
        self.savedPosts = []
        coreDataManagerHelper.postArrayList.forEach { item in
            self.savedPosts.append(Post(id: item.primitiveValue(forKey: "id") as! Int, title: item.primitiveValue(forKey: "title") as! String, body: item.primitiveValue(forKey: "body")as! String))
            
        }
        
        saveTableView.reloadData()
        
    }
    
    
}

extension SavePostTableViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedPosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SavedCell", for: indexPath) as! PostTableViewCell
        let post = savedPosts[indexPath.row]

        cell.configure(with: post)
        cell.accessoryType = .disclosureIndicator

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = savedPosts[indexPath.row]
        let detailsViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PostDetailsViewController") as! PostDetailsViewController
        detailsViewController.postID = post.id
        navigationController?.pushViewController(detailsViewController, animated: true)
    }
    
    
}
extension SavePostTableViewController {
    
    func setUpNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(saveTableViewDataSource), name: NSNotification.Name("PostData"), object: nil)
    }
    
    
    @objc func saveTableViewDataSource() {
        print("Saving selector pressed")
    }
    
    
}
