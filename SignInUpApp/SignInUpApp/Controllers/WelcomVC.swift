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
    
    @IBAction func continueAction() {
    //TODO: - save data
        navigationController?.popToRootViewController(animated: true)
    }
    private func setupUI() {
        infoLbl.text = "\(userModel?.name ?? "") to our Cool Application!"
    }
}
