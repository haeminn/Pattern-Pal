//  ItemsManager.swift
//  ScavengerHunt
//  Copyright (c) 2016 Haemin Park. All rights reserved.
//

import UIKit

class ItemsManager {
    var items = [ScavengerHuntItem] ()
    //var getUpItem: ScavengerHuntItem
    
    func archivePath() -> String? {
        let directoryList = NSSearchPathForDirectoriesInDomains(
            NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
            if let documentsPath = directoryList.first as String! {
                return documentsPath + "/ScavengerHuntItems"
            }
        
        return nil
    }
    
    func save() {
        if let theArchivePath = archivePath() {
            if !NSKeyedArchiver.archiveRootObject(items, toFile: theArchivePath) {
                assertionFailure("Could not save data to \(theArchivePath)")
            }/*
            if !NSKeyedArchiver.archiveRootObject(getUpItem, toFile: theArchivePath + "/getUpTimeInterval") {
                assertionFailure("Could not save data to \(theArchivePath)")
            }*/
        } else {
            assertionFailure("Could not determine where to save file")
        }
    }
    
    func unarchiveSavedItems() {
        if let theArchivePath = archivePath() {
            if NSFileManager.defaultManager().fileExistsAtPath(theArchivePath) {
                items = NSKeyedUnarchiver.unarchiveObjectWithFile(theArchivePath) as! [ScavengerHuntItem]
            }
        }
    }
    
    init() {
        unarchiveSavedItems()
    }
}
