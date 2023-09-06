//
//  ChangeAccounDataVC.swift
//  SignInUpApp
//
//  Created by Sofa on 30.08.23.
//

import UIKit

class ChangeAccounDataVC: UIViewController {
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passTF: UITextField!
    @IBOutlet weak var confPassTF: UITextField!
    @IBOutlet weak var errorLbl: UILabel!
    @IBOutlet weak var saveBtn: UIButton!
    
    private var isValidEmail = false { didSet { updateSaveBtnState() }}
    private var isConfPass = false { didSet { updateSaveBtnState() }}
    private var passwordStrength: PasswordStrength = .veryWeak { didSet { updateSaveBtnState() }}
    
    @IBAction func emailTFAction(_ sender: UITextField) {
        if let email = sender.text,
           !email.isEmpty,
           VerificationService.isValidEmail(email: email) {
            isValidEmail = true
        } else {
            isValidEmail = false
        }
    }
    
    @IBAction func passTFAction(_ sender: UITextField) {
        if let pass = sender.text,
           !pass.isEmpty {
            passwordStrength = VerificationService.isValidPassword(pass: pass)
        } else {
            passwordStrength = .veryWeak
        }
    }
    
    @IBAction func confPassTFAction(_ sender: UITextField) {
        if let confPass = sender.text,
           !confPass.isEmpty,
           let pass = passTF.text,
           !pass.isEmpty {
            isConfPass = VerificationService.isPassConfirm(pass1: pass, pass2: confPass)
        } else {
            isConfPass = false
        }
    }
    
    @IBAction func saveAction(_ sender: UIButton) {
        UserDefaultsService.cleanUserDefaults()
        guard let email = emailTF.text, !email.isEmpty,
              let pass = passTF.text, !pass.isEmpty else { return }
        let userModel = UserModel(name: nameTF.text, email: email, pass: pass)
        UserDefaultsService.saveUserModel(userModel: userModel)
        navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        errorLbl.isHidden = true
        saveBtn.isEnabled = false
    }
    private func updateSaveBtnState() {
        saveBtn.isEnabled = isValidEmail && isConfPass && passwordStrength != .veryWeak
        errorLbl.isHidden = saveBtn.isEnabled
    }
    
}
