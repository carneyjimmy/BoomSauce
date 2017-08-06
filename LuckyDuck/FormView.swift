//
//  FormView.swift
//  LuckyDuck
//
//  Created by Jimmy  Carney on 8/5/17.
//  Copyright © 2017 Jimmy Carney. All rights reserved.
//

import UIKit

class FormView: UIViewController {
    @IBOutlet weak var picture: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func Ha(_ sender: Any) {
        let navpath = Bundle.main.path(forResource: "ha", ofType: "png")
        picture.image = UIImage(contentsOfFile: navpath!)!
        
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
