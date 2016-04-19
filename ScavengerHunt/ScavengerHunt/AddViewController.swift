//
//  AddViewController.swift
//  ScavengerHunt
//

//  Copyright (c) 2016 Haemin Park. All rights reserved.
//

import UIKit

class AddViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    var tmtx:String = "";
    var tx:String = "";
    var ifedit:Bool = false
    var rowin:Int = 0
    
    @IBOutlet weak var timerTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBAction func cancel(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    var img: UIImage?
    
    @IBOutlet weak var textField: UITextField!
        
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "DoneItem" {
            if let name = textField.text {
                if !name.isEmpty {
                    newItem = ScavengerHuntItem(name: name)
                    if let pht = img {
                        newItem?.photo = pht
                    }
                    
                    if let timeSetStr = timerTextField.text{
                        let timeSet = (timeSetStr as NSString).doubleValue
                        newItem!.minutes = timeSet
                        
                    /*
                        let timer = NSTimer.scheduledTimerWithTimeInterval(timeSet * 60, target: self, selector: "update", userInfo: nil, repeats: true)
                        newItem!.time = timer
                    */
                        
                    }
                    
                    /*
                      else {
                        let timer = NSTimer.scheduledTimerWithTimeInterval(180, target: self, selector: "update", userInfo: nil, repeats: true)
                        newItem!.time = timer
                    }
                    */
                    

                }
                
            }
        }
    }
    
    var newItem: ScavengerHuntItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        textField.text = tx;
        timerTextField.text = tmtx;
        photoImageView.image = img;

        // Set up views if editing an existing Meal.

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        // The info dictionary contains multiple representations of the image, and this uses the original.
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        img = selectedImage
        // Set photoImageView to display the selected image.
        photoImageView.image = selectedImage
        
        // Dismiss the picker.
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: Actions
    @IBAction func selectImageFromPhotoLibrary(sender: AnyObject) {
        // Hide the keyboard.
        textField.resignFirstResponder()
        
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        print("haha")
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .PhotoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        
        presentViewController(imagePickerController, animated: true, completion: nil)

    }
    @IBAction func btnTapped(sender: AnyObject) {
        // Hide the keyboard.
        textField.resignFirstResponder()
        
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .PhotoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        
        presentViewController(imagePickerController, animated: true, completion: nil)
    }
}

