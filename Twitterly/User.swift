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
    
    init(dictionary : NSDictionary) {
        name = dictionary["name"] as? String
        screenname = dictionary["scrren_name"] as? String
        let profileUrlString = dictionary["profile_image_url_https"] as? String
        if let profileUrlString = profileUrlString {
            profileUrl = URL(string: profileUrlString)
        }
        tagline = dictionary["description"] as? String
        
    }
}
