# Social-Streamliner
Organize, filter, and streamline your social media profiles to sort out and remove unwanted tags, embarrassing photos, incriminating tweets, and posts with low activity.

## Features 
- A User Console where users can connect and manage their social media profiles
- A Social Dashboard where users can view and manage their social media profiles
- Individual profile modules for Instagram, Facebook, and Twitter where users can filter posts by time and engagement (likes, views, retweets, comments, shares, replies, etc..)

## Tech-Stack
- Realm Mobile Platform and Swift NSUserDefaults for post archiving
- Facebook SDK, Twitter Kit, and Instagram API to fetch user information
- Swift/Objective-C front-end with CocoaPods Dependency Manager
- AlamoFire, SwiftyJSON, and Facebook Graph API to fetch profile content

## Task List
- [x] Initialize Xcode Workspace with Cocoapods Dependency Manager
- [x] Initialize Bridging Header to import UIKit and AlamoFire Libraries 
- [ ] Integrate Facebook Login SDK to get user profile credentials
- [ ] Integrate Twitter Kit to utilize Tweet functionality
- [ ] Integrate Instagram API to utilize Instagram module
- [ ] Design and Implement user console with each social media logins
- [ ] Design and Implement Social Dashboard with each profile feed
- [ ] Design and Implement individual post views for each type of post (photo, tweet, check-in, etc..)
- [ ] Design and Implement Activity Model to backup deleted posts just in case user wants to review them



