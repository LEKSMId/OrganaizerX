//
//  FirstViewController.swift
//  TabPR
//
//  Created by Alex on 2/23/16.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit
import EventKit
import CoreData

class mainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var items : [Item] = []
    var filteredItems = [Item]()
    var refreshControl: UIRefreshControl!
    var inSearchMode = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.searchBar.delegate = self
        
            
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        updateUI()
    }
    
    func updateUI() {
        let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        
        let request = NSFetchRequest(entityName: "Item")
        var result : [AnyObject]?
        
        do {
            result = try context.executeFetchRequest(request)
        } catch _ {
            result = nil
        }
        
        if result != nil {
            self.items = result as! [Item]
        }
        self.tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 5
        
        if inSearchMode{
            return filteredItems.count
        } else {
            return self.items.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        if let call = tableView.dequeueReusableCellWithIdentifier("eventCell") as? eventCell{
            
            let item: Item!
//            let item = self.items[indexPath.row]
            
            if inSearchMode {
              item = filteredItems[indexPath.row]
            } else {
                item = self.items[indexPath.row]
            }
            
            
            if inSearchMode {
                
            } else {
                
            }
            
            var imag : UIImage!
            
            if item.imageid == 0 {
                
                imag = UIImage(named: "1")
            
            } else {
            
                imag = UIImage(named: "2")
            }
            call.configureCell(imag, text: item.title!, note: item.noteEvent!)
            return call

        } else {    
            return eventCell()
        
        }
    }
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text == nil || searchBar == "" {
            inSearchMode = false
        
        } else {
        
            inSearchMode = true
            let lower = searchBar.text!.lowercaseString
            filteredItems = items.filter({$0.title?.rangeOfString(lower) != nil})
            tableView.reloadData()
    
        }
    }
    
}