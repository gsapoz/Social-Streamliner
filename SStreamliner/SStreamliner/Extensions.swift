//
//  Extensions.swift
//  SStreamliner
//
//  Created by GaryS on 7/6/17.
//  Copyright © 2017 Gary Sapozhnikov. All rights reserved.
//

extension UIColor{

    static let SSBlue = UIColor(red: CGFloat(0.16), green: CGFloat(0.77), blue: CGFloat(0.81), alpha: CGFloat(1.0))
    static let SSGray = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
    
    static let facebook = UIColor(red:0.23, green:0.35, blue:0.60, alpha:1.0)
    static let twitter = UIColor(red:0.11, green:0.63, blue:0.95, alpha:1.0)
    static let instagram = UIColor(red:0.87, green:0.15, blue:0.50, alpha:1.0)
}


let imageCache = NSCache<AnyObject, AnyObject>()

class WebImageView : UIImageView{
    
    var imageURLString:String?
    func loadImageFromURLString(urlString:String){
        imageURLString = urlString
        let url = URL(string: urlString)
        image = nil
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage{
            self.image = imageFromCache
            return
        }
        let request = URLRequest(url: url!)
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        let task = session.dataTask(with: request, completionHandler: {(data, response, error) -> Void in
            if error != nil{
                print(error!)
                return
            }
            DispatchQueue.main.async(execute: {
                let imageToCache = UIImage(data:data!)
                if(self.imageURLString == urlString){
                    self.image = imageToCache
                }
                imageCache.setObject(imageToCache!, forKey: urlString as AnyObject)
                
            })
        })
        task.resume()
    }
}
