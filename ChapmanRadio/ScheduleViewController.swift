//
//  ScheduleViewController.swift
//  ChapmanRadio
//
//  Created by Kayla Ziegler on 5/8/16.
//  Copyright © 2016 Ziegler, Kayla. All rights reserved.
//

import UIKit

class ScheduleViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var daysTableView: UITableView!
    
    var parsed : NSDictionary!
    var parsedA : NSArray!
    
    //all the days in the schedule JSON
    var indeces : [String] = [
        "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        if let test = parseJSON(getJSON("http://api.chapmanradio.com/legacy/schedule.json")) as? NSDictionary{
            parsed = test
            
            validateDays()
            
            self.daysTableView.delegate = self
            self.daysTableView.dataSource = self
            
            //set up for tableview
            
            
            
            let inset = UIEdgeInsetsMake(10, 0, 0, 0)
            self.daysTableView.contentInset = inset
            
            
            let cellNib = UINib(nibName: "DateTableViewCell", bundle: nil)
            self.daysTableView.registerNib(cellNib, forCellReuseIdentifier: "date_cell")
        }
        
        
        
        
//        if let test = parseJSONArray(getJSON("http://api.chapmanradio.com/legacy/schedule.json")) as? NSArray {
//            parsedA = test
//            
//            self.daysTableView.delegate = self
//            self.daysTableView.dataSource = self
//            
//            //set up for tableview
//            
//
//            
//            let inset = UIEdgeInsetsMake(10, 0, 0, 0)
//            self.daysTableView.contentInset = inset
//            
//            
//            let cellNib = UINib(nibName: "DateTableViewCell", bundle: nil)
//            self.daysTableView.registerNib(cellNib, forCellReuseIdentifier: "date_cell")
//
//        
//        }
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("date_cell") as! DateTableViewCell
        
        let thisIndex = self.indeces[indexPath.row]
        
        
        //if schedule uses dictionaries
        if let days = parsed[thisIndex]{
            let title = days["title"] as! NSString
            cell.initWithDate(thisIndex, title: title as String)
        }
        
        
        //schedule uses arrays
//        if let today = parsedA[indexPath.row] as? NSDictionary{
//            let title = today["title"] as! NSString
//            cell.initWithArray(indexPath.row, title: title as String)
//        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.backgroundColor = UIColor.init(red: 1, green: 51, blue: 85, alpha: 0)
        cell.textLabel?.textColor = UIColor.whiteColor()
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return parsedA.count
        
        return indeces.count
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.daysTableView.deselectRowAtIndexPath(indexPath, animated: false)
        
        let navVC = self.storyboard!.instantiateViewControllerWithIdentifier("day_view") as! UINavigationController
        
        let dayVC = navVC.viewControllers[0] as! DayViewController
        let today = parsed[self.indeces[indexPath.row]] as! NSDictionary
        //let today = parsedA[indexPath.row] as! NSDictionary
        dayVC.data = today["data"] as! NSArray
        dayVC.dateTitle = today["title"] as! String
        
        self.presentViewController(navVC, animated: true, completion: nil)
    }
    
    
    
    
    
    
    
    
    @IBAction func goBack(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    func getJSON(urlToRequest: String) -> NSData {
        return NSData(contentsOfURL: NSURL(string: urlToRequest)!)!
    }
    
    
    func parseJSON(input : NSData) -> NSDictionary{
        
        var dictionary : NSDictionary = [:]
        
        do{
            dictionary = try NSJSONSerialization.JSONObjectWithData(input, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
            return dictionary
        } catch {
            
        }
        
        return dictionary
    }
    
    
    func parseJSONArray(input : NSData) -> NSArray{
        
        var array : NSArray = []
        
        do{
            array = try NSJSONSerialization.JSONObjectWithData(input, options: NSJSONReadingOptions.MutableContainers) as! NSArray
            return array
        } catch {
            
        }
        
        return array
    }
    
    
    func validateDays() -> () {
        
        var removed = 0
        
        
        //will remove from indeces if current schedule JSON doesn't include it
        for i in 1...12 {
            
            let test : String = "\(i)"
            
            if let _ = parsed[test] as? NSDictionary {
                
            }
            else {
                removed += 1
                indeces.removeAtIndex(i-removed)
            }
        }
    }

}
