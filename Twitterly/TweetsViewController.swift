//
//  TweetsViewController.swift
//  Twitterly
//
//  Created by Kinshuk Juneja on 2/28/17.
//  Copyright © 2017 CS490. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController {

    
    var tweets : [Tweet]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TwitterClient.sharedInstance?.homeTimeline(success: { (tweets: [Tweet]) in
            
            self.tweets = tweets
            
            for tweet in tweets {
                print(tweet.text!)
            }
            
            
        }, failure: { (error: Error) in
            print("Error: \(error.localizedDescription)")
        })
        // Do any additional setup after loading the view.
    }

    @IBAction func onLogoutButton(_ sender: UIBarButtonItem) {
        
        TwitterClient.sharedInstance?.logout()
        
        
        
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