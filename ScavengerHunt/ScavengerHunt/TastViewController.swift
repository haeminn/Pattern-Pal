//  TastViewController.swift
//  ScavengerHunt
//  Copyright © 2016 Haemin Park. All rights reserved.
//

import Foundation
import UIKit
import CVCalendar

//let RFC3339DateFormatter = NSDateFormatter()
//RFC3339DateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
//RFC3339DateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
//RFC3339DateFormatter.timeZone = NSTimeZone(forSecondsFromGMT: 0)
//
///* 39 minutes and 57 seconds after the 16th hour of December 19th, 1996 with an offset of -08:00 from UTC (Pacific Standard Time) */
//let string = "1996-12-19T16:39:57-08:00"
//let date = RFC3339DateFormatter.dateFromString(string)


var GLOB_date = [NSDate().dayOfWeek()]
var GLOB_date_components = [NSDateComponents]() // from today


class TaskViewController : UIViewController {

    let myManager = ItemsManager()
    var idx = 0
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var donebtn: UIButton!
    @IBOutlet weak var taskLabel: UILabel!
    @IBOutlet weak var nextTaskLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    var btnImg:UIImage!
    
    override func viewDidLoad() {
        // btnImg = UIImage(named:"smileface.jpg")
        // donebtn.setImage(btnImg, forState: .Normal)
        donebtn.setTitle("Done", forState: UIControlState.Normal)
        super.viewDidLoad();
        getup();
        //nextTask();
    }
    
    var timer = NSTimer()
    let timeInterval:NSTimeInterval = 0.05 // update timer every .05 seconds
    var timeCount:NSTimeInterval = 10.0
    
    @IBAction func doneBtnTapped(sender: AnyObject) {
        GLOB_date_components.append( Manager.componentsForDate(NSDate() ) )
        nextTask();
    }
    
    
    func timeString(time:NSTimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = time - Double(minutes) * 60
        return String(format:"%02i:%02i", minutes, Int(seconds))
    }
    
    //MARK: Instance Methods
    func timerDidEnd(timer:NSTimer){
        // first timer iteration
        //
        timeCount = timeCount - timeInterval
        if (timeCount <= 0 ) {

            nextTask();
        }else {
            timerLabel.text =  timeString(timeCount)
        }
    }
    
    func startTimer (){
        if (!timer.valid) {
//            let url = NSURL (string:"http://192.168.2.9/$2");
//            let req = NSURLRequest(URL: url!);
//            LightsWebView.loadRequest(req);
            timeCount = 60 * myManager.items[idx].minutes!;
            setUI();
            timerLabel.text = timeString(timeCount)
            idx++;
            timer = NSTimer.scheduledTimerWithTimeInterval(timeInterval, target: self, selector: "timerDidEnd:", userInfo: "Task Done!", repeats: true)
            
        }
//        let url = NSURL (string: "http://192.168.2.9/$1");
//        let req = NSURLRequest(URL: url!);
//        LightsWebView.loadRequest(req);
    }
    
    func nextTask(){
        timer.invalidate();
        let url = NSURL (string:"http://192.168.2.9/$1");
        let req = NSURLRequest(URL: url!);
        if (idx < myManager.items.count){
            startTimer();
        } else {
            if(myManager.items.count > 0){
                timerLabel.text = "All tasks done";
                
                //TASKS HAVE BEEN FINISHED
                
                
                imgView.image = UIImage(named:"cong.png");
                taskLabel.text = "";
                nextTaskLabel.text = "";
                donebtn.addTarget(self, action: "pressed:", forControlEvents: .TouchUpInside)

            } else {
                taskLabel.text = "";
                timerLabel.text = "No task yet.";
                nextTaskLabel.text = "Please go to settings to add tasks.";
            }

        }
    }
    
    func pressed(sender: UIButton!) {
        NSLog("last task button tapped");
        let vc: UINavigationController = storyboard!.instantiateViewControllerWithIdentifier("main_nav_screen") as! UINavigationController;
        self.presentViewController(vc, animated: true, completion: nil);
    }
    
    func setUI(){
        taskLabel.text = "Current task: " + myManager.items[idx].name
        imgView.image = myManager.items[idx].photo;
        if (idx + 1 < myManager.items.count){
            nextTaskLabel.text = "Next task: " + myManager.items[idx + 1].name;
        } else {
            nextTaskLabel.text = " ";
        }
    }
    
    func getup(){
        taskLabel.text = "Current task: get up";
        timeCount = 30;
        timerLabel.text = timeString(timeCount)
        timer = NSTimer.scheduledTimerWithTimeInterval(timeInterval, target: self, selector: "timerDidEnd:", userInfo: "Task Done!", repeats: true)
        imgView.image = UIImage(named:"PPHome.png");
        if (myManager.items.count > 0){
            nextTaskLabel.text = "Next task: " + myManager.items[0].name;
        } else {
            nextTaskLabel.text = " ";
        }
    }
    
}


//Helper
extension NSDate {
    func dayOfWeek() -> Int? {
        if
            let cal: NSCalendar = NSCalendar.currentCalendar(),
            let comp: NSDateComponents = cal.components(.Weekday, fromDate: self) {
                return comp.weekday
        } else {
            return nil
        }
    }
}