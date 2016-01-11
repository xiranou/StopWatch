//
//  ViewController.swift
//  Navigation Bar
//
//  Created by Xiran Ou on 1/11/16.
//  Copyright © 2016 Xiran Ou. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var toolBar: UIToolbar!
    var playButton = UIBarButtonItem()
    var pauseButton = UIBarButtonItem()
    var buttonsArray = [UIBarButtonItem]()
    
    var seconds = 0
    var timer = NSTimer()
    var isCounting = false
    
    func increaseTimer() {
        seconds++
        displayTimerText()
    }
    
    func displayTimerText() {
        let (h, m, s) = secondsToHMS(seconds)
        timerLabel.text = "\(formatTimerText(h)):\(formatTimerText(m)):\(formatTimerText(s))"
    }

    func formatTimerText(time: Int) -> String {
        return time >= 10 ? "\(time)" : "0\(time)"
    }
    
    func secondsToHMS(seconds: Int) -> (Int, Int, Int) {
        return (seconds/3600, (seconds%3600)/60, (seconds%3600)%60)
    }
    
    func displayPlayPauseButton() {
        buttonsArray = self.toolBar.items!
        buttonsArray.removeAtIndex(0)
        
        if (isCounting) {
            buttonsArray.insert(pauseButton, atIndex: 0)
        } else {
            buttonsArray.insert(playButton, atIndex: 0)
        }
        
        self.toolBar.setItems(buttonsArray, animated: false)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        playButton = UIBarButtonItem(barButtonSystemItem: .Play, target: self, action: "play")
        pauseButton = UIBarButtonItem(barButtonSystemItem: .Pause, target: self, action: "pause")
        displayPlayPauseButton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func play() {
        isCounting = true
        displayPlayPauseButton()
        timerLabel.textColor = UIColor.greenColor()
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "increaseTimer", userInfo: nil, repeats: true)
    }

    func pause() {
        isCounting = false
        displayPlayPauseButton()
        timerLabel.textColor = UIColor.redColor()
        timer.invalidate()
    }
    
    @IBAction func reset(sender: AnyObject) {
        isCounting = false
        displayPlayPauseButton()
        seconds = 0
        timerLabel.textColor = UIColor.blackColor()
        timer.invalidate()
        displayTimerText()
    }
}

