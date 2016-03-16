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
    
    var sentEventIdentify : String = ""
    var items : [Item] = []
    var itemsSort = []
    var filteredItems = [Item]()
    var refreshControl: UIRefreshControl!
    var inSearchMode = false
    var numberIdEvent : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.searchBar.delegate = self
    
        sortEvent()
    
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }

    override func viewWillAppear(animated: Bool) {
        updateUI()
        sortEvent()
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

        if inSearchMode{
        
            return filteredItems.count
        
        } else {
            
            return self.items.count
        
        }
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let item = items[indexPath.row]
        
        sentEventIdentify = item.identifier!
        
        self.numberIdEvent = indexPath.row
        
      
    }
    
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == .Delete {
            self.deleteEvent(indexPath.row)
        }
    }
    
    func sortEvent() {
        
        items = self.items.sort{$0.date!.compare($1.date!) == NSComparisonResult.OrderedAscending }
        tableView.reloadData()
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if let call = tableView.dequeueReusableCellWithIdentifier("eventCell") as? eventCell{
            
            let item: Item!
            
            if inSearchMode {
              item = filteredItems[indexPath.row]
            } else {
                item = self.items[indexPath.row]
            }
            
            var dateStr: String {
                let dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "dd-MM-yyyy"
                return dateFormatter.stringFromDate(item.date!)
            }
            
            var imag : UIImage!
            
            if item.imageid == 0 {
                
                imag = UIImage(named: "1")
            
            } else {
            
                imag = UIImage(named: "2")
            }
            call.configureCell(imag, text: item.title!, date: dateStr)
            return call
        } else {
            return eventCell()
        }
    }
    
   
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text == nil || searchBar.text == ""{
            inSearchMode = false
            tableView.reloadData()
        } else {
            
            inSearchMode = true
            let lower = searchBar.text!
            filteredItems = items.filter({$0.title?.rangeOfString(lower) != nil})
            tableView.reloadData()
    
        }
    }
    
    func deleteEvent(atIndex: Int) {
        
        self.removeEvent(atIndex)

        let appDelegate    = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let objectToRemove = items[atIndex] as NSManagedObject
        
        managedContext.deleteObject(objectToRemove)
        
        do
        {
            try managedContext.save()
        }
        catch
        {
            print("There is some error while updating CoreData.")
        }
        
        items.removeAtIndex(atIndex)
        tableView.reloadData()
    }
    
    
    func deleteEventKit(eventStore: EKEventStore, eventIdentifier: String) {
        let eventToRemove = eventStore.eventWithIdentifier(eventIdentifier)
        if (eventToRemove != nil) {
            do {
                try eventStore.removeEvent(eventToRemove!, span: .ThisEvent)
            } catch {
                print("Bad things happened")
            }
        }
    }
    
    
    func removeEvent(atIndex: Int) {
        
        let item = items[atIndex]
        
        let eventStore = EKEventStore()
        
        if (EKEventStore.authorizationStatusForEntityType(.Event) != EKAuthorizationStatus.Authorized) {
            eventStore.requestAccessToEntityType(.Event, completion: { (granted, error) -> Void in
                self.deleteEventKit(eventStore, eventIdentifier: item.identifier!)
            })
        } else {
            deleteEventKit(eventStore, eventIdentifier: item.identifier!)
            }
        
        }

}