//
//  DayViewController.swift
//  ChapRadio
//
//  Created by Kayla Ziegler on 5/8/16.
//  Copyright © 2016 Ziegler, Kayla. All rights reserved.
//

import UIKit

class DayViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //data = an array of arrays
    //contains all shows, then show information
    //one day only
    var data : NSArray!
    var dateTitle : String!
    @IBOutlet weak var dataTableView: UITableView!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //title on navigation controller
        self.title = dateTitle

        self.dataTableView.dataSource = self
        self.dataTableView.delegate = self
        
        
        let cellNib = UINib(nibName: "ShowTableViewCell", bundle: nil)
        self.dataTableView.registerNib(cellNib, forCellReuseIdentifier: "show_cell")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goBack(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let navVC = self.storyboard!.instantiateViewControllerWithIdentifier("show_view") as! UINavigationController
        
        let showVC = navVC.viewControllers[0] as! ShowViewController
        showVC.showInfo = self.data[indexPath.row] as! NSArray
        
        self.presentViewController(navVC, animated: true, completion: nil)
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let info = self.data[indexPath.row] as! NSArray
        
        var name = info[1] as! String
        if name.containsString("&amp;") {
            name = name.stringByReplacingOccurrencesOfString("&amp;", withString: "&")
        }
        let time = info[2] as! String
        let cell = tableView.dequeueReusableCellWithIdentifier("show_cell") as! ShowTableViewCell
        cell.initWithShow(name, time: time)
        return cell
    }
    
    
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.backgroundColor = UIColor.init(red: 1, green: 51, blue: 85, alpha: 0)
    }
    
}
