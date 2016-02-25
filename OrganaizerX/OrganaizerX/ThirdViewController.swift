//
//  ViewController.swift
//  CalendarTest
//
//  Created by Daniel Spiess on 9/2/15.
//  Copyright © 2015 Daniel Spiess. All rights reserved.
//

import UIKit
import EventKit
import CoreData

class ThirdViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var birthdays : [Birthday] = []
    
    var nField: UITextField!
//    var dField: UITextField!
//    var fField: UITextField!

    
    var savedEventId : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        
        let request = NSFetchRequest(entityName: "Item")
        var result : [AnyObject]?
        
        do {
            result = try context.executeFetchRequest(request)
        } catch _ {
            result = nil
        }
        
        if result != nil {
            self.birthdays = result as! [Birthday]
        }
        
        self.tableView.reloadData()
        // Do any additional setup after loading the view, typically from a nib.

        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func birthdayView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.birthdays.count
    }
    
    func birthdayView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let birthday = self.birthdays[indexPath.row]
        cell.textLabel!.text = birthday.name
        return cell
    }
    
    @IBAction func addButtomPress (sender: AnyObject) {
        alertPoppup()
    }
    
//    func dateTextField(dateField: UITextField) {
//        dateField.placeholder = "Enter new Item"
//        self.dField = dateField
//    }
//    
//    func firstNameTextField(firstField: UITextField) {
//        firstField.placeholder = "Enter new Item"
//        self.fField = firstField
//    }
    
    func nameTextField(textField: UITextField) {
        textField.placeholder = "Enter new Item"
        self.nField = textField
    }
    func saveNewItem() {
        print("Item saved")
        
        let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        
        let birthday = NSEntityDescription.insertNewObjectForEntityForName("Birthday", inManagedObjectContext: context) as! Birthday
        
        birthday.name = nField.text
//        birthday.datebirthday = dField.text
//        birthday.firthname = fField.text
        
        do {
            try context.save()
        } catch _ {
        }
        
        let request = NSFetchRequest(entityName: "Bithday")
        var result : [AnyObject]?
        
        do {
            result = try context.executeFetchRequest(request)
        } catch _ {
            result = nil
        }
        
        if result != nil {
            self.birthdays = result as! [Birthday]
        }
        
        self.tableView.reloadData()
    }
    
    func alertPoppup() {
        let alert = UIAlertController(title: "Add new item", message: nil, preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) {
            UIAlertAction in
            alert.dismissViewControllerAnimated(true, completion: nil)
        }
        
        let saveAction = UIAlertAction(title: "Save", style: UIAlertActionStyle.Default) {
            UIAlertAction in
            self.saveNewItem()
        }
        
//        alert.addTextFieldWithConfigurationHandler (firstNameTextField)
        alert.addTextFieldWithConfigurationHandler (nameTextField)
//        alert.addTextFieldWithConfigurationHandler (dateTextField)
        alert.addAction(cancelAction)
        alert.addAction(saveAction)
        self.presentViewController(alert, animated: true, completion: nil)
        
    }

    
    
//    func createEvent(eventStore: EKEventStore, title: String, startDate: NSDate, endDate: NSDate) {
//        let event = EKEvent(eventStore: eventStore)
//        
//        event.title = title
//        event.startDate = startDate
//        event.endDate = endDate
//        event.calendar = eventStore.defaultCalendarForNewEvents
//        do {
//            try eventStore.saveEvent(event, span: .ThisEvent)
//            savedEventId = event.eventIdentifier
//        } catch {
//            print("Bad things happened")
//        }
//    }
//    
//    func deleteEvent(eventStore: EKEventStore, eventIdentifier: String) {
//        let eventToRemove = eventStore.eventWithIdentifier(eventIdentifier)
//        if (eventToRemove != nil) {
//            do {
//                try eventStore.removeEvent(eventToRemove!, span: .ThisEvent)
//            } catch {
//                print("Bad things happened")
//            }
//        }
//    }
//    
//    @IBAction func addEvent(sender: UIButton) {
//        let eventStore = EKEventStore()
//        
//        let startDate = NSDate()
//        let endDate = startDate.dateByAddingTimeInterval(60 * 60) // One hour
//        
//        if (EKEventStore.authorizationStatusForEntityType(.Event) != EKAuthorizationStatus.Authorized) {
//            eventStore.requestAccessToEntityType(.Event, completion: {
//                granted, error in
//                self.createEvent(eventStore, title: "DJ's Test Event", startDate: startDate, endDate: endDate)
//            })
//        } else {
//            createEvent(eventStore, title: "DJ's Test Event", startDate: startDate, endDate: endDate)
//        }
//    }
//    
//    
//    // Responds to button to remove event. This checks that we have permission first, before removing the
//    // event
//    @IBAction func removeEvent(sender: UIButton) {
//        let eventStore = EKEventStore()
//        
//        if (EKEventStore.authorizationStatusForEntityType(.Event) != EKAuthorizationStatus.Authorized) {
//            eventStore.requestAccessToEntityType(.Event, completion: { (granted, error) -> Void in
//                self.deleteEvent(eventStore, eventIdentifier: self.savedEventId)
//            })
//        } else {
//            deleteEvent(eventStore, eventIdentifier: savedEventId)
//        }
//        
//    }
}

