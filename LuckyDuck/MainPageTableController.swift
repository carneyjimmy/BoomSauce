//
//  MainPageTableController.swift
//  LuckyDuck
//
//  Created by Jimmy Carney on 6/14/17.
//  Copyright © 2017 Jimmy Carney. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth



class MainPageTableController: UITableViewController, UISearchResultsUpdating, UISearchBarDelegate {
    

    @IBOutlet var searchTable: UITableView!
    
        var groupKey: String = ""
        var userKey: String = ""
        var titleArray = [String]()
        var priceArray = [Int]()
        var keyArray = [String]()
        var inGroupArray = [Bool]()
        var db: FIRDatabaseReference!
        var filteredUsername = [String]()
        var filteredKey = [String]()
        var filteredInGroup = [Bool]()
        var shouldShowResults: Bool = false
        
        var searchController = UISearchController()
    
        var groupName: String = ""
        var imageCache = [UIImage]()
        var bannerCache = ["","",""]
        var priceCache = ["","",""]
        var isAdmin: Bool = false
        
    
        override func viewDidLoad() {
            super.viewDidLoad()
            searchTable.delegate = self as! UITableViewDelegate
            searchTable.dataSource = self as! UITableViewDataSource
            configureSearchController()
            //db = FIRDatabase.database().reference()
            getUsernamesKeys()
            //userKey = (UserDefaults.standard.value(forKey: "user_id_taskforce")) as! String
            let bundlePath = Bundle.main.path(forResource: "basketball", ofType: "jpeg")
            let bundlePath2 = Bundle.main.path(forResource: "skateboard", ofType: "jpeg")
            let bundlePath3 = Bundle.main.path(forResource: "orderstatus3", ofType: "jpg")
            
            let image = UIImage(contentsOfFile: bundlePath!)!
            let image2 = UIImage(contentsOfFile: bundlePath2!)!
            let image3 = UIImage(contentsOfFile: bundlePath3!)!
            // Store the image in to our cache
            getNames()
            self.imageCache.append(image)
            self.imageCache.append(image2)
            self.imageCache.append(image3)
            /*
            self.bannerCache[0] = "Event one!!"
            self.bannerCache[1] = "Event two!!"
            self.bannerCache[2] = "Event three!!"
            self.priceCache[0] = "1$$"
             self.priceCache[1] = "2$$"
             self.priceCache[2] = "3$$"
            */
            
        }
    
        func configureSearchController() {
            searchController = UISearchController(searchResultsController: nil)
            searchController.searchResultsUpdater = self
            searchController.dimsBackgroundDuringPresentation = false
            searchController.searchBar.placeholder = "Search here..."
            searchController.searchBar.delegate = self
            searchController.searchBar.sizeToFit()
            searchTable.tableHeaderView = searchController.searchBar
        }
        
