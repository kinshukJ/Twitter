//
//  ProfileViewController.swift
//  Twitterly
//
//  Created by Kinshuk Juneja on 3/6/17.
//  Copyright © 2017 CS490. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    var tweet : Tweet?
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var tweetsCount: UILabel!
    
    @IBOutlet weak var followingCount: UILabel!
    
    @IBOutlet weak var followersCount: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        profileImage.setImageWith((tweet?.user?.profileUrl)!)
        tweetsCount.text = "\((tweet?.user?.tweetsCount)!)"
        followersCount.text = "\((tweet?.user?.followersCount)!)"
        followingCount.text = "\((tweet?.user?.followingCount)!)"

        // Do any additional setup after loading the view.
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
