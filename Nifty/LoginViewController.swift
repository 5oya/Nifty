//
//  LoginViewController.swift
//  Nifty
//
//  Created by Soya Takahashi on 2016/02/22.
//  Copyright © 2016年 Ggrape. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    // MARK: - ActionButton

    @IBAction func tapLoginButton(sender: UIButton) {
        let user = User(name: nameField.text!, password: passwordField.text!)
        user.login { (message) in
            if let unwrappedMessage = message {
                self.showAlert(unwrappedMessage)
                return
            } else {
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }
    }
    
    @IBAction func tapSignUpButton(sender: UIButton) {
        let user = User(name: nameField.text!, password: passwordField.text!)
        user.signUp { (message) in
            if let unwrappedMessage = message {
                self.showAlert(unwrappedMessage)
            } else {
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }
    }
    
    
    // MARK: - Alert
    
    func showAlert(message: String?) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .Alert)
        let action = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(action)
        presentViewController(alertController, animated: true, completion: nil)
    }
}
