//
//  Tweet.swift
//  Twitterly
//
//  Created by Kinshuk Juneja on 2/27/17.
//  Copyright © 2017 CS490. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var user: User?
    var text: String?
    var timeStamp: Date?
    var retweetCount: Int
    var favoritesCount: Int
    var favorited = false
    var retweeted = false
    
    init(dictionary: NSDictionary) {
        text = dictionary["text"] as? String
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoritesCount = (dictionary["favourites_count"] as? Int) ?? 0
        
        let timeStampString = dictionary["created_at"] as? String
      
        if let timeStampString = timeStampString {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        
            timeStamp = formatter.date(from: timeStampString)
        }
    }
    
    class func tweetsWithArray(dictionaries: [Dictionary<String, Any>]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in dictionaries {
            tweets.append(Tweet.init(dictionary: dictionary as NSDictionary))
        }
        
        return tweets
    }
    
       
    func unfavorite() {
        if (favorited) {
            favorited = false
            favoritesCount -= 1
        }
    }
    
    func favorite() {
        if (!favorited) {
            favorited = true
            favoritesCount += 1
        }
    }
    
    func unretweet() {
        if (retweeted) {
            retweeted = false
            retweetCount -= 1
        }
    }
    
    func retweet() {
        if (!retweeted) {
            retweeted = true
            retweetCount += 1
        }
    }
}
