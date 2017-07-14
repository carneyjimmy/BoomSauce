//
//  InfoViewController.swift
//  LuckyDuck
//
//  Created by Jimmy Carney on 7/9/17.
//  Copyright © 2017 Jimmy Carney. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {
    
    @IBOutlet weak var nav: UINavigationItem!
    var isFull = false


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
    @IBOutlet weak var bidButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        bidButton.layer.cornerRadius = 20; // this value vary as per your desire
        bidButton.clipsToBounds = true
        let favimage : UIImage = UIImage(named: "fav.png")!
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imageView.contentMode = .scaleAspectFit
        imageView.image = favimage
        nav.rightBarButtonItem?.customView = imageView
        
        
        fav.image = favimage
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
