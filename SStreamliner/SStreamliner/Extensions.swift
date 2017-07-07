//
//  Extensions.swift
//  SStreamliner
//
//  Created by GaryS on 7/6/17.
//  Copyright © 2017 Gary Sapozhnikov. All rights reserved.
//

extension UIColor{
//    static func SSBlue(r:CGFloat, g:CGFloat, b:CGFloat, alpha:CGFloat) -> UIColor{
//        return UIColor(red: CGFloat(0.16), green: CGFloat(0.77), blue: CGFloat(0.81), alpha: CGFloat(1.0))
//    }
    static let SSBlue = UIColor(red: CGFloat(0.16), green: CGFloat(0.77), blue: CGFloat(0.81), alpha: CGFloat(1.0))
    static let SSGray = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
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
