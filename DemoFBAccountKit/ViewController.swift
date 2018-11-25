//
//  ViewController.swift
//  DemoFBAccountKit
//
//  Created by jeisson on 11/24/18.
//  Copyright © 2018 jeisson. All rights reserved.
//

import UIKit
import AccountKit

class ViewController: UIViewController {

    @IBOutlet weak var lblAccountId: UILabel!
    @IBOutlet weak var lblEmailOrPhone: UILabel!
    
    var accountKit: AKFAccountKit!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // initialize Account Kit
        if accountKit == nil {
            //specify AKFResponseType.AccessToken
            self.accountKit = AKFAccountKit(responseType: AKFResponseType.accessToken)
            accountKit.requestAccount{
                (account, error) -> Void in
                if let accountID = account?.accountID{
                    self.lblAccountId.text = accountID
                }
                if let email = account?.emailAddress {
                    self.lblEmailOrPhone.text = email
                }
                else if let phoneNumber = account?.phoneNumber{
                    self.lblEmailOrPhone.text = phoneNumber.stringRepresentation()
                }
            }
        }
    }
    
    @IBAction func btnLogOutOnClick(_ sender: UIButton) {
        accountKit.logOut()
        dismiss(animated: true, completion: nil)
    }
}

