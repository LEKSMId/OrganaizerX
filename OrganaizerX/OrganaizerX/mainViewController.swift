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
    @IBOutlet weak var noteField: UITextField!
    @IBOutlet weak var switcher: UISegmentedControl!
    
    let dateFormatter = NSDateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.dataSource = self
        self.tableView.delegate = self

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

            if let cell = tableView.dequeueReusableCellWithIdentifier("EventCell")
                as? eventCell {
                    
                return cell
            } else {
                return cell
        }
        
//        let call = UITableViewCell()
//        let item = self.items[indexPath.row]
//       let call.textLabel!.text = "test text"
//            item.title
        
//        return call
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
        let noteEvent = noteField.text! as String
        if switcher.selectedSegmentIndex == 0 {
        
            let startDate = pickerDate.date
            let endDate = startDate.dateByAddingTimeInterval(24 * 60 * 60)
            
            if (EKEventStore.authorizationStatusForEntityType(.Event) != EKAuthorizationStatus.Authorized) {
                eventStore.requestAccessToEntityType(.Event, completion: {
                    
                    granted, error in
                    self.createEvent(eventStore, title: nameEvent, startDate: startDate, endDate: endDate, note: noteEvent)
                })
            } else {
                createEvent(eventStore, title: nameEvent, startDate: startDate, endDate: endDate, note: noteEvent)
            }
        } //else {
//            
//            let startDate = pickerDateTime.
//            
//            let endDate = startDate.dateByAddingTimeInterval(24 * 60 * 60)
//                    
//            if (EKEventStore.authorizationStatusForEntityType(.Event) != EKAuthorizationStatus.Authorized) {
//            eventStore.requestAccessToEntityType(.Event, completion: {
//            granted, error in
//                self.createEvent(eventStore, title: nameEvent, startDate: startDate, endDate: endDate, note: noteEvent)
//            })
//            } else {
//                createEvent(eventStore, title: nameEvent, startDate: startDate, endDate: endDate, note: noteEvent)
//            }
//            

//        }
    }
    
    @IBAction func saveEvent(sender: AnyObject) {
        sendEventInfo()
    }
    
    var savedEventId : String = ""
    
    func createEvent(eventStore: EKEventStore, title: String, startDate: NSDate, endDate: NSDate, note: String) {
        let event = EKEvent(eventStore: eventStore)

//        let firstSaturdayMarch2015DateComponents = NSDateComponents()
//        firstSaturdayMarch2015DateComponents.year = 2015
//        firstSaturdayMarch2015DateComponents.month = 3
//        firstSaturdayMarch2015DateComponents.weekday = 7
//        firstSaturdayMarch2015DateComponents.weekdayOrdinal = 1
//        firstSaturdayMarch2015DateComponents.hour = 11
//        firstSaturdayMarch2015DateComponents.minute = 0
//        firstSaturdayMarch2015DateComponents.timeZone = NSTimeZone(name: "US/Eastern")

        event.title = title
        event.notes = note
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
    
}