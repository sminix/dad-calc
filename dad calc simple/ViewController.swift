//
//  ViewController.swift
//  dad calc simple
//
//  Created by Samuel Minix on 5/13/19.
//  Copyright © 2019 Samuel Minix. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //outlets
    @IBOutlet weak var widthField: UITextField!
    @IBOutlet weak var heightField: UITextField!
    @IBOutlet weak var wtCoatField: UITextField!
    @IBOutlet weak var satuField: UITextField!
    @IBOutlet weak var baseField: UITextField!
    
    @IBOutlet weak var calcButt: UIButton!
    
    @IBOutlet weak var dispField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        widthField.delegate = self
        heightField.delegate = self
        wtCoatField.delegate = self
        satuField.delegate = self
        baseField.delegate = self
        
    }
    //Calcuate values for results. I don't understand what these calculations mean
    //because it is for my Dad's work, which i am unfamiliar with.
    @IBAction func calculate(_ sender: Any) {
        //initialize values
        var width:Double = 0
        var height:Double = 0
        var wtCoat:Double = 0
        var wtSatu:Double = 0
        var wtBase:Double = 0
        
        var widthBool = false
        var heightBool = false
        var wtCoatBool = false
        var wtSatuBool = false
        var wtBaseBool = false
        dispField.text = ""
        
        //Retrieve values from input, and check that they are appropriate
        if let possibleWidth = widthField.text, let w = Double(possibleWidth){
            width = w
            widthBool = true
        }
        else {dispField.text = "Enter a width\n"}
        
        if let possibleHeight = heightField.text, let h = Double(possibleHeight){
            height = h
            heightBool = true
        }
        else {dispField.text += "Enter a height\n"}
        
        if let possibleWtCoat = wtCoatField.text, let wc = Double(possibleWtCoat){
            wtCoat = wc
            wtCoatBool = true
        }
        else {dispField.text += "Enter the coated sheet weight\n"}
        
        if let possibleSatu = satuField.text, let s = Double(possibleSatu){
            wtSatu = s
            wtSatuBool = true
        }
        else {dispField.text += "Enter the saturated sheet weight\n"}
        
        if let possibleBase = baseField.text, let b = Double(possibleBase) {
            wtBase = b
            wtBaseBool = true
        }
        else {dispField.text += "Enter the base paper weight\n"}
        
        
        //If values are appropriate, do calculations
        if (widthBool && heightBool && wtCoatBool && wtSatuBool && wtBaseBool == true){
            let area = width * height
            let metric_area = area * 0.00064516 //Convert from US standard to metric
            
            let coatWt = (wtCoat - wtSatu)/metric_area
            let coatWtReam = coatWt / 3.75  //coat weight to ream coat weight
            
            let pickUp = ((wtSatu - wtBase)/wtBase) * 100 //calculate pickup
            
            let bdfw = wtBase / metric_area
            let bdfwReam = bdfw / 3.75 //Bone dry weight
            
            let basisCoat = wtCoat / metric_area
            let basisCoatReam = basisCoat/3.75 //basis coat
            
            //Enter results into display
            dispField.text =
            """
            Area = \(area) in^2 or \(round(1000 * metric_area)/1000) m^2
            Coat weight = \(round(1000 * coatWt) / 1000) GSM or \(round(1000 * coatWtReam) / 1000) lbs/ream
            Pick up is \(round(1000 * pickUp) / 1000)%
            BDFW = \(round(1000 * bdfw)/1000) GSM or \(round(1000 * bdfwReam)/1000) lbs/ream
            Basis coat weight = \(round(1000 * basisCoat)/1000) GSM or \(round(1000 * basisCoatReam)/1000) lbs/ream
            """
        }
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        widthField.resignFirstResponder()
        heightField.resignFirstResponder()
        wtCoatField.resignFirstResponder()
        satuField.resignFirstResponder()
        baseField.resignFirstResponder()
    }

}
extension ViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        dispField.resignFirstResponder()
        return true
    }
}
