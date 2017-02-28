//
//  LoginViewController.swift
//  Twitterly
//
//  Created by Kinshuk Juneja on 2/27/17.
//  Copyright © 2017 CS490. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func onLoginButton(_ sender: UIButton) {
        
        let twitterClient = BDBOAuth1SessionManager(baseURL: NSURL(string: "https://api.twitter.com")! as URL!, consumerKey: "8kY9ITr1Wg2rHqqo2Kgc7ySMZ", consumerSecret: "kUHtWHVtdrPchLyzJZuImRg8y3l64t1QUw6VzvkjRd9ml8D0gD")
        
        twitterClient?.deauthorize()
        twitterClient?.fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: NSURL(string : "twitterdemo://oauth") as URL!, scope: nil, success: { ( requestToken: BDBOAuth1Credential?) -> Void in

            
            let url = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken!.token!)")!
            
            UIApplication.shared.open(url as URL, completionHandler: { (true) in
                print("Got a toked")
            })
            print("Got a toked")
            
            
            
            
        }, failure: { (error: Error?) -> Void in
            print("error : \(error!.localizedDescription)")
        })
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
