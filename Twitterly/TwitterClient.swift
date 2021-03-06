//
//  TwitterClient.swift
//  Twitterly
//
//  Created by Kinshuk Juneja on 2/28/17.
//  Copyright © 2017 CS490. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {
    
    static let homeTimelineEndpoint: String = "1.1/statuses/home_timeline.json"
    static let verifyCredentialsEndpoint: String = "1.1/account/verify_credentials.json"
    static let baseUrl: String = "https://api.twitter.com"
    static let sharedInstance = TwitterClient(baseURL: NSURL(string: "https://api.twitter.com")! as URL!, consumerKey: "8kY9ITr1Wg2rHqqo2Kgc7ySMZ", consumerSecret: "kUHtWHVtdrPchLyzJZuImRg8y3l64t1QUw6VzvkjRd9ml8D0gD")
    
    var loginSuccess: (()->())?
    var loginFailure: ((Error)->())?
    
    func login(success: @escaping ()->(), failure: @escaping (Error)->()) {
        
        loginSuccess = success
        loginFailure = failure
        
        TwitterClient.sharedInstance?.deauthorize()
        TwitterClient.sharedInstance?.fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: NSURL(string : "twitterdemo://oauth") as URL!, scope: nil, success: { ( requestToken: BDBOAuth1Credential?) -> Void in
            
            
            let url = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken!.token!)")!
            
            UIApplication.shared.open(url as URL, completionHandler: { (true) in
                print("Got a toked")
            })
            
            
        }, failure: { (error: Error?) -> Void in
            print("error : \(error!.localizedDescription)")
            self.loginFailure?(error! )
        })
 
    }
    
    func logout() {
        User.currentUser = nil
        deauthorize()
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: User.userDidLogoutNotification), object: nil)
    }
    
    func handleOpenUrl(url: URL){
        let requestToken = BDBOAuth1Credential(queryString : url.query )
        
        TwitterClient.sharedInstance?.fetchAccessToken(withPath: "oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken : BDBOAuth1Credential?) in
            print("I got access token!")
            
            
            self.currentAccount(success: { (user: User) in
                User.currentUser = user
                self.loginSuccess?()

            }, failure: { (error: Error) in
                 self.loginFailure?(error)
            })
            
            
        }, failure: { (error : Error?) in
            print("error: \(error!.localizedDescription)")
            self.loginFailure?(error!)
        })

    }
    
    func currentAccount( success: @escaping (User)->(), failure: @escaping (Error)->() ) {
        get(TwitterClient.verifyCredentialsEndpoint, parameters: nil, progress: nil, success: { (URLSessionDataTask, response: Any?) in
            let userDictionary = response as! Dictionary<String, Any>
            let user = User.init(dictionary: userDictionary)
            
            success(user)
        }) { (URLSessionDataTask, error: Error) in
            failure(error)
        }
    }
    
    
    func homeTimeline( success: @escaping ([Tweet])->(), failure: @escaping (Error )->()) {
        
        get(TwitterClient.homeTimelineEndpoint, parameters: nil, progress: nil, success: { (URLSessionDataTask, response: Any?) in
            let dictionaries = response as! [Dictionary<String, Any>]
            let tweets = Tweet.tweetsWithArray(dictionaries: dictionaries)
            success(tweets)
        }) { (URLSessionDataTask, error: Error) in
            failure(error)
        }
    }
    

    
    func retweet(id: Int, success: @escaping () -> (), failure: @escaping (Error) -> ()) {
        self.post("https://api.twitter.com/1.1/statuses/retweet/\(id).json", parameters: nil, progress: nil, success: { (task, response) in
            success()
        }) { (task, error) in
            failure(error)
        }
    }
    
    func unRetweet(id: Int, success: @escaping () -> (), failure: @escaping (Error) -> ()) {
        self.post("https://api.twitter.com/1.1/statuses/unretweet/\(id).json", parameters: nil, progress: nil, success: { (task, response) in
            success()
        }) { (task, error) in
            failure(error)
        }
    }
    
    func favorite(id: Int, success: @escaping () -> (), failure: @escaping (Error) -> ()) {
        self.post("https://api.twitter.com/1.1/favorites/create.json?id=\(id)", parameters: nil, progress: nil, success: { (task, response) in
            success()
        }) { (task, error) in
            failure(error)
        }
    }
    
    func unFavorite(id: Int, success: @escaping () -> (), failure: @escaping (Error) -> ()) {
        self.post("https://api.twitter.com/1.1/favorites/destroy.json?id=\(id)", parameters: nil, progress: nil, success: { (task, response) in
            success()
        }) { (task, error) in
            failure(error)
        }
    }
}
