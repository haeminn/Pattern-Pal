//  ScavengerHuntItem.swift
//  ScavengerHunt
//  Copyright (c) 2016 Haemin Park. All rights reserved.


import Foundation
import UIKit

class ScavengerHuntItem: NSObject, NSCoding {
    
    let name: String
    var photo: UIImage?
    var time: NSTimer?
    var minutes:Double?
    
    var isCompleted: Bool {
        get {
            return photo != nil
        }
    }
    
    let nameKey = "name"
    let photoKey = "photo"
    let timeKey = "time"
    let minsKey = "minutes"
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: nameKey)
        if let thePhoto = photo {
            aCoder.encodeObject(thePhoto, forKey: photoKey)
        }
        if let theTime = time {
            aCoder.encodeObject(theTime, forKey: timeKey)
        }
        if let mins = minutes {
            aCoder.encodeObject(mins, forKey: minsKey)
        }

    }
    
    required init(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObjectForKey(nameKey) as! String
        photo = aDecoder.decodeObjectForKey(photoKey) as? UIImage
        time = aDecoder.decodeObjectForKey(timeKey) as? NSTimer
        minutes = aDecoder.decodeObjectForKey(minsKey) as? Double
    }
    
    init(name: String) {
        self.name = name
        self.minutes = 3.0
    }
}