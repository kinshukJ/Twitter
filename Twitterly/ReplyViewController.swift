//
//  ReplyViewController.swift
//  Twitterly
//
//  Created by Kinshuk Juneja on 3/6/17.
//  Copyright © 2017 CS490. All rights reserved.
//

import UIKit

class ReplyViewController: UIViewController {

    var tweet : Tweet?
    
    @IBOutlet weak var replyText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onReply(_ sender: UIBarButtonItem) {
      
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
