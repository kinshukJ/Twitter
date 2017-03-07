//
//  TweetsViewController.swift
//  Twitterly
//
//  Created by Kinshuk Juneja on 2/28/17.
//  Copyright © 2017 CS490. All rights reserved.
//

import UIKit
import AFNetworking

class TweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    

    
    var tweets : [Tweet]!
    
    @IBOutlet weak var tweetsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tweetsTableView.dataSource = self
        tweetsTableView.delegate = self
        
        tweetsTableView.rowHeight = UITableViewAutomaticDimension
        tweetsTableView.estimatedRowHeight = 120
        
        TwitterClient.sharedInstance?.homeTimeline(success: { (tweets: [Tweet]) in
            

            
            self.tweets = tweets
            self.tweetsTableView.reloadData()
         
            
        }, failure: { (error: Error) in
            print("Error: \(error.localizedDescription)")
        })
        // Do any additional setup after loading the view.
    }

    @IBAction func onLogoutButton(_ sender: UIBarButtonItem) {
        
        TwitterClient.sharedInstance?.logout()
        
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tweets = tweets {
            return tweets.count
        }
        else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
            let cell = tweetsTableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
            let currTweet = tweets[indexPath.row]
            cell.retweetLabel.text = "\(currTweet.retweetCount)"
            cell.favoriteLabel.text = "\(currTweet.favoritesCount)"
            cell.currTweet = currTweet
            cell.retweetLabel.adjustsFontSizeToFitWidth = true
            cell.favoriteLabel.adjustsFontSizeToFitWidth = true
        
            print(currTweet.user?.profileUrl! ?? "sdf")
            cell.userImageView.setImageWith((currTweet.user?.profileUrl!)!)

            cell.userName.text = currTweet.user?.name
            cell.userTweet.text = currTweet.text
            cell.userTimeStamp.text = "\(Int((currTweet.timeStamp?.timeIntervalSinceNow.rounded())! * -1 / 60)) min"

        
            
            return cell

    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(((sender as? UITableViewCell) ) != nil){
            let cell = sender as! UITableViewCell
            let indexPath = tweetsTableView.indexPath(for: cell)
            let tweet = tweets![(indexPath?.row)!]
        
            let detailViewController = segue.destination as! DetailViewController
            detailViewController.tweet = tweet
        
        }

        
        if(segue.identifier == "newTweetSegue") {
            
        }
        
        if(segue.identifier == "profileViewSegue"){
            let profileViewController = segue.destination as! ProfileViewController
            profileViewController.user = User.currentUser

        }
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
