//
//  LoginViewController.swift
//  DemoFBAccountKit
//
//  Created by jeisson on 11/24/18.
//  Copyright © 2018 jeisson. All rights reserved.
//

import UIKit
import AccountKit

class LoginViewController: UIViewController {
    var _accountKit: AKFAccountKit!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        // initialize Account Kit
        if _accountKit == nil {
            _accountKit = AKFAccountKit(responseType: .accessToken)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if _accountKit.currentAccessToken != nil{
            // if the user is already logged in, go to the main screen
            print("Already Logged in")
            DispatchQueue.main.async(execute: {
                self.performSegue(withIdentifier: "showDetails", sender: self)
            })
        }
        else{
            // Show the login screen
        }
    }
    
    func prepareLoginViewController(loginViewController: AKFViewController) {
        loginViewController.delegate = self
        
        //Costumize the theme
        let theme:AKFTheme = AKFTheme.default()
        theme.headerBackgroundColor = UIColor(red: 0.325, green: 0.557, blue: 1, alpha: 1)
        theme.headerTextColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        theme.iconColor = UIColor(red: 0.325, green: 0.557, blue: 1, alpha: 1)
        theme.inputTextColor = UIColor(white: 0.4, alpha: 1.0)
        theme.statusBarStyle = .default
        theme.textColor = UIColor(white: 0.3, alpha: 1.0)
        theme.titleColor = UIColor(red: 0.247, green: 0.247, blue: 0.247, alpha: 1)
        loginViewController.setTheme(theme)
    }
    
    //Login with Email
    func loginWithEmail() {
        let inputState = NSUUID().uuidString
        let vc = _accountKit!.viewControllerForEmailLogin(withEmail: nil, state: inputState)
        self.prepareLoginViewController(loginViewController: vc)
        self.present(vc as UIViewController, animated: true, completion: nil)
    }
    
    //Login with phone number
    func loginWithPhone(){
        let inputState = UUID().uuidString
        let vc = (_accountKit?.viewControllerForPhoneLogin(with: nil, state: inputState))!
        vc.enableSendToFacebook = true
        self.prepareLoginViewController(loginViewController: vc)
        self.present(vc as UIViewController, animated: true, completion: nil)
    }
    
    @IBAction func btnLoginWithPhoneOnClick(_ sender: UIButton) {
        self.loginWithPhone()
    }
    
    @IBAction func btnLoginWithEmailOnClick(_ sender: UIButton) {
        self.loginWithEmail()
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

extension LoginViewController: AKFViewControllerDelegate {
    
    func viewController(viewController: UIViewController!, didCompleteLoginWithAccessToken accessToken: AKFAccessToken!, state: String!) {
        print("did complete login with access token \(accessToken.tokenString) state \(String(describing: state))")
    }
    
    // handle callback on successful login to show authorization code
    func viewController(_ viewController: (UIViewController & AKFViewController)!, didCompleteLoginWithAuthorizationCode code: String!, state: String!) {
        print("didCompleteLoginWithAuthorizationCode")
    }
    
    func viewControllerDidCancel(_ viewController: (UIViewController & AKFViewController)!) {
        // ... handle user cancellation of the login process ...
        print("viewControllerDidCancel")
    }
    
    func viewController(_ viewController: (UIViewController & AKFViewController)!, didFailWithError error: Error!) {
        // ... implement appropriate error handling ...
        print("\(String(describing: viewController)) did fail with error: \(error.localizedDescription)")
    }
    
    func viewController(_ viewController: (UIViewController & AKFViewController)!, didCompleteLoginWith accessToken: AKFAccessToken!, state: String!) {
        print("didCompleteLoginWith")
    }
}
