//
//  ViewController.swift
//  RetroCalculator
//
//  Created by jmayfield37 on 3/17/16.
//  Copyright © 2016 Joe Mayfield. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    enum Opertation: String{
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        //case Equals = "="
        case Empty = "Empty"
    }
    
    @IBOutlet weak var outputLbl: UILabel!
    var btnSound: AVAudioPlayer!
    
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var currentOperation: Opertation = Opertation.Empty
    var result = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundUrl = NSURL(fileURLWithPath: path!)
        //btnSound = AVAudioPlayer(contentsOfURL: soundUrl)
        
        do {
           try btnSound = AVAudioPlayer(contentsOfURL: soundUrl)
        } catch let err as NSError{
            print(err.debugDescription)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func numberPressed(btn: UIButton!){
        //playSound()
        runningNumber += "\(btn.tag)"
        outputLbl.text = runningNumber
        
    }

    @IBAction func onPressDivide(sender: AnyObject) {
        processOperation(Opertation.Divide)
        
    }

    @IBAction func onPressMultiply(sender: AnyObject) {
        processOperation(Opertation.Multiply)
    }
    
    @IBAction func onPressAdd(sender: AnyObject) {
        processOperation(Opertation.Add)
    }
    
    
    @IBAction func onPressSubtract(sender: AnyObject) {
        processOperation(Opertation.Subtract)
    }
    
    @IBAction func onPressEquals(sender: AnyObject) {
        processOperation(currentOperation)
    }
    
    @IBAction func onPressClear(sender: AnyObject) {
        rightValStr = ""
        leftValStr = ""
        runningNumber = ""
        result = ""
        currentOperation = Opertation.Empty
        outputLbl.text = "0.0"
    }
    
    func processOperation(op: Opertation){
        //playSound()
        
        if currentOperation != Opertation.Empty{
            //Run some math
            
            if runningNumber != ""{
              rightValStr = runningNumber
              runningNumber = ""  
               if currentOperation == Opertation.Multiply{
                result = "\(Double(leftValStr)! * Double(rightValStr)!)"
            }else if currentOperation == Opertation.Divide{
                result = "\(Double(leftValStr)! / Double(rightValStr)!)"
            }else if currentOperation == Opertation.Subtract{
                result = "\(Double(leftValStr)! - Double(rightValStr)!)"
            }else if currentOperation == Opertation.Add{
                result = "\(Double(leftValStr)! + Double(rightValStr)!)"
            }
            
            leftValStr = result
            outputLbl.text = result  
                
            }
           
            
            currentOperation = op
        }else {
            //this is the first time an operator has been pressed
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = op
        }
    }
    func playSound(){
        if btnSound.playing{
            btnSound.stop()
        }
        
        btnSound.play()
        
    }
    
    
    
    
    
    
    
}

