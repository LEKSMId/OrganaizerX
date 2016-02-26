//
//  FirstViewController.swift
//  TabPR
//
//  Created by Alex on 2/23/16.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit
import CoreData
import EventKit

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
    
    
//    
//    func setDateAndTime() {
//        var prDate: String
//        if pickerDateTime.hidden == true {
//            dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
//            prDate = dateFormatter.stringFromDate(pickerDate.date)
//            print("\(prDate)")
//        } else {
//            var dateFormatter = NSDateFormatter()
//            dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
//            dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
//            prDate = dateFormatter.stringFromDate(pickerDateTime.date)
//            print("\(prDate)")
//            
//        }
//    }
    
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
    
    func sendEventInfo(){
        
        let eventStore = EKEventStore()
        let nameEvent = titleEvent.text! as String

        let startDate = NSDate()
        let endDate = startDate.dateByAddingTimeInterval(60 * 60) // One hour

        if (EKEventStore.authorizationStatusForEntityType(.Event) != EKAuthorizationStatus.Authorized) {
            eventStore.requestAccessToEntityType(.Event, completion: {
                granted, error in
                self.createEvent(eventStore, title: nameEvent, startDate: startDate, endDate: endDate)
            })
        } else {
            createEvent(eventStore, title: nameEvent, startDate: startDate, endDate: endDate)
        }

    }
    
    @IBAction func saveEvent(sender: AnyObject) {
//        setDateAndTime()
        sendEventInfo()
        //saveNewItem()
    }
    
    var savedEventId : String = ""
    
    func createEvent(eventStore: EKEventStore, title: String, startDate: NSDate, endDate: NSDate) {
        let event = EKEvent(eventStore: eventStore)
        
        event.title = title
        event.startDate = startDate
        event.endDate = endDate
        event.calendar = eventStore.defaultCalendarForNewEvents
        do {
            try eventStore.saveEvent(event, span: .ThisEvent)
            savedEventId = event.eventIdentifier
        } catch {
            print("Bad things happened")
        }
    }
    
    // Removes an event from the EKEventStore. The method assumes the eventStore is created and
    // accessible
    
    func deleteEvent(eventStore: EKEventStore, eventIdentifier: String) {
        let eventToRemove = eventStore.eventWithIdentifier(eventIdentifier)
        if (eventToRemove != nil) {
            do {
                try eventStore.removeEvent(eventToRemove!, span: .ThisEvent)
            } catch {
                print("Bad things happened")
            }
        }
    }
    
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
    
    
    // Responds to button to remove event. This checks that we have permission first, before removing the
    // event
    @IBAction func removeEvent(sender: UIButton) {
        let eventStore = EKEventStore()
    
        if (EKEventStore.authorizationStatusForEntityType(.Event) != EKAuthorizationStatus.Authorized) {
            eventStore.requestAccessToEntityType(.Event, completion: { (granted, error) -> Void in
                self.deleteEvent(eventStore, eventIdentifier: self.savedEventId)
            })
        } else {
            deleteEvent(eventStore, eventIdentifier: savedEventId)
        }
    }
}