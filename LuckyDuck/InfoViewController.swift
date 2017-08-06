//
//  InfoViewController.swift
//  LuckyDuck
//
//  Created by Jimmy Carney on 7/9/17.
//  Copyright © 2017 Jimmy Carney. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

var mybidnumber = 1
var totalBidNumber = 403


//grey 
//all caps
//search 

//top space and left should be the same
//descirption a bit more up

//my bids - all caps

//SHAWDOW on bottom - blur (5)

// white top is bigger  than width

//button higher
//keep height move tall


class InfoViewController: UIViewController {

    
    @IBOutlet weak var navbar: UINavigationItem!
    @IBOutlet weak var descriptionLabel: UILabel!
    

    
    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var picture: UIImageView!
    
    @IBOutlet weak var favButton: UIButton!
    
   
    var isFull = false



/*    @IBAction func changeFav(_ sender: Any) {
        print("here!")
        if (isFull){
            let favimage : UIImage = UIImage(named: "fav.png")!
            let picture = UIpicture(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
            picture.contentMode = .scaleAspectFit
            picture.image = favimage
     
            
            
            fav.image = favimage
            isFull = !isFull
        }
        else {
            let favimage : UIImage = UIImage(named: "favFill.png")!
            let picture = UIpicture(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
            picture.contentMode = .scaleAspectFit
            picture.image = favimage
            nav.rightBarButtonItem?.customView = picture
            
            
            fav.image = favimage
            isFull = !isFull
        }
        
        
    }
    */
    

    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        
        /* back burron color */
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        
     
        
  
        /* set picture (change to function call) then set overlay */
        getPicture()
        
           }
    
    override func viewWillAppear(_ animated: Bool) {
        getLabels()
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
                self.callback(imageurl: imageurl)
            }
        })
    
        
    }
    
    func callback (imageurl: String) {
        
        picture.image = imageCache[selectedInt]
        
        /* set black overlay */
        let overlay: UIView = UIView(frame: CGRect(x: 0, y: 0, width: picture.frame.size.width + 100, height:  picture.frame.size.height))
        overlay.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.35)
        picture.addSubview(overlay)
        
        /* set logo at top  */
        
        let imageNav : UIImage = UIImage(named: "onetime.png")!
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imageView.contentMode = .scaleAspectFit
        imageView.image = imageNav
        navbar.titleView = imageView
        
        
        /* set up image for favorte button */
        let favimage : UIImage = UIImage(named: "bluestar.png")!
        let star = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        star.contentMode = .scaleAspectFit
        star.image = favimage
        favButton.setImage(favimage, for: .normal)
        favButton.imageView?.contentMode = .scaleAspectFit
        
        
        /* make image 'pop' with shadow */
        picture.layer.shadowColor = UIColor.darkGray.cgColor
        picture.layer.shadowOffset = CGSize(width: 1, height: 1)
        picture.layer.shadowOpacity = 1
        picture.layer.shadowRadius = 1.0
        
        picture.layer.shouldRasterize = true
        picture.layer.rasterizationScale = true ? UIScreen.main.scale : 1
        
        /*  get the firebase data for labels */
        getLabels()
        
        // Do any additional setup after loading the view.
        

    }
    
    
    func getLabels(){
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
               
                
                self.eventName.text = name
                self.descriptionLabel.text = description
              
               // self.priceButton.setTitle("$" + String(price) + "0", for: UIControlState.normal)
              //  self.totalBids.titleLabel?.text = String(totalBidNumber)
                
                /*
                let longestWordRange = (longString as NSString).rangeOfString(longestWord)
                
                let attributedString = NSMutableAttributedString(string: longString, attributes: [NSFontAttributeName : UIFont.systemFontOfSize(20)])
                
                attributedString.setAttributes([NSFontAttributeName : UIFont.boldSystemFontOfSize(20), NSForegroundColorAttributeName : UIColor.redColor()], range: longestWordRange)
                
                
                label.attributedText = attributedString
 
 */
                
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