        func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
            shouldShowResults = true
            searchTable.reloadData()
        }
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            if !shouldShowResults {
                shouldShowResults = true
                searchTable.reloadData()
            }
            
            searchController.searchBar.resignFirstResponder()
        }
        
        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            shouldShowResults = false
            searchTable.reloadData()
        }
        func updateSearchResults(for searchController: UISearchController){
            filteredUsername.removeAll()
            filteredKey.removeAll()
            filteredInGroup.removeAll()
            
            let searchString = searchController.searchBar.text
            
            // Filter the data array and get only those countries that match the search text.
            for index in 0...titleArray.count-1{
                let userText: NSString = titleArray[index] as NSString
                if ((userText.range(of: searchString!, options: NSString.CompareOptions.caseInsensitive).location) != NSNotFound){
                    filteredUsername.append(titleArray[index])
                    filteredKey.append(keyArray[index])
                    filteredInGroup.append(inGroupArray[index])
                }
            }
            // Reload the tableview.
            searchTable.reloadData()
        }
        
        func getUsernamesKeys(){
            /*let ref = FIRDatabase.database().reference(fromURL: "https://taskforce-ad0be.firebaseio.com/users")
             ref.queryOrderedByKey().observe(.childAdded, with: { snapshot in
             
             if let _ = snapshot.value as? NSNull {
             return
             } else {
             self.keyArray.append(snapshot.key)
             let enumerator = snapshot.children
             var hasGroups = false
             while let rest = enumerator.nextObject() as? FIRDataSnapshot {
             if (rest.key == "username"){
             self.titleArray.append(rest.value as! String)
             }
             if (rest.key == "groups"){
             hasGroups = true
             let enumerator2 = rest.children
             var inGroup = false
             while let groups = enumerator2.nextObject() as? FIRDataSnapshot{
             if(groups.key == self.groupKey){
             inGroup = true
             }
             }
             self.inGroupArray.append(inGroup)
             }
             }
             if !hasGroups{
             self.inGroupArray.append(false)
             }
             self.searchTable.reloadData()
             }
             });
             */
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
        }
        //
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            searchTable.reloadData()
        }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = self.searchTable.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as! EventCell
        myCell.banner.text = titleArray[indexPath.row]
        print(priceArray[indexPath.row])
        myCell.price.setTitle("$$$" + String(priceArray[indexPath.row]), for: .normal)
        
        myCell.picture.image = imageCache[indexPath.row]
        
        

        return myCell
    }
    
    func getNames(){
        let ref = FIRDatabase.database().reference(fromURL: "https://temptitle-5df50.firebaseio.com/Events")
        ref.queryOrderedByKey().observe(.childAdded, with: { snapshot in
            
            if let _ = snapshot.value as? NSNull {
                return
            } else {
                self.keyArray.append(snapshot.key)
                
                let enumerator = snapshot.children
                
                while let rest = enumerator.nextObject() as? FIRDataSnapshot {
                    
                    if (rest.key == "Name"){
                       
                        self.titleArray.append(rest.value as! String)
                        self.tableView.reloadData()
                    }
                    if (rest.key == "Price"){
                       
                        self.priceArray.append(rest.value as! Int)
                        print(rest.value as! Int)
                        self.searchTable.reloadData()
                        
                        
                    }
                }
              
                
            }
        });
    }
    
    /*
    func addPicture(key: [String], indexPath: Int, myCell: EventCell){
        var urlString: String = ""
        let ref = FIRDatabase.database().reference(fromURL: "https://temptitle-5df50.firebaseio.com/users/\(key[indexPath])")
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            if let _ = snapshot.value as? NSNull {
                return
            } else {
                let enumerator = snapshot.children
                while let rest = enumerator.nextObject() as? FIRDataSnapshot {
                    if (rest.key == "imageURL"){
                        urlString = rest.value! as! String
                        print(urlString)
                        let url = NSURL(string: urlString)
                        
                        //myCell.setImage(profile: UIImage(named: "blank")!)
                        
                        // If this image is already cached, don't re-download
                        if let img = self.imageCache[urlString] {
                            myCell.setImage(profile: img)
                        }
                            
                        else {
                            // The image isn't cached, download the img data
                            // We should perform this in a background thread
                            let session = URLSession.shared
                            let request = NSURLRequest(url: url! as URL)
                            let dataTask = session.dataTask(with: request as URLRequest) { (data:Data?, response:URLResponse?, error:Error?) -> Void in
                                if error == nil {
                                    // Convert the downloaded data in to a UIImage object
                                    let image = UIImage(data: data!)
                                    // Store the image in to our cache
                                    self.imageCache[urlString] = image
                                    // Update the cell
                                    DispatchQueue.main.async(execute: {
                                        myCell.setImage(profile: image!)
                                    })
                                }
                                else {
                                    print("Error: \(String(describing: error?.localizedDescription))")
                                }
                            }
                            dataTask.resume()
                        }
                    }
                }
            }
        });
 
       
 
    }
 */
 override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return priceArray.count
    }
    //
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }
    //

}
