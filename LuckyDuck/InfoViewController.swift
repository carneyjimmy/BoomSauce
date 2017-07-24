//
//  InfoViewController.swift
//  LuckyDuck
//
//  Created by Jimmy Carney on 7/9/17.
//  Copyright © 2017 Jimmy Carney. All rights reserved.
//

import UIKit
import Firebase

var mybidnumber = 1
var totalBidNumber = 403

class InfoViewController: UIViewController {
    
    @IBOutlet weak var nav: UINavigationItem!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var deadlineTag: UILabel!
    @IBOutlet weak var mybids: UIButton!
    @IBOutlet weak var totalBids: UIButton!
    @IBOutlet weak var priceButton: UIButton!
    @IBOutlet weak var imageview: UIImageView!
    
   
    var isFull = false

    @IBAction func bidButtonClicked(_ sender: Any) {
        mybidnumber += 1
        totalBidNumber += 1
        totalBids.setTitle(String(totalBidNumber), for: UIControlState.normal)
        mybids.setTitle(String(mybidnumber), for: UIControlState.normal)
        
    }

    @IBAction func changeFav(_ sender: Any) {
        print("here!")
        if (isFull){
            let favimage : UIImage = UIImage(named: "fav.png")!
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
            imageView.contentMode = .scaleAspectFit
            imageView.image = favimage
            nav.rightBarButtonItem?.customView = imageView
            
            
            fav.image = favimage
            isFull = !isFull
        }
        else {
            let favimage : UIImage = UIImage(named: "favFill.png")!
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
            imageView.contentMode = .scaleAspectFit
            imageView.image = favimage
            nav.rightBarButtonItem?.customView = imageView
            
            
            fav.image = favimage
            isFull = !isFull
        }
        
        
    }
    
    @IBOutlet weak var fav: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        priceButton.layer.cornerRadius = 20; // this value vary as per your desire
        priceButton.clipsToBounds = true
        let favimage : UIImage = UIImage(named: "fav.png")!
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imageView.contentMode = .scaleAspectFit
        imageView.image = favimage
        nav.rightBarButtonItem?.customView = imageView
        
        
        fav.image = favimage
        getNames()
        
        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getNames()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getPicture(){
        var imageUrl = ""
        let ref = FIRDatabase.database().reference()
        ref.child("Events/\(selectedName)").observeSingleEvent(of: .value, with: { (snapshot) in
            
            
            if let _ = snapshot.value as? NSNull {
                return
            } else {
                let value = snapshot.value as? NSDictionary
                
                let imageurl = value?["Image"] as? String ?? ""
            }
        })
    
        let url = URL(string: imageUrl)
        let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
        imageview.image = UIImage(data: data!)
    }
    
    func getNames(){
        let ref = FIRDatabase.database().reference()
        ref.child("Events/\(selectedName)").observeSingleEvent(of: .value, with: { (snapshot) in
       print("Events/\(selectedName)")
            
            if let _ = snapshot.value as? NSNull {
                return
            } else {
                let value = snapshot.value as? NSDictionary
                
                let name = value?["Name"] as? String ?? ""
                let title = value?["Title"] as? String ?? ""
                let description = value?["Description"] as? String ?? ""
                let price = value?["Price"] as? Double ?? 0.0
                
               // let location = value?["location"] as? String ?? ""
                //   let time = value?["when"] as? String ?? ""
                //   let date = value?["date"] as? String ?? ""
                let deadline = value?["deadline"] as? String ?? ""
               
                
                self.nav.title = title
                self.descriptionLabel.text = description
                self.deadlineTag.text = deadline
                self.priceButton.setTitle("$" + String(price) + "0", for: UIControlState.normal)
                self.totalBids.titleLabel?.text = String(totalBidNumber)
                
                
                
                
            }
        })
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
