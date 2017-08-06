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
import FirebaseDatabase
import FirebaseAuth



import Firebase


class Login: UIViewController{
    
    var db: FIRDatabaseReference!
    
   
    @IBOutlet weak var fbCustom: UIButton!

    override func viewDidLoad() {
    super.viewDidLoad()
       
        
    

    }
    
    @IBAction func fbClick(_ sender: Any) {
        FBSDKLoginManager().logIn(withReadPermissions: ["email", "public_profile"], from: self) { (result , err) in
            if err != nil {
                return
            }
            FBSDKGraphRequest(graphPath: "/me", parameters: ["fields": "id, name, email"]).start { (connection, result, error) in
                if error != nil {
                    
                }
                self.performSegue(withIdentifier: "loginSegue", sender: self)
        
           
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        //nothing yet
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            print (error)
        }

            print(result)
        }
        
    }


    
    
    
}

