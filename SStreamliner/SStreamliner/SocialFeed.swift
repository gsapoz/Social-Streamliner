//
//  SocialFeed.swift
//  SStreamliner
//
//  Created by GaryS on 7/7/17.
//  Copyright © 2017 Gary Sapozhnikov. All rights reserved.
//

class SocialFeedVC : UIViewController{
    
    var tableView : UITableView!
    let postIcon : [UIImage] = [#imageLiteral(resourceName: "writtenPost"), #imageLiteral(resourceName: "videoPost"), #imageLiteral(resourceName: "writtenPost")]
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor.SSBlue
        let settingsBtn = UIBarButtonItem(image: UIImage(named: "settings"), style: .plain, target: self, action:#selector(openSettings))
        self.navigationItem.rightBarButtonItem  = settingsBtn
        //self.navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        self.navigationController?.navigationBar.tintColor = UIColor.white
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        
        tableView.register(UINib(nibName: "SocialPostCell", bundle:nil), forCellReuseIdentifier: "postCell")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        
        //tableView.backgroundColor = UIColor.clear
        tableView.separatorInset = .zero
        tableView.separatorStyle = .none
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.showsVerticalScrollIndicator = false
        //scrollView.contentSize = CGSize(width: view.bounds.width, height: view.bounds.height + 100)
    }
    
    func openSettings(){
        let vc = ProfileDashboardVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

extension SocialFeedVC : UITableViewDataSource, UITableViewDelegate{
    // MARK: - ScrollView Delegate
    
    
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        switch indexPath.row{
        case 49:
            return 100.0
        default:
            return 110.0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row{
        case 49:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell")
            cell?.selectionStyle = .none
            cell?.backgroundColor = UIColor.white
            return cell!
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! SocialPostCell
            cell.selectionStyle = .none
            //cell.socialIcon.image = socialMediaIcons[indexPath.row]
            cell.thumbnail.image = postIcon[2]
            return cell
        }
        
    }
    
    
}


class SocialPostCell: UITableViewCell {
    
    @IBOutlet weak var thumbnail: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
}
