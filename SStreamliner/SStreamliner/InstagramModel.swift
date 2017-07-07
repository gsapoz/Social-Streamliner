//
//  PostModel.swift
//  SStreamliner
//
//  Created by GaryS on 7/6/17.
//  Copyright © 2017 Gary Sapozhnikov. All rights reserved.
//

//Instagram Module
struct InstagramUser {
    
    var token: String = ""
    var uid: String = ""
    var bio: String = ""
    var followed_by: String = ""
    var follows: String = ""
    var media: String = ""
    var username: String = ""
    var image: String = ""
}

extension ProfileDashboardVC { // Instagram Module
    
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
