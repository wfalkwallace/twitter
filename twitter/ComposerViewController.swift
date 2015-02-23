//
//  ComposerViewController.swift
//  twitter
//
//  Created by William Falk-Wallace on 2/20/15.
//  Copyright (c) 2015 Falk-Wallace. All rights reserved.
//

import UIKit

protocol ComposerViewControllerDelegate: class {
    func composerViewController(composerViewController: ComposerViewController,  didSendTweet tweet: Tweet?)
}

class ComposerViewController: UIViewController {

    @IBOutlet weak var composerUserImage: UIImageView!
    @IBOutlet weak var composerName: UILabel!
    @IBOutlet weak var composerUsername: UILabel!
    @IBOutlet weak var composerCharacterCount: UILabel!
    @IBOutlet weak var composerTextField: UITextField!
    
    
    var delegate: ComposerViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var user = User.currentUser!
        composerUsername.text = user.screenname
        composerName.text = user.name
        composerUserImage.setImageWithURL(NSURL(string: user.profileImageURL!))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onValueChanged(sender: AnyObject) {
        composerCharacterCount.text = "\(140 - countElements(composerTextField.text))"
        // TODO limit tweet length
    }
    
    @IBAction func onSend(sender: AnyObject) {
        if composerTextField.text.isEmpty {
            let alertController = UIAlertController(title: "Tweet Body Missing", message: "You can't send an empty tweet!", preferredStyle: .Alert)
            let acceptAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alertController.addAction(acceptAction)
            self.presentViewController(alertController, animated: true, completion: nil)
        } else {
            var tweet = Tweet(text: composerTextField.text, user: User.currentUser!)
            TwitterClient.sharedInstance.statusUpdateWithBlock(tweet, block: { (tweet, error) -> () in
                if let tweet = tweet {
                    self.delegate?.composerViewController(self, didSendTweet: tweet)
                } else {
                    println(error)
                    // some error handling here
                }
            })
        }
    }

    @IBAction func onCancel(sender: AnyObject) {
        delegate?.composerViewController(self, didSendTweet: nil)
    }

}
