//
//  FirstViewController.swift
//  TabPR
//
//  Created by Alex on 2/23/16.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var picker: UIDatePicker!
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
        dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
        prDate = dateFormatter.stringFromDate(picker.date)
        print("\(prDate)")
    }
    
    @IBAction func indexChanged(sender: UISegmentedControl) {
        switch switcher.selectedSegmentIndex {
        case 0:
            picker.hidden = true
//            popularView.hidden = false
        case 1:
            picker.hidden = false
//            popularView.hidden = true
        default:
            break;
        }
    }
    
    @IBAction func saveEvent(sender: AnyObject) {
    setDateAndTime()
    }
}

