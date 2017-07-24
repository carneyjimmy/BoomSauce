//
//  Login.swift
//  LuckyDuck
//
//  Created by Jimmy Carney on 7/23/17.
//  Copyright © 2017 Jimmy Carney. All rights reserved.
//


import Foundation
import UIKit
import FBSDKLoginKit



import Firebase


class Login: UIViewController, FBSDKLoginButtonDelegate{
    
    var db: FIRDatabaseReference!
    

    override func viewDidLoad() {
    
            let loginButton = FBSDKLoginButton()
        
        
            
            view.addSubview(loginButton)
        
        loginButton.frame = CGRect(x: 16, y: 40, width: view.frame.width - 32, height: 50)
        
    
    
        loginButton.delegate = self
        loginButton.readPermissions = ["email", "public_profile"]

    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        //nothing yet
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            print (error)
        }
        FBSDKGraphRequest(graphPath: "/me", parameters: ["fields": "id, name, email"]).start { (connection, result, error) in
            if error != nil {
                
                }
            print(result)
        }
        performSegue(withIdentifier: "loginSegue", sender: self)
    }


    
    
    
}

