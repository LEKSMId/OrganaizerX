//
//  eventTool.swift
//  OrganaizerX
//
//  Created by Alex on 2/26/16.
//  Copyright © 2016 Alex. All rights reserved.
//

import Foundation
import EventKit


class eventTool {
    
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

//@IBAction func addEvent(sender: UIButton) {
//    let eventStore = EKEventStore()
//    
//    let startDate = NSDate()
//    let endDate = startDate.dateByAddingTimeInterval(60 * 60) // One hour
//    
//    if (EKEventStore.authorizationStatusForEntityType(.Event) != EKAuthorizationStatus.Authorized) {
//        eventStore.requestAccessToEntityType(.Event, completion: {
//            granted, error in
//            self.createEvent(eventStore, title: "DJ's Test Event", startDate: startDate, endDate: endDate)
//        })
//    } else {
//        createEvent(eventStore, title: "DJ's Test Event", startDate: startDate, endDate: endDate)
//    }
//}
//
//
//// Responds to button to remove event. This checks that we have permission first, before removing the
//// event
//@IBAction func removeEvent(sender: UIButton) {
//    let eventStore = EKEventStore()
//    
//    if (EKEventStore.authorizationStatusForEntityType(.Event) != EKAuthorizationStatus.Authorized) {
//        eventStore.requestAccessToEntityType(.Event, completion: { (granted, error) -> Void in
//            self.deleteEvent(eventStore, eventIdentifier: self.savedEventId)
//        })
//    } else {
//        deleteEvent(eventStore, eventIdentifier: savedEventId)
//    }

}
