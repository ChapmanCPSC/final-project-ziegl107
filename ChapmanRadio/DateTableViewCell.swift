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
        
        self.selectionStyle = UITableViewCellSelectionStyle.None
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initWithDate(position: Int, title: String, count: Int) {
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "MM/dd"
        let userCalendar = NSCalendar.currentCalendar()
        var formattedDate : String = ""
        var newDate = NSDate()
        
        //no today
        if count<=6 {
            if position==0{ //tomorrow
                newDate = userCalendar.dateByAddingUnit([.Day], value: 1, toDate: NSDate(), options: [])!
                formattedDate = formatter.stringFromDate(newDate)
            }
            else if position==1{
                newDate = userCalendar.dateByAddingUnit([.Day], value: 2, toDate: NSDate(), options: [])!
                formattedDate = formatter.stringFromDate(newDate)
            }
            else if position==2{
                newDate = userCalendar.dateByAddingUnit([.Day], value: 3, toDate: NSDate(), options: [])!
                formattedDate = formatter.stringFromDate(newDate)
            }
            else if position==3 {
                newDate = userCalendar.dateByAddingUnit([.Day], value: 4, toDate: NSDate(), options: [])!
                formattedDate = formatter.stringFromDate(newDate)
            }
            else if position==4 {
                newDate = userCalendar.dateByAddingUnit([.Day], value: 5, toDate: NSDate(), options: [])!
                formattedDate = formatter.stringFromDate(newDate)
            }
            else if position==5{
                newDate = userCalendar.dateByAddingUnit([.Day], value: 6, toDate: NSDate(), options: [])!
                formattedDate = formatter.stringFromDate(newDate)
            }
        }
        else{
            if position==0{
                //today, do not modify
                formattedDate = formatter.stringFromDate(NSDate())
            }
            else if position==1{ //tomorrow
                newDate = userCalendar.dateByAddingUnit([.Day], value: 1, toDate: NSDate(), options: [])!
                formattedDate = formatter.stringFromDate(newDate)
            }
            else if position==2{
                newDate = userCalendar.dateByAddingUnit([.Day], value: 2, toDate: NSDate(), options: [])!
                formattedDate = formatter.stringFromDate(newDate)
            }
            else if position==3{
                newDate = userCalendar.dateByAddingUnit([.Day], value: 3, toDate: NSDate(), options: [])!
                formattedDate = formatter.stringFromDate(newDate)
            }
            else if position==4 {
                newDate = userCalendar.dateByAddingUnit([.Day], value: 4, toDate: NSDate(), options: [])!
                formattedDate = formatter.stringFromDate(newDate)
            }
            else if position==5 {
                newDate = userCalendar.dateByAddingUnit([.Day], value: 5, toDate: NSDate(), options: [])!
                formattedDate = formatter.stringFromDate(newDate)
            }
            else if position==6{
                newDate = userCalendar.dateByAddingUnit([.Day], value: 6, toDate: NSDate(), options: [])!
                formattedDate = formatter.stringFromDate(newDate)
            }
        }
        

        
        self.dateLabel.text! = formattedDate
        self.titleLabel.text! = title
    }
    
    
    func initWithArray(position: Int, title: String){
        let formatter = NSDateFormatter()
        formatter.dateFormat = "MM/dd"
        let userCalendar = NSCalendar.currentCalendar()
        var formattedDate : String = ""
        var newDate = NSDate()
        
        switch position {
        case 0:
            //today, do not modify
            formattedDate = formatter.stringFromDate(NSDate())
        case 1:
            newDate = userCalendar.dateByAddingUnit([.Day], value: 1, toDate: NSDate(), options: [])!
            formattedDate = formatter.stringFromDate(newDate)
            break
        case 2:
            newDate = userCalendar.dateByAddingUnit([.Day], value: 2, toDate: NSDate(), options: [])!
            formattedDate = formatter.stringFromDate(newDate)
            break
        case 3:
            newDate = userCalendar.dateByAddingUnit([.Day], value: 3, toDate: NSDate(), options: [])!
            formattedDate = formatter.stringFromDate(newDate)
            break
        case 4:
            newDate = userCalendar.dateByAddingUnit([.Day], value: 4, toDate: NSDate(), options: [])!
            formattedDate = formatter.stringFromDate(newDate)
            break
        case 5:
            newDate = userCalendar.dateByAddingUnit([.Day], value: 5, toDate: NSDate(), options: [])!
            formattedDate = formatter.stringFromDate(newDate)
            break
        case 6:
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
