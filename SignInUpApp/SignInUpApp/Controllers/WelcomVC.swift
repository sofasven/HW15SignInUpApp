//
//  WelcomVC.swift
//  SignInUpApp
//
//  Created by Sofa on 26.08.23.
//

import UIKit

class WelcomVC: UIViewController {
    
    
    @IBOutlet weak var infoLbl: UILabel!
    
    var userModel: UserModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    var userDefaults = UserDefaults.standard
    
    @IBAction func continueAction() {
        guard let userModel = userModel else { return }
        UserDefaultsService.saveUserModel(userModel: userModel)
        navigationController?.popToRootViewController(animated: true)
    }
    private func setupUI() {
        infoLbl.text = "\(userModel?.name ?? "") to our Cool Application!"
    }
}
