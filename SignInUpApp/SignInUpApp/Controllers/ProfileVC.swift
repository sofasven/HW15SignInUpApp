//
//  ProfileVC.swift
//  SignInUpApp
//
//  Created by Sofa on 30.08.23.
//

import UIKit

class ProfileVC: UIViewController {
    
    
    @IBOutlet weak var nameLbl: UILabel!
    
    @IBOutlet weak var emailLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    @IBAction func deleteAccAction() {
        UserDefaultsService.cleanUserDefaults()
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func logOutAction() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    
    private func setupUI() {
        guard let userModel = UserDefaultsService.getUserModel() else { return }
        nameLbl.text = "\(userModel.name ?? "Hello")"
        emailLbl.text = "\(userModel.email)"
        emailLbl.isHidden = false
    }
}
