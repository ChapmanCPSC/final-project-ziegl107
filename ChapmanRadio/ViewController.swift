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

class ViewController: UIViewController {
    
    
    @IBOutlet weak var showLabel: UILabel!
    @IBOutlet weak var showImageView: UIImageView!
    @IBOutlet weak var songImageView: UIImageView!
    @IBOutlet weak var songLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var djsLabel: UILabel!
    @IBOutlet weak var muteButton: UIButton!
    @IBOutlet weak var volumeButton: UIButton!
    var player : AVPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        
        let parsed = parseJSON(getJSON("http://api.chapmanradio.com/legacy/livestreams.json"))
        
        //parsed= show {}, nowplaying {}
        
        let show = parsed["show"] as! NSDictionary
        
        
        if let genre = show["genre"]{
            if genre as! String == "Talk" {
                
            }
            else {
                let nowplaying = parsed["nowplaying"] as! NSDictionary
                if let songName = nowplaying["track"]{
                    self.songLabel.text! = songName as! String
                }
                
                let songURL = nowplaying["img100"] as! String
                setSongImage(songURL)
                
                
                if let artist = nowplaying["artist"] {
                    self.artistLabel.text! = artist as! String
                }
            }
        }
        
        
        if let showName = show["showname"]{
            self.showLabel.text! = showName as! String
        }
        
        
        if let djs = show["djs"] {
            self.djsLabel.text! = djs as! String
        }
        
        var url = show["pic"] as! String
        url = formatURL(url)
        setShowImage(url)

        
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

}

