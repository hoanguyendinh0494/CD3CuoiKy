//
//  MainViewController.swift
//  Add 1
//
//  Created by Reinder de Vries on 11-06-15.
//  Copyright (c) 2015 LearnAppMaking. All rights reserved.
//

import UIKit
import MBProgressHUD

class MainViewController: UIViewController
{
    @IBOutlet weak var numbersLabel:UILabel?
    @IBOutlet weak var scoreLabel:UILabel?
    @IBOutlet weak var inputField:UITextField?
    @IBOutlet weak var timeLabel:UILabel?
    
    var score:Int = 0
    var timer:Timer?
    var seconds:Int = 60
    
    var hud:MBProgressHUD?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        setRandomNumberLabel()
        updateScoreLabel()
        updateTimeLabel()
        
        hud = MBProgressHUD(view:self.view)
        
        if(hud != nil)
        {
            self.view.addSubview(hud!)
        }
        
        inputField?.addTarget(self, action: #selector(textFieldDidChange(textField:)), for:UIControlEvents.editingChanged)
    }
    
    func textFieldDidChange(textField:UITextField)
    {
        if inputField?.text?.characters.count ?? 0 < 1
        {
            return
        }
        
        if  let numbers_text    = numbersLabel?.text,
            let input_text      = inputField?.text,
            let numbers         = String(numbers_text),
            let input           = String(input_text)
        {
            //print("Comparing: \(input_text) minus \(numbers_text) == \(input - numbers)")
            var result = ""
            var dem: Int = 0
            var temp: Int = 0;
            var array = ["school", "student", "computer", "football", "keyboard", "father", "mother", "morning", "mouse", "soccer", "chicken", "monitor", "lable", "think", "phone", "driver"]
            for var letter in numbers.characters {
                if letter == "_" {
                    //letter = input
                    //word.characters += letter
                    temp = temp + 1
                    result.append(input)
                }
                else{
                    temp = temp + 1
                    result.append(letter)
                }
            }
            for item in array{
            //if(input - numbers == 1111)
                if result == item {
                    dem = dem + 1
                }
            }
            if(dem == 1)
            {
                print("Correct!")
                
                score += 1
                
                showHUDWithAnswer(isRight: true)
            }
            else
            {
                print("Incorrect!")
                
                score -= 1
                
                showHUDWithAnswer(isRight: false)
            }
        }
        
        setRandomNumberLabel()
        updateScoreLabel()
        
        if(timer == nil)
        {
            timer = Timer.scheduledTimer(timeInterval: 1.0, target:self, selector:#selector(onUpdateTimer), userInfo:nil, repeats:true)
        }
    }
    
    func onUpdateTimer()
    {
        if(seconds > 0 && seconds <= 60)
        {
            seconds -= 1
            
            updateTimeLabel()
        }
        else if(seconds == 0)
        {
            if(timer != nil)
            {
                timer!.invalidate()
                timer = nil
                
                let alertController = UIAlertController(title: "Time Up!", message: "Your time is up! You got a score of: \(score) points. Very good!", preferredStyle: .alert)
                let restartAction = UIAlertAction(title: "Restart", style: .default, handler: nil)
                alertController.addAction(restartAction)
                
                self.present(alertController, animated: true, completion: nil)
                
                score = 0
                seconds = 60
                
                updateTimeLabel()
                updateScoreLabel()
                setRandomNumberLabel()
            }   
        }  
    }
    
    func updateTimeLabel()
    {
        if(timeLabel != nil)
        {
            let min:Int = (seconds / 60) % 60
            let sec:Int = seconds % 60
            
            let min_p:String = String(format: "%02d", min)
            let sec_p:String = String(format: "%02d", sec)
            
            timeLabel!.text = "\(min_p):\(sec_p)"
        }
    }
    
    func showHUDWithAnswer(isRight:Bool)
    {
        var imageView:UIImageView?
        
        if isRight
        {
            imageView = UIImageView(image: UIImage(named:"thumbs-up"))
        }
        else
        {
            imageView = UIImageView(image: UIImage(named:"thumbs-down"))
        }
        
        if(imageView != nil)
        {
            hud?.mode = MBProgressHUDMode.customView
            hud?.customView = imageView
            
            hud?.show(animated: true)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.hud?.hide(animated: true)
                self.inputField?.text = ""
            }
        }
    }
    
    func updateScoreLabel()
    {
        scoreLabel?.text = "\(score)"
    }
    
    func setRandomNumberLabel()
    {
        numbersLabel?.text = generateRandomNumber()
    }
    
    func generateRandomNumber() -> String
    {
        var result = ""
        var word: String = ""
        var array = ["school", "student", "computer", "football", "keyboard", "father", "mother", "morning", "mouse", "soccer", "chicken", "monitor", "lable", "think", "phone", "driver"]
        var randomIndex = Int(arc4random_uniform(UInt32(array.count)))
        var array1 = ["school", "student", "computer", "football", "keyboard"]
        var randomIndex1 = Int(arc4random_uniform(UInt32(array1.count)))

        for _ in 1...5
        {
            //digit = Int(arc4random_uniform(8) + 1)

            //result += "\(digit)"
        }
        word = array[randomIndex]
        var temp: Int = 0;
        for var letter in word.characters {
            if temp == randomIndex1 {
                letter = "_"
                //word.characters += letter
                temp = temp + 1
                result.append(letter)
            }
            else{
                temp = temp + 1
                result.append(letter)
            }
        }
        return result
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
