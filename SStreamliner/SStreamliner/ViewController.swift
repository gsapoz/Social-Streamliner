//
//  ViewController.swift
//  SStreamliner
//
//  Created by GaryS on 7/6/17.
//  Copyright © 2017 Gary Sapozhnikov. All rights reserved.
//
//  https://github.com/KetaniPhone/SocialMediaLogin

import FacebookLogin
import FacebookCore
import FacebookShare
import FBSDKLoginKit

class ViewController: UIViewController, UITextViewDelegate, FBSDKLoginButtonDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Facebook Login Button
        let loginButton = FBSDKLoginButton()//(readPermissions: [ .PublicProfile ])
        loginButton.frame = CGRect(x: view.bounds.midX - view.bounds.width / 2.4, y: view.bounds.maxY - 140, width: view.bounds.width / 1.2, height: 50)
        view.addSubview(loginButton)
        loginButton.delegate = self
        loginButton.readPermissions = ["email", "public_profile", "user_friends"]
        
        let termslinkAttributes = [
            NSLinkAttributeName: NSURL(string: "http://www.google.com")!,
            NSForegroundColorAttributeName: UIColor.red
            ] as [String : Any]
        
        let privacyLinkAttributes = [
            NSLinkAttributeName: NSURL(string: "http://www.google.com")!,
            NSForegroundColorAttributeName: UIColor.red
            ] as [String : Any]
        
        let attributedString = NSMutableAttributedString(string: "We do not post anything on Facebook\nBy signing in to SocialStreamliner, you agree to our Terms of Service and Privacy Policy")
        
        // Set the 'click here' substring to be the link
        attributedString.setAttributes(termslinkAttributes, range: NSMakeRange(81, 16))
        attributedString.setAttributes(privacyLinkAttributes, range: NSMakeRange(102, 14))
        let textView = UITextView.init(frame: CGRect(x: view.bounds.midX - view.bounds.width / 2.4, y: view.bounds.maxY - 90, width: view.bounds.width / 1.2, height: 90))
        textView.isEditable = false
        textView.backgroundColor = UIColor.clear
        textView.attributedText = attributedString
        view.addSubview(textView)
        textView.textAlignment = .center
        textView.delegate = self

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        return true
    }

    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            print(error)
            return
        }
        print("Successfully logged in with Facebook!")
        FBSDKGraphRequest(graphPath: "/me", parameters: ["fields" : "id, name, email, link, gender"]).start { (connection, result, err) in
            if err != nil{
                print("failed to start graph request:", err!)
                return
            }
            var resultDictionary : NSDictionary
            resultDictionary = result as! [String: AnyObject] as NSDictionary
            //print(resultDictionary["email"]!)
            //print(resultDictionary)
            UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
            UserDefaults.standard.set([resultDictionary["email"]!, resultDictionary["name"]!, resultDictionary["id"]!], forKey: "loggedInUserData")
            UserDefaults.standard.synchronize()
            DispatchQueue.main.async {
                //self.performSegue(withIdentifier: "ToPostLogin", sender: self)
            }
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Logged out of Facebook")
    }
}

