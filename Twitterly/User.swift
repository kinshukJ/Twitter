//
//  User.swift
//  Twitterly
//
//  Created by Kinshuk Juneja on 2/27/17.
//  Copyright © 2017 CS490. All rights reserved.
//

import UIKit

class User: NSObject {
    var name : String?
    var screenname : String?
    var profileUrl : URL?
    var tagline: String?
    var tweetsCount: String?
    var followersCount: String?
    var followingCount: String?
    
    var dictionary : Dictionary<String, Any>?
    
    init(dictionary : Dictionary<String, Any>) {
        
        
        self.dictionary = dictionary
        self.name = dictionary["name"] as? String
        self.screenname = dictionary["screen_name"] as? String
        self.tweetsCount = dictionary["statuses_count"] as? String
        self.followersCount = dictionary["followers_count"] as? String
        self.followingCount = dictionary["friends_count"] as? String

        if let profileURLString = dictionary["profile_image_url_https"] as? String {
            self.profileUrl = URL.init(string: profileURLString)
        }
        self.tagline = dictionary["description"] as? String
        
    }
    static let userDidLogoutNotification = "UserDidLogout"

    static var _currentUser : User?
    
    class var currentUser: User? {
        get {
            if _currentUser == nil {
                let defaults = UserDefaults.standard
                let userData  = defaults.object(forKey: "currentUserData") as? Data
                
                if let userData = userData {
                    
                  //  UserDefaults.standard.removeObject(forKey: "currentUserData")
                  //  print(userData)
                    
                    let dictionary = try! JSONSerialization.jsonObject(with: userData, options: [])
                    _currentUser =  User.init(dictionary: dictionary as! Dictionary<String, Any>)
                }
            }
            return _currentUser
        }
        set (user){
            _currentUser = user
            let defaults = UserDefaults.standard
            
            if let user = user {
                let data = try! JSONSerialization.data(withJSONObject: user.dictionary!, options: [])
                defaults.set(data, forKey: "currentUserData")
            } else {
                defaults.set(nil , forKey: "currentUserData")
            }

            defaults.synchronize()
        }
    }
}
