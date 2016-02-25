//
//  FirstViewController.swift
//  TabPR
//
//  Created by Alex on 2/23/16.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit
import CoreData

class mainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var items : [Item] = []
    
    @IBOutlet weak var pickerDate: UIDatePicker!
    @IBOutlet weak var pickerDateTime: UIDatePicker!
    
    @IBOutlet weak var titleEvent: UITextField!
    @IBOutlet weak var switcher: UISegmentedControl!
    
    let dateFormatter = NSDateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//
//        self.tableView.dataSource = self
//        self.tableView.delegate = self
//        
//        let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
//        
//        let request = NSFetchRequest(entityName: "Item")
//        var result : [AnyObject]?
//        
//        do {
//            result = try context.executeFetchRequest(request)
//        } catch _ {
//            result = nil
//        }
//        
//        if result != nil {
//            self.items = result as! [Item]
//        }
//        
//        self.tableView.reloadData()
//        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
//            self.items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let call = UITableViewCell()
//        let item = self.items[indexPath.row]
        call.textLabel!.text = "test text"
//            item.title
        return call
    }
    
    func saveNewItem() {
        print("Item saved")
        
//        let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
//        
//        let item = NSEntityDescription.insertNewObjectForEntityForName("Item", inManagedObjectContext: context) as! Item
//        
//        item.title = titleEvent.text
//        
//        do {
//            try context.save()
//        } catch _ {
//        }
//        
//        let request = NSFetchRequest(entityName: "Item")
//        var result : [AnyObject]?
//        
//        do {
//            result = try context.executeFetchRequest(request)
//        } catch _ {
//            result = nil
//        }
//        
//        if result != nil {
//            self.items = result as! [Item]
//        }
//        
//        self.tableView.reloadData()
    }
    
    
    
    func setDateAndTime() {
        var prDate: String
        if pickerDateTime.hidden == true {
            dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
            prDate = dateFormatter.stringFromDate(pickerDate.date)
            print("\(prDate)")
        } else {
            var dateFormatter = NSDateFormatter()
            dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
            dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
            prDate = dateFormatter.stringFromDate(pickerDateTime.date)
            print("\(prDate)")
            
        }
    }
    
    @IBAction func indexChanged(sender: UISegmentedControl) {
        switch switcher.selectedSegmentIndex {
        case 0:
            pickerDate.hidden = true
            pickerDateTime.hidden = false
        case 1:
            pickerDate.hidden = false
            pickerDateTime.hidden = true
        default:
            break;
        }
    }
    
    @IBAction func saveEvent(sender: AnyObject) {
        setDateAndTime()
//        saveNewItem()
    }
}