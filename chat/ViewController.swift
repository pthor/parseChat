//
//  ViewController.swift
//  chat
//
//  Created by Paul Thormahlen on 2/17/16.
//  Copyright © 2016 Paul Thormahlen. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {
    
    var mystoryboard = UIStoryboard(name: "Main", bundle: nil)
    var appDelegate: AppDelegate?

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func signupTouched(sender: AnyObject) {
        onSignup()
    }
    @IBAction func loginTouched(sender: AnyObject) {
        onSignin()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func onSignin(){
        if usernameTextField.text != nil && passwordTextField.text != nil{
          PFUser.logInWithUsernameInBackground(usernameTextField.text!, password:passwordTextField.text!) {
            (user: PFUser?, error: NSError?) -> Void in
              if user != nil {
                
                let vc = self.mystoryboard.instantiateViewControllerWithIdentifier("ChatViewController") as UIViewController
                
                self.appDelegate!.window?.rootViewController = vc
                //self.presentViewController(ChatViewController(), animated: true, completion: nil)
              } else {
                // The login failed. Check error to see why.
              }
          }
        }

    }
    
    func onSignup() {
        var user = PFUser()
        user.username = usernameTextField.text
        user.password = passwordTextField.text
        user.email = usernameTextField.text
        // other fields can be set just like with PFObject
        user["phone"] = "415-392-0202"
        
        user.signUpInBackgroundWithBlock {
            (succeeded: Bool, error: NSError?) -> Void in
            if let error = error {
                let errorString = error.userInfo["error"] as? NSString
                // Show the errorString somewhere and let the user try again.
            } else {
                self.presentViewController(ChatViewController(), animated: true, completion: nil)
            }
        }
    }


}

