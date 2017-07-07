//
//  ProfileDashboard.swift
//  SStreamliner
//
//  Created by GaryS on 7/7/17.
//  Copyright © 2017 Gary Sapozhnikov. All rights reserved.
//

import FacebookCore
import FacebookLogin
import FBSDKLoginKit

class ProfileDashboardVC : UIViewController{
    
    var tableView : UITableView!
    typealias JSONDictionary = [String:Any]
    var user: InstagramUser?
    let INSTAGRAM_CLIENT_ID = "eea863654848402eb4116e57064b98e5"
    let INSTAGRAM_REDIRECT_URI = "https://www.instagram.com/accounts/login/"
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor.SSBlue
        navigationController?.navigationBar.tintColor = UIColor.white
        
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
        
        //Facebook Button
        let fbloginBtn = FBSDKLoginButton()//(readPermissions: [ .PublicProfile ])
        fbloginBtn.frame = CGRect(x: 0, y: 0, width: 100, height: 30)
        fbloginBtn.delegate = self
        fbloginBtn.readPermissions = ["email", "public_profile", "user_friends"]
        
        //Twitter Button
        let twtloginBtn = UIButton()
        twtloginBtn.frame = CGRect(x: 0, y: 0, width: 100, height: 30)
        twtloginBtn.backgroundColor = UIColor.twitter
        twtloginBtn.addTarget(self, action: #selector(connectToInstagram), for: .touchUpInside)
        
        //Instagram Button
        let igloginBtn = UIButton()
        igloginBtn.frame = CGRect(x: 0, y: 0, width: 100, height: 30)
        igloginBtn.backgroundColor = UIColor.instagram
        igloginBtn.addTarget(self, action: #selector(connectToInstagram), for: .touchUpInside)
        
        let tableTitles : [String] = ["Facebook", "Twitter", "Instagram"]
        let buttons : [Any] = [fbloginBtn, twtloginBtn, igloginBtn]
        
        switch indexPath.row{
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CustomHeaderCell")
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


