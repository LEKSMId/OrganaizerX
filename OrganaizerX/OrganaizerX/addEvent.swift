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

class addEvent: UIViewController {

    var items : [Item] = []
    var alartTime : Double = 0
    
    @IBOutlet weak var pickerDate: UIDatePicker!
    @IBOutlet weak var pickerDateTime: UIDatePicker!
    
    @IBOutlet weak var titleEvent: UITextField!
    @IBOutlet weak var noteField: UITextField!
    
    @IBOutlet weak var eventTypeSwitcher: UISegmentedControl!
    @IBOutlet weak var alertSwitcher: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        return 5
        return self.items.count
    }
    
    //    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    //        let cell = tableView.dequeueReusableCellWithIdentifier("eventCell", forIndexPath: indexPath) as! UITableViewCell
    //        cell.textLabel?.text = data[indexPath.row]
    //        return cell
    //    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if let call = tableView.dequeueReusableCellWithIdentifier("eventCell") as? eventCell{
            
            let item = self.items[indexPath.row]
            
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
    
    func saveNewItem() {
        
        print("Item saved")
        
        let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        let item = NSEntityDescription.insertNewObjectForEntityForName("Item", inManagedObjectContext: context) as! Item
        
        item.title = titleEvent.text
        item.date = pickerDate.date
        item.imageid = eventTypeSwitcher.selectedSegmentIndex
        item.noteEvent = noteField.text
        item.identifier = savedEventId
        
        do {
            try context.save()
        } catch _ {
        }
        
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
        
    }
    
    @IBAction func indexChanged(sender: UISegmentedControl) {
        switch eventTypeSwitcher.selectedSegmentIndex {
        case 0:
            pickerDate.hidden = false
            pickerDateTime.hidden = true
        case 1:
            pickerDate.hidden = true
            pickerDateTime.hidden = false
        default:
            break;
        }
    }
    
    func sendEventInfo(){
        
        let eventStore = EKEventStore()
        let nameEvent = titleEvent.text! as String
        let noteEvent = noteField.text! as String
        
        if eventTypeSwitcher.selectedSegmentIndex == 0 {
            
            let startDate = pickerDate.date
            let endDate = pickerDate.date
            
            if (EKEventStore.authorizationStatusForEntityType(.Event) != EKAuthorizationStatus.Authorized) {
                eventStore.requestAccessToEntityType(.Event, completion: {
                    granted, error in
                    self.createEvent(eventStore, title: nameEvent, startDate: startDate, endDate: endDate, note: noteEvent, allDay: true, alarmSetTime: self.alartTime)
                    print("24 hour")
                    
                })
            } else {
                if eventTypeSwitcher.selectedSegmentIndex == 0 {
                    createEvent(eventStore, title: nameEvent, startDate: startDate, endDate: endDate, note: noteEvent, allDay: true, alarmSetTime:  alartTime)
                    print("24 hour")

                }
            }
        } else {
        
                    let startDate = pickerDateTime.date
        
                    let endDate = startDate.dateByAddingTimeInterval(60 * 60)
        
                    if (EKEventStore.authorizationStatusForEntityType(.Event) != EKAuthorizationStatus.Authorized) {
                    eventStore.requestAccessToEntityType(.Event, completion: {
                    granted, error in
                        self.createEvent(eventStore, title: nameEvent, startDate: startDate, endDate: endDate, note: noteEvent, allDay: false, alarmSetTime:  self.alartTime)
                        print("1 hour")
                    })
                    } else {
                        createEvent(eventStore, title: nameEvent, startDate: startDate, endDate: endDate, note: noteEvent, allDay: false, alarmSetTime: alartTime)
            print("1 hour")
            }
        
        
        }
    }
    
    @IBAction func saveEvent(sender: AnyObject) {
        sendEventInfo()
        saveNewItem()
    }
    
    var savedEventId : String = ""
    
    func createEvent(eventStore: EKEventStore, title: String, startDate: NSDate, endDate: NSDate, note: String, allDay: Bool, alarmSetTime: NSTimeInterval) {
        let event = EKEvent(eventStore: eventStore)
        let alarm = EKAlarm(relativeOffset: alarmSetTime)
        event.title = title
        event.notes = note
        event.startDate = startDate
        event.endDate = endDate
        event.allDay = allDay
        event.addAlarm(alarm)
        event.calendar = eventStore.defaultCalendarForNewEvents
        do {
            try eventStore.saveEvent(event, span: .ThisEvent)
            savedEventId = event.eventIdentifier
        } catch {
            print("Bad things happened")
        }
    }
    

    
    @IBAction func timeAlertSet(sender: UISegmentedControl) {
        switch alertSwitcher.selectedSegmentIndex {
        case 0:
            alartTime = 60 * 60
        case 1:
            alartTime = 24 * 60 * 60
        case 2:
            alartTime = 24 * 60 * 60 * 2
        case 3:
            alartTime = 24 * 60 * 60 * 7
        default:
            break;
        }
    }
    
    
    
    @IBAction func backEventList(){
        navigationController?.popToRootViewControllerAnimated(true)
    }
    
}