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

class addEvent: UIViewController, UITextFieldDelegate {

    var items : [Item] = []
    var alartTime : Double = 0
    
    @IBOutlet weak var pickerDate: UIDatePicker!
    @IBOutlet weak var pickerDateTime: UIDatePicker!
    
    @IBOutlet weak var titleEvent: UITextField!
    @IBOutlet weak var noteField: UITextField!
    
    @IBOutlet weak var powerAlert: UISwitch!
    @IBOutlet weak var eventTypeSwitcher: UISegmentedControl!
    @IBOutlet weak var alertSwitcherBirthday: UISegmentedControl!
    @IBOutlet weak var alertSwitcherEvent: UISegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
        self.titleEvent.delegate = self;
        self.noteField.delegate = self;
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        return 5
        return self.items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if let call = tableView.dequeueReusableCellWithIdentifier("eventCell") as? eventCell{
            
            let item = self.items[indexPath.row]
            
            var imag : UIImage!
            
            if item.imageid == 0 {
                
                imag = UIImage(named: "1")
                
            } else {
                
                imag = UIImage(named: "2")
            }
            
            var dateStr: String {
                let dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "dd-MM-yyyy"
                return dateFormatter.stringFromDate(item.date!)
            }
            
            call.configureCell(imag, text: item.title!, note: item.noteEvent!, date: dateStr)
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
        if eventTypeSwitcher.selectedSegmentIndex == 0 {
            item.date = pickerDate.date
        } else {
            item.date = pickerDateTime.date
        }
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
    
    @IBAction func alertSelect(sender: UISwitch) {
        
        if powerAlert.on {
            alertSwitcherBirthday.hidden = true
            alertSwitcherEvent.hidden = true
        } else if eventTypeSwitcher.selectedSegmentIndex == 0{
            alertSwitcherBirthday.hidden = false
            alertSwitcherEvent.hidden = true
        } else if eventTypeSwitcher.selectedSegmentIndex == 1{
            alertSwitcherEvent.hidden = false
            alertSwitcherBirthday.hidden = true
        }
        
    }
    
    @IBAction func timeAlertSetBirthday(sender: UISegmentedControl) {
        switch alertSwitcherBirthday.selectedSegmentIndex {
        case 0:
            print("In time")
            alartTime = 0
        case 1:
            print("alertTime 1 День")
            alartTime = 60 * 60 * 24
        case 2:
            print("alertTime 2 дня")
            alartTime = 60 * 60 * 24 * 2
        case 3:
            print("alertTime 1 неделя")
            alartTime = 60 * 60 * 24 * 7
        default:
            alartTime = 0;
        }
    }
    
    
    
    @IBAction func timeAlertSetEvent(sender: UISegmentedControl){
            switch alertSwitcherEvent.selectedSegmentIndex {
                case 0:
                    print("alertTime 15 min")
                    alartTime = 60 * 15
                case 1:
                    print("alertTime 1 hour")
                    alartTime = 60 * 60
                case 2:
                    print("alertTime 2 hour")
                    alartTime = 60 * 60 * 2
                case 3:
                    print("alertTime 1 День")
                    alartTime = 60 * 60 * 24
                case 4:
                    print("alertTime 2 дня")
                    alartTime = 60 * 60 * 24 * 2
                case 5:
                    print("alertTime 1 неделя")
                    alartTime = 60 * 60 * 24 * 7
                default:
                    alartTime = 60 * 15;
            }
    }
    
    @IBAction func indexChanged(sender: UISegmentedControl) {
        switch eventTypeSwitcher.selectedSegmentIndex {
        case 0:
            if powerAlert.on {
                alertSwitcherBirthday.hidden = true
                alertSwitcherEvent.hidden = true
            } else if eventTypeSwitcher.selectedSegmentIndex == 0{
                alertSwitcherBirthday.hidden = false
                alertSwitcherEvent.hidden = true
            } else if eventTypeSwitcher.selectedSegmentIndex == 1{
                alertSwitcherEvent.hidden = false
                alertSwitcherBirthday.hidden = true
            }
            pickerDate.hidden = false
            pickerDateTime.hidden = true
        case 1:
            if powerAlert.on {
                alertSwitcherBirthday.hidden = true
                alertSwitcherEvent.hidden = true
            } else if eventTypeSwitcher.selectedSegmentIndex == 0{
                alertSwitcherBirthday.hidden = false
                alertSwitcherEvent.hidden = true
            } else if eventTypeSwitcher.selectedSegmentIndex == 1{
                alertSwitcherEvent.hidden = false
                alertSwitcherBirthday.hidden = true
            }
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
                    print(self.alartTime)
                    
                })
            } else {
                if eventTypeSwitcher.selectedSegmentIndex == 0 {
                    createEvent(eventStore, title: nameEvent, startDate: startDate, endDate: endDate, note: noteEvent, allDay: true, alarmSetTime:  alartTime)
                    print("24 hour")
                    print(alartTime)

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
                        print(self.alartTime)
                    })
                    } else {
                        createEvent(eventStore, title: nameEvent, startDate: startDate, endDate: endDate, note: noteEvent, allDay: false, alarmSetTime: alartTime)
            print("1 hour")
                        print(alartTime)
                        print("\(startDate)")
            }
        
        
        }
    }
    
    func clearTextField() {
        titleEvent.text = ""
        noteField.text = ""
    }
    
    @IBAction func saveEvent(sender: AnyObject) {
        sendEventInfo()
        saveNewItem()
        clearTextField()
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
    
    @IBAction func backEventList(){
        navigationController?.popToRootViewControllerAnimated(true)
    }
    
}