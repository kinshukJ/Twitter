//
//  DetailViewController.swift
//  Twitterly
//
//  Created by Kinshuk Juneja on 3/6/17.
//  Copyright © 2017 CS490. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userHandle: UILabel!
    @IBOutlet weak var userTweet: UILabel!
    @IBOutlet weak var tweetTimeStamp: UILabel!
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    @IBOutlet weak var favoritesCount: UILabel!
    @IBOutlet weak var retweetsCount: UILabel!
    
    
    
    var tweet : Tweet?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        userImageView.setImageWith((tweet?.user?.profileUrl)!)
        userName.text = tweet?.user?.name
        userHandle.text = "@\((tweet?.user?.screenname)!)"
        userTweet.text = tweet?.text
        tweetTimeStamp.text = "\(Int((tweet?.timeStamp?.timeIntervalSinceNow.rounded())! * -1 / 60)) min"
        retweetsCount.text = "\((tweet?.retweetCount)!)"
        favoritesCount.text = "\((tweet?.favoritesCount)!)"

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onRetweer(_ sender: UIButton) {
        
        if (tweet?.retweeted ?? false) {
            tweet?.unretweet()
            self.retweetsCount.text = "\((self.tweet?.retweetCount)!)"
            
            retweetButton.setImage(UIImage.init(named: "retweet-icon-unselected"), for: .normal)
        } else {
            tweet?.retweet()
            self.retweetsCount.text = "\((self.tweet?.retweetCount)!)"
            
            retweetButton.setImage(UIImage.init(named: "retweet-icon-selected"), for: .normal)
        }
        
    }

    @IBAction func onFavorite(_ sender: UIButton) {
        
        if (tweet?.favorited ?? false) {
            tweet?.unfavorite()
           self.favoritesCount.text = "\((self.tweet?.favoritesCount)!)"
            favoriteButton.setImage(UIImage.init(named: "favor-icon-unselected"), for: .normal)
        } else {
            
            tweet?.favorite()
            self.favoritesCount.text = "\((self.tweet?.favoritesCount)!)"
            
            favoriteButton.setImage(UIImage.init(named: "favor-icon-selected"), for: .normal)
            
        }
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let profileViewController = segue.destination as! ProfileViewController
        profileViewController.user = tweet?.user
        
//        let replyTweet = tweet
//        let replyViewController = segue.destination as! ReplyViewController
//        replyViewController.tweet = replyTweet
        
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
