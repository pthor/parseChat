//
//  ChatViewController.swift
//  chat
//
//  Created by Paul Thormahlen on 2/17/16.
//  Copyright © 2016 Paul Thormahlen. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var messages = [String]()

    @IBOutlet weak var chatTestField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: "onTimer", userInfo: nil, repeats: true)
        

        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var tableView: UITableView!
    @IBAction func onSend(sender: AnyObject) {
        
        var chatText = chatTestField.text
        
        var chatMessage = PFObject(className:"Message_iOSFeb2016")
        chatMessage["text"] = chatText

        chatMessage.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                print("Message Sent")
                self.messages.append(chatText!)
                self.tableView.reloadData()
                // The object has been saved.
            } else {
                // There was a problem, check error.description
            }
        }
    }
    
    func onTimer() {
        var query = PFQuery(className:"Message_iOSFeb2016")
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) scores.")
                // Do something with the found objects
                var newMsgs = [String]()
                if let objects = objects {
                    for object in objects {
                        var msg = object["text"] as! String
                        newMsgs.append(msg)
                        //print(object.objectId)
                    }
                    self.messages = newMsgs
                    self.tableView.reloadData()
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }

    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MessageCell", forIndexPath: indexPath) as! messageTableViewCell
        cell.messageLabel.text = messages[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
