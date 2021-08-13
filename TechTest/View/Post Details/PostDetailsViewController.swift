//
// Created by Alex Jackson on 01/03/2021.
//

import Foundation
import UIKit

final class PostDetailsViewController: UIViewController {

    // MARK: - Properties

    var postID: Int!
    private var loadedPost: Post?
    
    private var isSelectedBookmark = false
    private var bookmarkList : [Int] = []
    
    private var items = [UIBarButtonItem]()
    
    var coreDataManagerHelper : CoreDataManagerHelper = CoreDataManagerHelper()

    var favoritesBarButtonOn : UIBarButtonItem!
    var favoritesBarButtonOFF : UIBarButtonItem!
    
    @IBOutlet private(set) var titleLabel: UILabel!
    @IBOutlet private(set) var bodyLabel: UILabel!
    @IBOutlet private(set) var activityIndicator: UIActivityIndicatorView!

    
    
    override func viewDidLoad() {
        coreDataManagerHelper.fetchSetupAllItems()
        coreDataManagerHelper.postArrayList.forEach { x in
            bookmarkList.append(x.primitiveValue(forKey: "id") as! Int)
            
        }
        
        
    }
    
    
    
    // MARK: - UIViewController Overrides

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        
        
        
        if loadedPost == nil {
            activityIndicator.startAnimating()
            title = "Loading…"
            
            
            favoritesBarButtonOn = UIBarButtonItem(image: UIImage(systemName: "bookmark.fill"), style: .plain, target: self, action: #selector(didTapFavoritesBarButtonOn))
            favoritesBarButtonOFF = UIBarButtonItem(image:  UIImage(systemName: "bookmark"), style: .plain, target: self, action: #selector(didTapFavoritesBarButtonOFF))
            

            self.navigationItem.rightBarButtonItems = [self.favoritesBarButtonOFF]
            
            
            
            
            
            Post.loadPost(withID: postID) { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let post):
                        self?.loadedPost = post
                        self?.title = "Your Post"
                        self?.titleLabel.text = post.title
                        self?.bodyLabel.text = post.body
                        self?.checkingBookmark()
                    case .failure:
                        break
                    }

                    self?.activityIndicator.stopAnimating()
                }
            }
        }
    }
    
    func checkingBookmark() {
        if bookmarkList.contains(self.loadedPost!.id) {
            self.navigationItem.rightBarButtonItems = [self.favoritesBarButtonOn]
        }
        else {
            self.navigationItem.rightBarButtonItems = [self.favoritesBarButtonOFF]
        }
    }
    
    
    
    @objc func didTapFavoritesBarButtonOn() {
        self.navigationItem.setRightBarButtonItems([self.favoritesBarButtonOFF], animated: true)
        //write delete func
        print("===>of")
        isSelectedBookmark = false
        var forCount = 0
        var realIndex = 0
        coreDataManagerHelper.postArrayList.forEach { obj in
            
            if((obj.value(forKey: "id") as! Int) == self.loadedPost?.id) {
                realIndex = forCount
                
            }
            forCount = forCount + 1
        }
        
        
        
        coreDataManagerHelper.delete(postListEntity: coreDataManagerHelper.postArrayList[realIndex] as! PostListEntity)
    }

    @objc func didTapFavoritesBarButtonOFF() {
        self.navigationItem.setRightBarButtonItems([self.favoritesBarButtonOn], animated: true)
        //write save fuctionalities
        print("===>on")
        isSelectedBookmark = true
        coreDataManagerHelper.insertNewData(itemName: loadedPost!)
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is CommentViewController {
            let vc = segue.destination as? CommentViewController
            vc?.postId = self.postID
        }
    }
    
    
}
