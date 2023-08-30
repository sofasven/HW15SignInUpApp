//
//  SignInVC.swift
//  SignInUpApp
//
//  Created by Sofa on 23.08.23.
//

import UIKit

class SignInVC: UIViewController {
    
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var errorLbl: UILabel!
    @IBOutlet weak var signInBtn: UIButton!
    
    var checkEmail = false
    var checkPass = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        if let _ = UserDefaultsService.getUserModel() {
            goToTabBarController()
        }
    }
    
    @IBAction func emailTFAction(_ sender: UITextField) {
        guard let email = sender.text,
              !email.isEmpty,
              VerificationService.isValidEmail(email: email) else { return }
        checkEmail = true
        updateSignInBtn()
    }
    
    @IBAction func passTFAction(_ sender: UITextField) {
        guard let pass = sender.text,
              !pass.isEmpty,
              VerificationService.isValidPassword(pass: pass) != .veryWeak else { return }
        checkPass = true
        updateSignInBtn()
    }
    
    @IBAction func signInAction(_ sender: UIButton) {
        guard let email = emailTF.text,
              let pass = passwordTF.text,
              let userModel = UserDefaultsService.getUserModel(),
              email == userModel.email,
              pass == userModel.pass
        else {
            errorLbl.isHidden = false
            return
        }
       goToTabBarController()
    }
    private func goToTabBarController() {
        performSegue(withIdentifier: "goToMainStoryboard", sender: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        emailTF.text = ""
        passwordTF.text = ""
    }
    private func updateSignInBtn() {
        signInBtn.isEnabled = checkEmail && checkPass
    }
    
    private func setupUI () {
        signInBtn.isEnabled = false
        errorLbl.isHidden = true
    }

}
