//
//  ProfileVC.swift
//  MyMemory
//
//  Created by JuSun Kang on 11/14/23.
//  Copyright © 2023 rubypaper. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let profileImage = UIImageView()
    let tv = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "프로필"
        
        let backBtn = UIBarButtonItem(title: "닫기", style: .plain, target: self, action: #selector(close))
        
        self.navigationItem.leftBarButtonItem = backBtn
        
        let image = UIImage(named: "account.jpg")
        
        self.profileImage.image = image
        self.profileImage.frame.size = CGSize(width: 100, height: 100)
        self.profileImage.center = CGPoint(x: self.view.frame.width / 2, y: 130)
        
        self.profileImage.layer.cornerRadius = self.profileImage.frame.width / 2
        self.profileImage.layer.borderWidth = 0
        self.profileImage.layer.masksToBounds = true
        
        self.view.addSubview(self.profileImage)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        return cell
    }
    
    @objc func close(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)
    }

}
