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
    
    @IBOutlet weak var birthdayView: UITableView!
    
    var birthdays : [Birthday] = []
    
    var tField: UITextField!
    
    var savedEventId : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.birthdayView.dataSource = self
        self.birthdayView.delegate = self
        
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
        
        self.birthdayView.reloadData()
        // Do any additional setup after loading the view, typically from a nib.

        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.birthdays.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let call = UITableViewCell()
        let birthday = self.birthdays[indexPath.row]
        call.textLabel!.text = birthday.name
        return call
    }
    
    @IBAction func addButtomPress (sender: AnyObject) {
        alertPoppup()
    }
    
    func conficurationTextField(textField: UITextField) {
        textField.placeholder = "Enter new Item"
        self.tField = textField
    }
    
    func saveNewItem() {
        print("Item saved")
        
        let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        
        let birthday = NSEntityDescription.insertNewObjectForEntityForName("Birthday", inManagedObjectContext: context) as! Birthday
        
        birthday.name = tField.text
        
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
        
        self.birthdayView.reloadData()
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
        alert.addTextFieldWithConfigurationHandler (conficurationTextField)
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

