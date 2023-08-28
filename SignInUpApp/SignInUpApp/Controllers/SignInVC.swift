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
    
    let savedName = UserDefaults.standard.string(forKey: "name")
    let savedEmail = UserDefaults.standard.string(forKey: "email")
    let savedPass = UserDefaults.standard.string(forKey: "pass")
    

    @IBAction func emailTFAction(_ sender: UITextField) {
        if let email = sender.text,
           !email.isEmpty,
           email == savedEmail {
            checkEmail = true
        } else {
            checkEmail = false
        }
        errorLbl.isHidden = checkEmail
        updateSignInStateBtn()
    }
    
    @IBAction func passTFAction(_ sender: UITextField) {
        if let pass = sender.text,
           !pass.isEmpty,
           pass == savedPass {
            checkPass = true
        } else {
            checkPass = false
        }
        errorLbl.isHidden = checkPass
        updateSignInStateBtn()
    }
    private func updateSignInStateBtn() {
        signInBtn.isEnabled = checkEmail && checkPass
    }
    
    @IBAction func signInAction(_ sender: UIButton) {
        performSegue(withIdentifier: "goToMainStoryboard", sender: savedName)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    private func setupUI () {
        signInBtn.isEnabled = false
        errorLbl.isHidden = true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
