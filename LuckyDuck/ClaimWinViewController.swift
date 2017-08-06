//
//  ClaimWinViewController.swift
//  LuckyDuck
//
//  Created by Jimmy  Carney on 8/5/17.
//  Copyright © 2017 Jimmy Carney. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ClaimWinViewController: UIViewController {

    @IBOutlet weak var picture: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    var id: String = ""
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let ref = FIRDatabase.database().reference()
        ref.child("Events/\(self.id)").observeSingleEvent(of: .value, with: { (snapshot) in
            print("Events/\(self.id)")
            
            if let _ = snapshot.value as? NSNull {
                return
            } else {
                let value = snapshot.value as? NSDictionary
                
                
                let url = URL(string: value?["Image"] as! String)
                let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                self.picture.image = UIImage(data: data!)!
                
                let overlay: UIView = UIView(frame: CGRect(x: 0, y: 0, width: self.picture.frame.size.width + 100, height:  self.picture.frame.size.height))
                overlay.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.3)
                self.picture.addSubview(overlay)
                
                self.titleLabel.text = value?["Name"] as? String ?? ""

                
                
            }
        });
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      /*
        let ref = FIRDatabase.database().reference(fromURL: "https://temptitle-5df50.firebaseio.com/Events/\(id)/Image")
        ref.queryOrderedByKey().observe(.childAdded, with: { snapshot in
            
            if let _ = snapshot.value as? NSNull {
                return
            }
            else {
                let url = URL(string: snapshot.value as! String)
                let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                
                self.picture.image = UIImage(data: data!)!
            }
        });
    
        */
        /*
        let overlay: UIView = UIView(frame: CGRect(x: 0, y: 0, width: picture.frame.size.width + 100, height:  picture.frame.size.height))
        overlay.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.45)
        picture.addSubview(overlay)
        */

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
