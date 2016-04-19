//  ViewController.swift
//  ScavengerHunt
//  Copyright © 2016 Haemin Park. All rights reserved.

import UIKit
import CVCalendar

class ViewController: UIViewController {
    @IBOutlet weak var menuView: CVCalendarMenuView!
    @IBOutlet weak var calendarView: CVCalendarView!
    
    @IBOutlet weak var monthLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        monthLabel.text = CVDate(date: NSDate()).globalDescription
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        calendarView.commitCalendarViewUpdate()
        menuView.commitMenuViewUpdate()
    }


}



extension ViewController: CVCalendarViewDelegate, CVCalendarMenuViewDelegate {

    @IBAction func loadNext(sender: AnyObject) {
        calendarView.loadNextView()
    }
    @IBAction func loadPrevious(sender: AnyObject) {
        calendarView.loadPreviousView()
    }

    
    
    /// Required method to implement!
    func presentationMode() -> CalendarMode {
        return .MonthView
    }
    
    /// Required method to implement!
    func firstWeekday() -> Weekday {
        return .Sunday    }
    
    
    
    
    
    
    func presentedDateUpdated(date: CVDate) {
        //      if monthLabel.text != date.globalDescription && self.animationFinished {
        if monthLabel.text != date.globalDescription{
            let updatedMonthLabel = UILabel()
            updatedMonthLabel.textColor = monthLabel.textColor
            updatedMonthLabel.font = monthLabel.font
            updatedMonthLabel.textAlignment = .Center
            updatedMonthLabel.text = date.globalDescription
            updatedMonthLabel.sizeToFit()
            updatedMonthLabel.alpha = 0
            updatedMonthLabel.center = self.monthLabel.center
            
            let offset = CGFloat(48)
            updatedMonthLabel.transform = CGAffineTransformMakeTranslation(0, offset)
            updatedMonthLabel.transform = CGAffineTransformMakeScale(1, 0.1)
            
            UIView.animateWithDuration(0.35, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                //               self.animationFinished = false
                self.monthLabel.transform = CGAffineTransformMakeTranslation(0, -offset)
                self.monthLabel.transform = CGAffineTransformMakeScale(1, 0.1)
                self.monthLabel.alpha = 0
                
                updatedMonthLabel.alpha = 1
                updatedMonthLabel.transform = CGAffineTransformIdentity
                
            }) { _ in
                
                //                self.animationFinished = true
                self.monthLabel.frame = updatedMonthLabel.frame
                self.monthLabel.text = updatedMonthLabel.text
                self.monthLabel.transform = CGAffineTransformIdentity
                self.monthLabel.alpha = 1
                updatedMonthLabel.removeFromSuperview()
            }
            
            self.view.insertSubview(updatedMonthLabel, aboveSubview: self.monthLabel)
        }
    }
    
    
    
    
    
    /// Functions to Mark Dates
    func dotMarker(shouldShowOnDayView dayView: CVCalendarDayView) -> Bool {
        let day = dayView.date
        let randomDay = 14
        print(randomDay)
        for date in GLOB_date_components
        {
            if (day.day == date.day && day.month == GLOB_date_components[0].month){
                return true
            }
                
            else {
                return false
            }
        }
        return false
    }
    
    func dotMarker(colorOnDayView dayView: CVCalendarDayView) -> [UIColor] {
        
        let red =  CGFloat(0) // CGFloat(arc4random_uniform(600) / 255)
        let green = CGFloat(255) // CGFloat(arc4random_uniform(600) / 255)
        let blue =  CGFloat(0) //CGFloat(arc4random_uniform(600) / 255)
        
        let color = UIColor(red: red, green: green, blue: blue, alpha: 1)
        return [color] // return 1 dot
        
    }
    
    func dotMarker(shouldMoveOnHighlightingOnDayView dayView: CVCalendarDayView) -> Bool {
        return true
    }
   
    
    
    
    
    
    
    //////////////
//    func supplementaryView(viewOnDayView dayView: DayView) -> UIView {
//        let π = M_PI
//        
//        let ringSpacing: CGFloat = 3.0
//        let ringInsetWidth: CGFloat = 1.0
//        let ringVerticalOffset: CGFloat = 1.0
//        var ringLayer: CAShapeLayer!
//        let ringLineWidth: CGFloat = 4.0
//        let ringLineColour: UIColor = .greenColor()
//        
//        let newView = UIView(frame: dayView.bounds)
//        
//        let diameter: CGFloat = (newView.bounds.width) - ringSpacing
//        let radius: CGFloat = diameter / 2.0
//        
//        let rect = CGRectMake(newView.frame.midX-radius, newView.frame.midY-radius-ringVerticalOffset, diameter, diameter)
//        
//        ringLayer = CAShapeLayer()
//        newView.layer.addSublayer(ringLayer)
//        
//        ringLayer.fillColor = nil
//        ringLayer.lineWidth = ringLineWidth
//        ringLayer.strokeColor = ringLineColour.CGColor
//        
//        let ringLineWidthInset: CGFloat = CGFloat(ringLineWidth/2.0) + ringInsetWidth
//        let ringRect: CGRect = CGRectInset(rect, ringLineWidthInset, ringLineWidthInset)
//        let centrePoint: CGPoint = CGPointMake(ringRect.midX, ringRect.midY)
//        let startAngle: CGFloat = CGFloat(-π/2.0)
//        let endAngle: CGFloat = CGFloat(π * 2.0) + startAngle
//        let ringPath: UIBezierPath = UIBezierPath(arcCenter: centrePoint, radius: ringRect.width/2.0, startAngle: startAngle, endAngle: endAngle, clockwise: true)
//        
//        ringLayer.path = ringPath.CGPath
//        ringLayer.frame = newView.layer.bounds
//        
//        return newView
//    }
//    
//    func supplementaryView(shouldDisplayOnDayView dayView: DayView) -> Bool {
//        let day = dayView.date
//        //let randomDay = GLOB_date_components[0].day
//        
//        
//        if (day.day == 14 && day.month == 4) {
//            return true
//        }
//        
//        return false
//        
//        ////if (dayView) {
//        //    return true
//        //}
//        //
//        //return false
//    }
    ////////////
    
    
    
}

















// MARK: - Convenience API Demo

extension ViewController {
    func toggleMonthViewWithMonthOffset(offset: Int) {
        let calendar = NSCalendar.currentCalendar()
        //        let calendarManager = calendarView.manager
        let components = Manager.componentsForDate(NSDate()) // from today
        
        components.month += offset
        
        let resultDate = calendar.dateFromComponents(components)!
        
        self.calendarView.toggleViewWithDate(resultDate)
    }
    
    func didShowNextMonthView(date: NSDate)
    {
        //        let calendar = NSCalendar.currentCalendar()
        //        let calendarManager = calendarView.manager
        let components = Manager.componentsForDate(date) // from today
        
        print("Showing Month: \(components.month)")
    }
    
    
    func didShowPreviousMonthView(date: NSDate)
    {
        //        let calendar = NSCalendar.currentCalendar()
        //        let calendarManager = calendarView.manager
        let components = Manager.componentsForDate(date) // from today
        
        print("Showing Month: \(components.month)")
    }
    
}



