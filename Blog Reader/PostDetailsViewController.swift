//
//  PostDetailsViewController.swift
//  Blog Reader
//
//  Created by Vinay Reddy Polati on 9/21/17.
//  Copyright © 2017 m1m2Solutions. All rights reserved.
//

import UIKit;
import WebKit;

class PostDetailsViewController: UIViewController {
    var postTitle:String?;
    var htmlContent:String?;
    
    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var webview: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let c1 = self.postTitle {
            if let c2 = self.htmlContent {
                postTitleLabel.text = c1;
                print("content is :\n \(c2)");
                webview.loadHTMLString(c2, baseURL: nil)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
