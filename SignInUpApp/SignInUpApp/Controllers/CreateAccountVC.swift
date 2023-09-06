//
//  CreateAccountVC.swift
//  SignInUpApp
//
//  Created by Sofa on 23.08.23.
//

import UIKit

class CreateAccountVC: UIViewController {
    
    /// email
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var errorEmailLbl: UILabel!
    /// name
    @IBOutlet weak var nameTF: UITextField!
    /// password
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var errorPassLbl: UILabel!
    @IBOutlet var strongPassIndicatorsViews: [UIView]!
    /// confirm password
    @IBOutlet weak var conPassTF: UITextField!
    @IBOutlet weak var errorConfPassLbl: UILabel!
    /// continue button
    @IBOutlet weak var continueBtn: UIButton!
    /// scrollView
    @IBOutlet weak var scrollView: UIScrollView!
    
    private var isValidEmail = false { didSet { updateContinueBtnState() }}
    private var isConfPass = false { didSet { updateContinueBtnState() }}
    private var passwordStrength: PasswordStrength = .veryWeak { didSet { updateContinueBtnState() }}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        strongPassIndicatorsViews.forEach { view in
            view.alpha = 0.3
        }
        startKeyboardObserver()
        hideKeyboardWhenTappedAround()
    }
    
    @IBAction func emailTFAction(_ sender: UITextField) {
        if let email = sender.text,
           !email.isEmpty,
           VerificationService.isValidEmail(email: email) {
            isValidEmail = true
        } else {
            isValidEmail = false
        }
        errorEmailLbl.isHidden = isValidEmail
    }
    
    @IBAction func passTFAction(_ sender: UITextField) {
        if let passText = sender.text,
           !passText.isEmpty {
            passwordStrength = VerificationService.isValidPassword(pass: passText)
        } else {
            passwordStrength = .veryWeak
        }
        errorPassLbl.isHidden = passwordStrength != .veryWeak
        setupSrongIndicatorsViews()
    }
    
    @IBAction func confPassTFAction(_ sender: UITextField) {
        if let confPassText = sender.text,
           !confPassText.isEmpty,
           let passText = passwordTF.text,
           !passText.isEmpty {
            isConfPass = VerificationService.isPassConfirm(pass1: passText, pass2: confPassText)
        } else {
            isConfPass = false
        }
        errorConfPassLbl.isHidden = isConfPass
    }
    
    @IBAction func signInAction() {
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func continueAction() {
        if let email = emailTF.text,
           let pass = passwordTF.text {
            let userModel = UserModel(name: nameTF.text, email: email, pass: pass)
            performSegue(withIdentifier: "goToVerifivationScreen", sender: userModel)
        }
    }
    
    
    
    private func setupSrongIndicatorsViews() {
        strongPassIndicatorsViews.enumerated().forEach { index, view in
            if index <= (passwordStrength.rawValue - 1) {
                view.alpha = 1
            } else {
                view.alpha = 0.3
            }
        }
    }
    private func updateContinueBtnState() {
        continueBtn.isEnabled = isValidEmail && isConfPass && passwordStrength != .veryWeak
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    private func startKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    @objc private func keyboardWillShow(notification: Notification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height, right: 0.0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    @objc private func keyboardWillHide() {
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
   
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destVC = segue.destination as? VerificationsVC,
              let userModel = sender as? UserModel else { return }
            destVC.userModel = userModel
    }

}
