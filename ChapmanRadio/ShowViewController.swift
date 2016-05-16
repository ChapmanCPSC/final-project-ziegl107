//
//  ShowViewController.swift
//  ChapRadio
//
//  Created by Kayla Ziegler on 5/8/16.
//  Copyright © 2016 Ziegler, Kayla. All rights reserved.
//

import UIKit

class ShowViewController: UIViewController {


    @IBOutlet weak var showImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    var descFromMain : String!
    var genre : String!
    var time : String!
    var nameMain : String!
    var urlMain : String!
    var showInfo : NSArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //coming from DayViewController tableview cells
        //gets set in didSelectRowAtIndexPath
        if showInfo != nil {
            let imgURL = formatURL(showInfo[6] as! String)
            if let url = NSURL(string: "http://"+imgURL){
                self.showImageView.contentMode = .ScaleAspectFit
                if let data = NSData(contentsOfURL: url){
                    self.showImageView.image = UIImage(data: data)
                }
            }
            
            if var name = showInfo[1] as? String{
                
                var desc = showInfo[4] as! String
                
                
                //remove escape characters from name and description
                if name.containsString("&amp;"){
                    name = name.stringByReplacingOccurrencesOfString("&amp;", withString: "&")
                }
                
                if desc.containsString("\\\'") {
                    desc = desc.stringByReplacingOccurrencesOfString("\\\'", withString: "'")
                }
                if desc.containsString("\\\"") {
                    desc = desc.stringByReplacingOccurrencesOfString("\\\"", withString: "\"")
                }
                
                
                self.title = name
                self.nameLabel.text! = name
                self.timeLabel.text! = showInfo[2] as! String
                self.genreLabel.text! = showInfo[3] as! String
                self.descriptionLabel.text! = desc
            }
        }
        
        
        
        
        //coming from main view controller "Show Details" button
        else {
            
            //let imgURL = formatURL(self.urlMain)
            if let url = NSURL(string: "http://"+self.urlMain){
                self.showImageView.contentMode = .ScaleAspectFit
                if let data = NSData(contentsOfURL: url){
                    self.showImageView.image = UIImage(data: data)
                }
            }
            
            
            //remove escape characters in name and description
            if nameMain.containsString("&amp;"){
                nameMain = nameMain.stringByReplacingOccurrencesOfString("&amp;", withString: "&")
            }
            
            if descFromMain.containsString("\\\'") {
                descFromMain = descFromMain.stringByReplacingOccurrencesOfString("\\\'", withString: "'")
            }
            if descFromMain.containsString("\\\"") {
                descFromMain = descFromMain.stringByReplacingOccurrencesOfString("\\\"", withString: "\"")
            }
            
            self.timeLabel.text! = self.time
            self.nameLabel.text! = self.nameMain
            self.title = self.nameMain
            self.genreLabel.text! = self.genre
            self.descriptionLabel.text! = descFromMain
        }
        
        
        self.descriptionLabel.adjustsFontSizeToFitWidth = true
        self.timeLabel.adjustsFontSizeToFitWidth = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    @IBAction func goCancel(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func formatURL(old: String) -> String {
        var new = old.substringWithRange(Range<String.Index>(old.startIndex..<old.endIndex.advancedBy(-11)))
        new = new.substringWithRange(Range<String.Index>(new.startIndex.advancedBy(2)..<new.endIndex))
        
        return new
    }
}
