//
//  FirstViewController.swift
//  TabPR
//
//  Created by Alex on 2/23/16.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController{
    
    
//    @IBOutlet weak var tableView: UITableView!
//    
//    var items : [Item] = []
//    
//    var iField: UITextField!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
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
//        // Do any additional setup after loading the view, typically from a nib.
//    }
//    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.items.count
//    }
//    
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let call = UITableViewCell()
//        let item = self.items[indexPath.row]
//        call.textLabel!.text = item.title
//        return call
//    }
//    
//    @IBAction func addButtomPress (sender: AnyObject) {
//        alertPoppup()
//    }
//    
//    func conficurationTextField(textField: UITextField) {
//        textField.placeholder = "Enter new Item"
//        self.iField = textField
//    }
//    
//    func saveNewItem() {
//        print("Item saved")
//        
//        let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
//        
//        let item = NSEntityDescription.insertNewObjectForEntityForName("Item", inManagedObjectContext: context) as! Item
//        
//        item.title = iField.text
//        
//        do {
//           try context.save()
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
//    }
//    
//    func alertPoppup() {
//        let alert = UIAlertController(title: "Add new item", message: nil, preferredStyle: .Alert)
//        
//        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) {
//            UIAlertAction in
//            alert.dismissViewControllerAnimated(true, completion: nil)
//        }
//        
//        let saveAction = UIAlertAction(title: "Save", style: UIAlertActionStyle.Default) {
//                UIAlertAction in
//                self.saveNewItem()
//        }
//            alert.addTextFieldWithConfigurationHandler (conficurationTextField)
//            alert.addAction(cancelAction)
//            alert.addAction(saveAction)
//        self.presentViewController(alert, animated: true, completion: nil)
//    
//        }
//    
}

