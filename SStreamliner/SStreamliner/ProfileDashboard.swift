//
//  ProfileManager.swift
//  SStreamliner
//
//  Created by GaryS on 7/7/17.
//  Copyright © 2017 Gary Sapozhnikov. All rights reserved.
//

class ProfileDashboardVC : UIViewController{
    
    var tableView : UITableView!
    let tableTitles : [String] = ["Facebook", "Twitter", "Instagram"]
    
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
            openConnectPage()
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
//        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell")
//        cell?.selectionStyle = .none
//        cell?.textLabel?.text = tableTitles[indexPath.row]
//        cell?.backgroundColor = UIColor.white
//        
//        return cell!
        switch indexPath.row{
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell")
            cell?.selectionStyle = .none
            cell?.backgroundColor = UIColor.SSGray
            cell?.textLabel?.text = "Manage Your Social Media Accounts"
            cell?.textLabel?.font = UIFont.systemFont(ofSize: 13.0, weight: 0.8)
            return cell!
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell")
            cell?.selectionStyle = .none
            cell?.textLabel?.text = tableTitles[indexPath.row - 1]
            cell?.backgroundColor = UIColor.white
            cell?.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
            return cell!
        }
    }
    
    
}
