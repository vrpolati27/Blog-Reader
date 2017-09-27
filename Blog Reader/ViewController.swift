//
//  ViewController.swift
//  Blog Reader
//
//  Created by Vinay Reddy Polati on 9/21/17.
//  Copyright © 2017 m1m2Solutions. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var posts:[String:String] = [:];
    
    @IBOutlet weak var blogIdTextField: UITextField!
    @IBOutlet weak var headingTextLabel: UILabel!
    @IBOutlet weak var postsTableView: UITableView!
    
    @IBAction func getPostsButtonAction(_ sender: Any) {
        if let blogIdString = blogIdTextField.text  {
            if let blogId = Int(blogIdString) {
                retrievePosts(with: String(blogId));
            }
        }
    }
    
    private func retrievePosts(with blogId:String) {
        let url = URL(string: "https://www.googleapis.com/blogger/v3/blogs/\(blogId)/posts?key=AIzaSyDYZg7ksIqEI-z2aQzf6VxjyiNNhCe9pJs")! ;
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(" Error getting posts");
            } else {
                if let content = data {
                    do {
                        if let jsonResult:NSDictionary = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                            if let _posts:NSArray = jsonResult["items"]  as? NSArray {
                                for _post in _posts  {
                                    if let item:NSDictionary = _post as? NSDictionary {
                                        self.posts[item["title"] as! String] = item["content"] as! String;
                                        print("congrats! posts updated. ")
                                    }
                                }
                                DispatchQueue.main.async(execute: {
                                    self.postsTableView.reloadData();
                                })
                            }
                        }
                    } catch {
                        print(" Json processing error. ");
                    }
                }
            }
        }
        
        task.resume();
        
        
    }
    
    // MARK: TableView methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let postcell = tableView.dequeueReusableCell(withIdentifier: "postcell") as! PostCellViewController;
        postcell.postTitleLabel.text = Array(posts.keys)[indexPath.row];
        return postcell;
    }
    
    // Mark: overriden functions
    override func viewDidLoad() {
        super.viewDidLoad()
        /*posts["post1"] = "Topic1";*/
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "postToDetails" {
            if let detailsViewController = segue.destination as? PostDetailsViewController {
                let _postTitle1:String = Array(posts.keys)[self.postsTableView.indexPathForSelectedRow!.row];
                detailsViewController.postTitle = _postTitle1;
                detailsViewController.htmlContent = posts[_postTitle1];
            }
        }
    }

}

