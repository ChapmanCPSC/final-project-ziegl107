//
//  ViewController.swift
//  ChapmanRadio
//
//  Created by Ziegler, Kayla on 5/2/16.
//  Copyright © 2016 Ziegler, Kayla. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import MessageUI

class ViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    
    @IBOutlet weak var showLabel: UILabel!
    @IBOutlet weak var showImageView: UIImageView!
    @IBOutlet weak var songImageView: UIImageView!
    @IBOutlet weak var songLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var djsLabel: UILabel!
    @IBOutlet weak var muteButton: UIButton!
    @IBOutlet weak var volumeButton: UIButton!
    @IBOutlet weak var talkShowLabel: UILabel!
    @IBOutlet weak var talkShowDJsLabel: UILabel!
    @IBOutlet weak var showNameHide: UILabel!
    @IBOutlet weak var djsHide: UILabel!
    @IBOutlet weak var nothingLabel: UILabel!
    @IBOutlet weak var detailButton: UIButton!
    
    
    var player : AVPlayer!
    var showDescrip : String = ""
    var genre : String = ""
    var time : String = ""
    var sendURL : String = ""
    var showN : String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        
        configureView()
        
        let parsed = parseJSON(getJSON("http://api.chapmanradio.com/legacy/livestreams.json"))
        
        //parsed= show {}, nowplaying {} if not a talk show
        
        let id = parsed["showid"]
        let stringID = String(id!)
        
        
        if let intID = Int(stringID){
            
            let numID = NSNumber(integer: intID)
            
            //id = 0 if no show is on
            if numID != 0{
                
                let show = parsed["show"] as! NSDictionary
                
                if let genre = show["genre"]{
                    self.nothingLabel.hidden = true
                    
                    //talk show
                    if genre as! String == "Talk" {
                        //put in song spot
                        self.talkShowLabel.text! = "TALK SHOW NAME"
                        self.talkShowDJsLabel.text! = "DJS"
                        self.djsHide.hidden = true
                        self.showNameHide.hidden = true
                        self.showLabel.hidden = true
                        self.djsLabel.hidden = true
                        
                        if let showName = show["showname"]{
                            self.songLabel.text! = showName as! String
                            self.showN = showName as! String
                        }
                        
                        if let djs = show["djs"] {
                            self.artistLabel.text! = djs as! String
                        }
                        
                        if let _ = show["description"] {
                            self.showDescrip = show["description"] as! String
                        }
                        
                        if let t = show["showtime"] {
                            self.time = t as! String
                        }
                        
                        if let _ = show["genre"] {
                            self.genre = show["genre"] as! String
                        }
                        
                        
                        var url = show["pic"] as! String
                        //send url without http://
                        self.sendURL = formatURL(url)
                        url = "http://" + formatURL(url)
                        //because in the place of song not show
                        setSongImage(url)
                        
                        
                        
                        
                        //happens to be playing a song, genre = talk
                        if let nowplaying = parsed["nowplaying"] as? NSDictionary{
                            
                            //because sometimes talk shows add talk topics under nowplaying
                            //even though they aren't playing a song
                            if nowplaying["trackid"] as! String != "" {
                                self.talkShowLabel.text! = "SONG NAME"
                                self.talkShowDJsLabel.text! = "ARTIST"
                                self.djsHide.hidden = false
                                self.showNameHide.hidden = false
                                self.showLabel.hidden = false
                                self.djsLabel.hidden = false
                                
                                if let songName = nowplaying["track"]{
                                    self.songLabel.text! = songName as! String
                                }
                                
                                let songURL = nowplaying["img100"] as! String
                                setSongImage(songURL)
                                
                                
                                if let artist = nowplaying["artist"] {
                                    self.artistLabel.text! = artist as! String
                                }
                                
                                
                                if let showName = show["showname"]{
                                    self.showLabel.text! = showName as! String
                                    self.showN = showName as! String
                                }
                                
                                if let djs = show["djs"] {
                                    self.djsLabel.text! = djs as! String
                                }
                                
                                if let t = show["showtime"] {
                                    self.time = t as! String
                                }
                                
                                if let _ = show["genre"] {
                                    self.genre = show["genre"] as! String
                                }
                                
                                var url = show["pic"] as! String
                                url = formatURL(url)
                                self.sendURL = url
                                setShowImage(url)
                            }
                            
                            
                        }

                    }
                      
                    //not a talk show
                    else {
                        
                        //playing a song
                        if let nowplaying = parsed["nowplaying"] as? NSDictionary{
                            self.talkShowLabel.text! = "SONG NAME"
                            self.talkShowDJsLabel.text! = "ARTIST"
                            self.djsHide.hidden = false
                            self.showNameHide.hidden = false
                            self.showLabel.hidden = false
                            self.djsLabel.hidden = false
                            
                            if let songName = nowplaying["track"]{
                                self.songLabel.text! = songName as! String
                            }
                            
                            let songURL = nowplaying["img100"] as! String
                            setSongImage(songURL)
                            
                            
                            if let artist = nowplaying["artist"] {
                                self.artistLabel.text! = artist as! String
                            }
                            
                            
                            if let showName = show["showname"]{
                                self.showLabel.text! = showName as! String
                                self.showN = showName as! String
                            }
                            
                            if let djs = show["djs"] {
                                self.djsLabel.text! = djs as! String
                            }
                            
                            if let _ = show["description"] {
                                self.showDescrip = show["description"] as! String
                            }
                            
                            if let t = show["showtime"] {
                                self.time = t as! String
                            }
                            
                            if let _ = show["genre"] {
                                self.genre = show["genre"] as! String
                            }
                            
                            var url = show["pic"] as! String
                            url = formatURL(url)
                            self.sendURL = url
                            setShowImage(url)

                        }
                        
                        //not currently playing song
                        else {
                            //put in song spot
                            self.talkShowLabel.text! = "SHOW NAME"
                            self.talkShowDJsLabel.text! = "DJS"
                            self.djsHide.hidden = true
                            self.showNameHide.hidden = true
                            self.showLabel.hidden = true
                            self.djsLabel.hidden = true
                            
                            if let _ = show["genre"] {
                                self.genre = show["genre"] as! String
                            }
                            
                            if let showName = show["showname"]{
                                self.songLabel.text! = showName as! String
                                self.showN = showName as! String
                            }
                            
                            if let djs = show["djs"] {
                                self.artistLabel.text! = djs as! String
                            }
                            
                            if let t = show["showtime"] {
                                self.time = t as! String
                            }
                            
                            
                            var url = show["pic"] as! String
                            self.sendURL = formatURL(url)
                            url = "http://" + formatURL(url)
                            //because in the place of song not show
                            setSongImage(url)
                        }
                    }
                }

            }
            
            // id == 0, no show is on
            else{
                self.nothingLabel.hidden = false
                
                self.detailButton.hidden = true
                self.djsHide.hidden = true
                self.showNameHide.hidden = true
                self.showLabel.hidden = true
                self.djsLabel.hidden = true
                self.showImageView.hidden = true
                self.songImageView.hidden = true
                self.songLabel.hidden = true
                self.artistLabel.hidden = true
                self.talkShowDJsLabel.hidden = true
                self.talkShowLabel.hidden = true
                
                
            }
        }//end of didLoad
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
    
    
    
    func setSongImage(url: String) ->() {
        if let imageURL = NSURL(string: url){
            self.songImageView.contentMode = .ScaleAspectFit
            if let data = NSData(contentsOfURL: imageURL){
                self.songImageView.image = UIImage(data: data)
            }
        }
    }
    
    
    func setShowImage(url: String) ->() {
        if let imageURL = NSURL(string: "http://"+url){
            self.showImageView.contentMode = .ScaleAspectFit
            if let data = NSData(contentsOfURL: imageURL){
                self.showImageView.image = UIImage(data: data)
            }
        }
    }
    
    
    func formatURL(old: String) -> String {
        var new = old.substringWithRange(Range<String.Index>(old.startIndex..<old.endIndex.advancedBy(-11)))
        new = new.substringWithRange(Range<String.Index>(new.startIndex.advancedBy(2)..<new.endIndex))
        
        return new
    }
    
    
    func configureView() {
        let url = "https://chapmanradio.com/stream/listen/iTunes.m3u"
        self.player = AVPlayer(URL:NSURL(string: url)!)
        player.rate = 1.0
        player.volume = 1.0
        player.play()
    }
    
    @IBAction func hitMute(sender: AnyObject) {
        muteButton.hidden = true
        volumeButton.hidden = false
        
        player.muted = true
    }
    
    @IBAction func hitForVolume(sender: AnyObject) {
        muteButton.hidden = false
        volumeButton.hidden = true
        
        player.muted = false
    }

    @IBAction func goShow(sender: AnyObject) {
        let navVC = self.storyboard!.instantiateViewControllerWithIdentifier("show_view") as! UINavigationController
        
        let showVC = navVC.viewControllers[0] as! ShowViewController
        showVC.descFromMain = self.showDescrip
        showVC.genre = self.genre
        showVC.nameMain = self.showN
        showVC.time = self.time
        showVC.urlMain = self.sendURL
        
        self.presentViewController(navVC, animated: true, completion: nil)
        
    }
    
    @IBAction func goSchedule(sender: AnyObject) {
        let navVC = self.storyboard!.instantiateViewControllerWithIdentifier("schedule_view") as! UINavigationController
        
        self.presentViewController(navVC, animated: true, completion: nil)
    }
    
    
    @IBAction func sendEmail(sender: AnyObject) {
        
        var message = "<p><b>Show: </b>"+showLabel.text! + "</p><p><b> DJs: </b>"+djsLabel.text!
        message += "</p><p><b>Song: </b>"+songLabel.text! + "</p><p><b>Artist: </b>"+artistLabel.text!+"</p>"
        message += "<p><a href=\"http://www.chapmanradio.com/home\">Visit Chapman Radio</a>"
        
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setSubject("Check out what's playing on Chapman Radio")
            mail.setMessageBody(message, isHTML: true)
            
            presentViewController(mail, animated: true, completion: nil)
        }
        
        
    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
    
}

