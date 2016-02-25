//
//  FirstViewController.swift
//  TabPR
//
//  Created by Alex on 2/23/16.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var pickerDate: UIDatePicker!
    @IBOutlet weak var pickerDateTime: UIDatePicker!
    
    @IBOutlet weak var titleEvent: UITextField!
    @IBOutlet weak var switcher: UISegmentedControl!
    
    let dateFormatter = NSDateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    }
}

//