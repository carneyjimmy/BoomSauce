//
//  WinPageViewController.swift
//  LuckyDuck
//
//  Created by Jimmy  Carney on 8/5/17.
//  Copyright © 2017 Jimmy Carney. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import FirebaseCore

class WinPageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    var titleArray = [String]()

    var pages = [UIViewController]()
    

    
    override func viewDidLoad() {
      
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
       
        self.pages.append(self.viewControllerAtIndex(index: 0)!)
        self.setViewControllers(self.pages, direction: .forward, animated: false, completion: nil)
        
        
       
        
        
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
            
        
    }
    

    
    func viewControllerAtIndexMock(index: Int) -> UIViewController? {
        
       
        
        let storyBoard = UIStoryboard(name: "Main",
                                      bundle: Bundle.main)
        
        let dataViewController = storyBoard.instantiateViewController(withIdentifier: "WinView2")
        
        
        return dataViewController
    }
    
    func viewControllerAtIndex(index: Int) -> ClaimWinViewController? {
        
        if (keyArray.count == 0) ||
            (index >= imageCache.count) {
            return nil
        }
        
        let storyBoard = UIStoryboard(name: "Main",
                                      bundle: Bundle.main)
        
        let dataViewController = storyBoard.instantiateViewController(withIdentifier: "WinView") as! ClaimWinViewController
        dataViewController.id = keyArray[index]

        return dataViewController
    }
    
    
   
    func indexOfViewController(viewController: ClaimWinViewController) -> Int {
       
        for i in 0 ..< keyArray.count {
            if (keyArray[i] == viewController.id){
                return i
            }
        }
       
        return NSNotFound
        
    }
    
   
  
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController?
    {
        var index = indexOfViewController(viewController: viewController as! ClaimWinViewController)
    
        if  (index == 0 || index == NSNotFound ){
            return nil
        }
    
        index -= 1
        return viewControllerAtIndex(index: index)!
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        
        var index = indexOfViewController(viewController: viewController as! ClaimWinViewController)
        if index == NSNotFound {
            return nil
        }
       
        
        index += 1
        if index == keyArray.count {
            return nil
        }
        return viewControllerAtIndex(index: index)
    }
    
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return keyArray.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        
        return 0
        
        
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
