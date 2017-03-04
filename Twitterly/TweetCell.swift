//
//  TweetCell.swift
//  Twitterly
//
//  Created by Kinshuk Juneja on 3/1/17.
//  Copyright © 2017 CS490. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    //user can view tweet with the user profile picture, username, tweet text, and timestamp.
    
    @IBOutlet weak var userImageView: UIImageView!
  
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userTweet: UILabel!
    @IBOutlet weak var userTimeStamp: UILabel!
    
    @IBOutlet weak var retweetLabel: UILabel!
    
    @IBOutlet weak var retweetButton: UIButton!
    
    @IBOutlet weak var favoriteLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var currTweet: Tweet?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        if (currTweet?.favorited ?? false) {
            favoriteButton.setImage(UIImage.init(named: "favor-icon-unselected"), for: .normal)
        }
        if (currTweet?.retweeted ?? false) {
            retweetButton.setImage(UIImage.init(named: "retweet-icon-unselected"), for: .normal)
        }

    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        userImageView.clipsToBounds = true

        // Configure the view for the selected state
    }
    
    @IBAction func onRetweer(_ sender: UIButton) {
        if (currTweet?.favorited ?? false) {
            currTweet?.unfavorite()
            favoriteButton.setImage(UIImage.init(named: "favor-icon"), for: .normal)
        } else {
            currTweet?.favorite()
            favoriteButton.setImage(UIImage.init(named: "favor-icon-red"), for: .normal)
        }

    }
    @IBAction func onFavorite(_ sender: UIButton) {
        if (currTweet?.retweeted ?? false) {
            currTweet?.unretweet()
            retweetButton.setImage(UIImage.init(named: "retweet-icon"), for: .normal)
        } else {
            currTweet?.retweet()
            retweetButton.setImage(UIImage.init(named: "retweet-icon-green"), for: .normal)
        }
    }

}
