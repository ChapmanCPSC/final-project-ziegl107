//
//  DateTableViewCell.swift
//  ChapRadio
//
//  Created by Kayla Ziegler on 5/8/16.
//  Copyright © 2016 Ziegler, Kayla. All rights reserved.
//

import UIKit

class DateTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initWithDate(position: String, title: String) {
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "MM/dd"
        let userCalendar = NSCalendar.currentCalendar()
        var formattedDate : String = ""
        var newDate = NSDate()
        
        switch position {
        case "6":
            //today, do not modify
            formattedDate = formatter.stringFromDate(NSDate())
        case "7":
            newDate = userCalendar.dateByAddingUnit([.Day], value: 1, toDate: NSDate(), options: [])!
            formattedDate = formatter.stringFromDate(newDate)
            break
        case "8":
            newDate = userCalendar.dateByAddingUnit([.Day], value: 2, toDate: NSDate(), options: [])!
            formattedDate = formatter.stringFromDate(newDate)
            break
        case "9":
            newDate = userCalendar.dateByAddingUnit([.Day], value: 3, toDate: NSDate(), options: [])!
            formattedDate = formatter.stringFromDate(newDate)
            break
        case "10":
            newDate = userCalendar.dateByAddingUnit([.Day], value: 4, toDate: NSDate(), options: [])!
            formattedDate = formatter.stringFromDate(newDate)
            break
        case "11":
            newDate = userCalendar.dateByAddingUnit([.Day], value: 5, toDate: NSDate(), options: [])!
            formattedDate = formatter.stringFromDate(newDate)
            break
        case "12":
            newDate = userCalendar.dateByAddingUnit([.Day], value: 6, toDate: NSDate(), options: [])!
            formattedDate = formatter.stringFromDate(newDate)
            break
        default:
            break
        }
        
        self.dateLabel.text! = formattedDate
        self.titleLabel.text! = title
    }
    
}
