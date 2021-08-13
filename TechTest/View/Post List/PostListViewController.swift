//
// Created by Alex Jackson on 01/03/2021.
//

import Foundation
import UIKit

protocol PostListViewing: AnyObject {
    func display(_ posts: [Post])
}

final class PostListViewController: UITableViewController, PostListViewing {

    // MARK: - Properties

    private static let cellIdentifier = "Cell"

    private let interactor = PostListInteractor()
    private var displayedPosts: [Post] = []
    
    var savePostData : [Int : Post] = [:]

    
    // MARK: - UIViewController Overrides

    override func viewDidLoad() {
        super.viewDidLoad()

        interactor.view = self
        tableView.register(UINib(nibName: "PostTableViewCell", bundle: nil), forCellReuseIdentifier: Self.cellIdentifier)
        title = "All Posts"
        loadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        interactor.fetchAllPosts()
    }

    // MARK: - Public Methods

    func display(_ posts: [Post]) {
        displayedPosts = posts
        tableView.reloadData()
    }

    // MARK: - Table View Methods

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        displayedPosts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Self.cellIdentifier, for: indexPath) as! PostTableViewCell
        let post = displayedPosts[indexPath.row]

        cell.configure(with: post)
        cell.accessoryType = .disclosureIndicator

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = displayedPosts[indexPath.row]
        let detailsViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PostDetailsViewController") as! PostDetailsViewController
        detailsViewController.postID = post.id
        navigationController?.pushViewController(detailsViewController, animated: true)
    }
    
    
    func loadData() -> [Int:Post] {
        let decoder = JSONDecoder()
        if let data = UserDefaults.standard.data(forKey: "PostData") {
            do {
                return try decoder.decode(Dictionary<Int, Post>.self, from: data)
            } catch {
                print("\(error)")
            }
        }
        return [1:Post(id: 1, title: "Hello", body: "Testing data")]
    }
    
    func storeData(data: [Int:Post]) -> Bool {
        
        let encoder = JSONEncoder()
        
        if let encoder = try? encoder.encode(data) {
            UserDefaults.standard.set(encoder, forKey: "PostData")
            return true
        }
        
        return false
    }
    
    
    
    
}
