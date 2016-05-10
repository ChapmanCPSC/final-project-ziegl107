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
    var showInfo : NSArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imgURL = formatURL(showInfo[6] as! String)
        if let url = NSURL(string: "http://"+imgURL){
            self.showImageView.contentMode = .ScaleAspectFit
            if let data = NSData(contentsOfURL: url){
                self.showImageView.image = UIImage(data: data)
            }
        }
        
        var name = showInfo[1] as! String
        if name.containsString("&amp;"){
            name = name.stringByReplacingOccurrencesOfString("&amp;", withString: "&")
        }
        self.nameLabel.text! = name
        self.timeLabel.text! = showInfo[2] as! String
        self.genreLabel.text! = showInfo[3] as! String
        var desc = showInfo[4] as! String
        
        
        if desc.containsString("\\\'") {
            desc = desc.stringByReplacingOccurrencesOfString("\\\'", withString: "'")
        }
        if desc.containsString("\\\"") {
            desc = desc.stringByReplacingOccurrencesOfString("\\\"", withString: "\"")
        }
        
        self.descriptionLabel.text! = desc
        
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
