//
//  ProfileManager.swift
//  SStreamliner
//
//  Created by GaryS on 7/7/17.
//  Copyright © 2017 Gary Sapozhnikov. All rights reserved.
//

import FacebookCore
import FacebookLogin
import FBSDKLoginKit
import SafariServices

class ProfileDashboardVC : UIViewController{
    
    var tableView : UITableView!
    typealias JSONDictionary = [String:Any]
    var user: InstagramUser?
    let INSTAGRAM_CLIENT_ID = "YOUR_ID"
    let INSTAGRAM_REDIRECT_URI = "YOUR_URI"
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor.SSBlue
//        let button1 = UIBarButtonItem(image: UIImage(named: "settings"), style: .plain, target: self, action:#selector(openSettings))
//        self.navigationItem.leftBarButtonItem  = button1
        //self.navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        self.navigationController?.navigationBar.tintColor = UIColor.white
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CustomHeaderCell")
        
        //tableView.backgroundColor = UIColor.clear
        tableView.separatorInset = .zero
        //tableView.separatorStyle = .none
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.showsVerticalScrollIndicator = false
        //scrollView.contentSize = CGSize(width: view.bounds.width, height: view.bounds.height + 100)
    }
    
    func openConnectPage(){
        // When user selects a certain cell, they should be taken to the corresponding login page where they can connect/disconnect their account
    }
    
    
}

extension ProfileDashboardVC : UITableViewDataSource, UITableViewDelegate{
    // MARK: - ScrollView Delegate
    
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row != 0{
            //openConnectPage()
            //loginButtonClicked()
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if indexPath.row == 0{
            return 22.0
        }else{
            return 60.0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //let igloginBtn = UIButton()
        let twtloginBtn = UIButton()
        
        //Facebook Button
        let fbloginBtn = FBSDKLoginButton()//(readPermissions: [ .PublicProfile ])
        fbloginBtn.frame = CGRect(x: 0, y: 0, width: 100, height: 30)
        fbloginBtn.delegate = self
        fbloginBtn.readPermissions = ["email", "public_profile", "user_friends"]
        
        //Instagram Button
        //let rect = CGRect(x: 0, y: 0, width: 100, height: 30)
        //let igloginBtn = UIButton(frame: rect)
        let igloginBtn = UIButton()
        igloginBtn.frame = CGRect(x: 0, y: 0, width: 100, height: 30)
        igloginBtn.backgroundColor = .cyan
        igloginBtn.addTarget(self, action: #selector(connectToInstagram), for: .touchUpInside)
        
        let tableTitles : [String] = ["Facebook", "Twitter", "Instagram"]
        let buttons : [Any] = [fbloginBtn, twtloginBtn, igloginBtn]
        
        switch indexPath.row{
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell")
            
            cell?.selectionStyle = .none
            cell?.backgroundColor = UIColor.SSGray
            cell?.textLabel?.text = "Manage Your Social Media Accounts"
            cell?.textLabel?.font = UIFont.systemFont(ofSize: 13.0, weight: 0.8)
            return cell!
        default:
            //let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell")
            let cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "TableViewCell")
            cell.selectionStyle = .none
            cell.detailTextLabel?.text = "Logged in as Gary"
            cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 13.0)
            cell.detailTextLabel?.textColor = UIColor.darkGray
            cell.accessoryView = buttons[indexPath.row - 1] as? UIView
            
            cell.textLabel?.text = tableTitles[indexPath.row - 1]
            cell.backgroundColor = UIColor.white
            //cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
            return cell
        }
    }
    
    
}

extension ProfileDashboardVC : FBSDKLoginButtonDelegate{
    
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

extension ProfileDashboardVC: SFSafariViewControllerDelegate{
    func connectToInstagram() {
        
        let auth: NSMutableDictionary = ["client_id": INSTAGRAM_CLIENT_ID,
                                         SimpleAuthRedirectURIKey: INSTAGRAM_REDIRECT_URI]
        
        SimpleAuth.configuration()["instagram"] = auth
        SimpleAuth.authorize("instagram", options: [:]) { (result: Any?, error: Error?) -> Void in
            
            if let result = result as? JSONDictionary  {
                
                var token = ""
                var uid = ""
                var bio = ""
                var followed_by = ""
                var follows = ""
                var media = ""
                var username = ""
                var image = ""
                
                token = (result["credentials"] as! JSONDictionary)["token"] as! String
                uid = result["uid"] as! String
                
                if let extra = result["extra"] as? JSONDictionary,
                    let rawInfo = extra ["raw_info"] as? JSONDictionary,
                    let data = rawInfo["data"] as? JSONDictionary {
                    
                    bio = data["bio"] as! String
                    
                    if let counts = data["counts"] as? JSONDictionary {
                        followed_by = String(describing: counts["followed_by"]!)
                        follows = String(describing: counts["follows"]!)
                        media = String(describing: counts["media"]!)
                    }
                }
                
                if let userInfo = result["user_info"] as? JSONDictionary {
                    username = userInfo["username"] as! String
                    image = userInfo["image"] as! String
                }
                
                self.user = InstagramUser(token: token, uid: uid, bio: bio, followed_by: followed_by, follows: follows, media: media, username: username, image: image)
                
                
            } else {
                // this handles if user aborts or the API has a problem like server issue
                let alert = UIAlertController(title: "Error!", message: nil, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            
            if let e = error {
                print("Error during SimpleAuth.authorize: ", e.localizedDescription)
            }
            
            print("user = \(String(describing: self.user))")
        }
    }

}
