//
//  WishListController.swift
//  LuckyDuck
//
//  Created by Jimmy  Carney on 8/5/17.
//  Copyright © 2017 Jimmy Carney. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class WishListController: UITableViewController , UISearchResultsUpdating, UISearchBarDelegate   {

    
    @IBOutlet weak var search: UISearchBar!
    @IBOutlet var searchTable: UITableView!
  
    
    
    @IBOutlet weak var nav: UINavigationItem!
    
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
    
    var bannerCache = ["","",""]
    var priceCache = ["","",""]
    var isAdmin: Bool = false
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* make sure service bar is white */
        self.setNeedsStatusBarAppearanceUpdate()
        
        /*
         *
         set up search bar
         *
         */
        
        searchTable.delegate = self as UITableViewDelegate
        searchTable.dataSource = self as UITableViewDataSource
        configureSearchController()
        
        /*
         *
         get user
         *
         */
        getUsernamesKeys()
        
        
        
        
        /*
         *
         logo
         *
         */
        let navpath = Bundle.main.path(forResource: "onetime", ofType: "png")
        let imageNav = UIImage(contentsOfFile: navpath!)!
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 35))
        imageView.contentMode = .scaleAspectFit
        imageView.image = imageNav
        nav.titleView = imageView
        
        
        getNames()
        
    }
    
    func configureSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self as? UISearchResultsUpdating
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.barTintColor = UIColor.white
        let textFieldInsideSearchBar = searchController.searchBar.value(forKey: "searchField") as? UITextField
        
        
        /*    custom image if works
         
         
         
         let searchimage : UIImage = UIImage(named: "search.png")!
         searchController.searchBar.backgroundImage = searchimage
         searchController.searchBar.image(for: .search, state: .normal)
         */
        textFieldInsideSearchBar?.backgroundColor = UIColor(red: 221/255.0, green: 221/255.0, blue: 221/255.0, alpha: 0.8)
        textFieldInsideSearchBar?.layer.cornerRadius = 10
        textFieldInsideSearchBar?.clipsToBounds = true
        
        searchController.searchBar.layer.borderWidth = 1
        searchController.searchBar.layer.borderColor = (UIColor.white.cgColor)
        
        
        
        
        textFieldInsideSearchBar?.textColor = UIColor.lightGray
        searchController.searchBar.placeholder = "Search here"
        
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
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    var pickerData = ["ALL", "FEATURED", "SPORTS", "GETAWAYS", "LESSONS", "FOOD"]
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.row == 0) {
            let myCell = self.searchTable.dequeueReusableCell(withIdentifier: "PickerCell", for: indexPath) as! PickerCell
            return myCell
            
        }
        else {
            print(titleArray[indexPath.row - 1] + "jkl")
            
            let myCell = self.searchTable.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as! EventCell
            myCell.banner.text = titleArray[indexPath.row - 1]
            print(priceArray[indexPath.row - 1])
            myCell.price.text  = ("$" + String(priceArray[indexPath.row - 1]))
            
            
            /* set up picture    */
            myCell.picture.image = imageCache[indexPath.row - 1]
            
            /*curve corner */
            myCell.picture.layer.cornerRadius = 10
            myCell.picture.clipsToBounds = true
            
            
            /* black overlay  */
            let overlay: UIView = UIView(frame: CGRect(x: 0, y: 0, width: myCell.picture.frame.size.width + 100, height:  myCell.picture.frame.size.height))
            overlay.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.1)
            myCell.picture.addSubview(overlay)
            
            
            /* outline / shadow  */
            
            myCell.picture.layer.shadowColor = UIColor.darkGray.cgColor
            myCell.picture.layer.shadowOffset = CGSize(width: 1, height: 1)
            myCell.picture.layer.shadowOpacity = 1
            myCell.picture.layer.shadowRadius = 1.0
            
            myCell.picture.layer.shouldRasterize = true
            myCell.picture.layer.rasterizationScale = true ? UIScreen.main.scale : 1
            
            /*
             myCell.picture.layer.masksToBounds = false
             myCell.picture.layer.shadowColor = UIColor.black.cgColor
             myCell.picture.layer.shadowOpacity = 0.5
             myCell.picture.layer.shadowOffset = CGSize(width: -1, height: 1)
             myCell.picture.layer.shadowRadius = 1
             
             
             */
            
            myCell.picture.layer.shadowPath = UIBezierPath(rect: myCell.picture.bounds).cgPath
            
            
            return myCell
        }
        
    }
    func getNames(){
        let ref = FIRDatabase.database().reference(fromURL: "https://temptitle-5df50.firebaseio.com/Events/")
        ref.queryOrderedByKey().observe(.childAdded, with: { snapshot in
            
            if let _ = snapshot.value as? NSNull {
                return
            }
            else {
                
                self.keyArray.append(snapshot.key)
                
                
                
                
                let enumerator = snapshot.children
                
                while let rest = enumerator.nextObject() as? FIRDataSnapshot {
                    
                    if (rest.key == "Name"){
                        
                        self.titleArray.append(rest.value as! String)
                        self.tableView.reloadData()
                    }
                    if (rest.key == "Price"){
                        
                        self.priceArray.append(rest.value as! Int)
                        
                        self.searchTable.reloadData()
                        
                        
                    }
                    if (rest.key == "Image"){
                        let url = URL(string: rest.value as! String)
                        let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                        imageCache.append(UIImage(data: data!)!)
                        
                        
                    }
                }
                
                
            }
        });
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedName = keyArray[indexPath.row - 1]
        selectedInt = indexPath.row - 1
        
        
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
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if (indexPath.row == 0){
            return 45.0;//Choose your custom row height}
        }
        else{
            return 220.0
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return priceArray.count + 1
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }
    
    
    
    


}
