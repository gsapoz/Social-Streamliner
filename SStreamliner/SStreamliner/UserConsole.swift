//
//  UserConsole.swift
//  SStreamliner
//
//  Created by GaryS on 7/6/17.
//  Copyright © 2017 Gary Sapozhnikov. All rights reserved.
//


class UserConsoleVC : UIViewController{

    var tableView : UITableView!
    let socialMediaIcons : [UIImage] = [#imageLiteral(resourceName: "facebook"), #imageLiteral(resourceName: "twitter"), #imageLiteral(resourceName: "instagram")]
    
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
        
        tableView.register(UINib(nibName: "ProfilePortalCell", bundle:nil), forCellReuseIdentifier: "portalCell")
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

extension UserConsoleVC : UITableViewDataSource, UITableViewDelegate{
    
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        switch indexPath.row{
        case 3:
            return 100.0
        default:
            return 260.0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = SocialFeedVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row{
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell")
            cell?.selectionStyle = .none
            cell?.backgroundColor = UIColor.white
            return cell!
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "portalCell", for: indexPath) as! ProfilePortalCell
            cell.selectionStyle = .none
            cell.socialIcon.image = socialMediaIcons[indexPath.row]
            cell.ProfileUserName.text = "No Account Connected"
            
            return cell
        }
        
    }
    

}

class ProfilePortalCell: UITableViewCell {
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var ProfilePictureCell: UIImageView!
    @IBOutlet weak var socialIcon: UIImageView!
    @IBOutlet weak var ProfileUserName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
