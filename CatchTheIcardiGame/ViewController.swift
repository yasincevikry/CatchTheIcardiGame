//
//  ViewController.swift
//  CatchTheIcardiGame
//
//  Created by Yasin Çevik on 23.03.2023.
//

import UIKit

class ViewController: UIViewController {

    //    Variables
    var score = 0
    var timer = Timer()
    var hideTimer = Timer()
    var counter = 0
    var icardiArray = [UIImageView]()
    var highScore = 0
    
//    Views
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var icardi1: UIImageView!
    @IBOutlet weak var icardi2: UIImageView!
    @IBOutlet weak var icardi3: UIImageView!
    @IBOutlet weak var icardi4: UIImageView!
    @IBOutlet weak var icardi5: UIImageView!
    @IBOutlet weak var icardi6: UIImageView!
    @IBOutlet weak var icardi7: UIImageView!
    @IBOutlet weak var icardi8: UIImageView!
    @IBOutlet weak var icardi9: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreLabel.text = "Score : \(score)"
//        High Score Check
        let storedHighScore = UserDefaults.standard.object(forKey: "highScore")
        
        if storedHighScore == nil {
            highScore = 0
            highScoreLabel.text = "HighScore : \(highScore)"
        }
        if let newScore = storedHighScore as? Int{
            highScore = newScore
            highScoreLabel.text = "HighScore : \(highScore)"
        }
        
//        Images
        icardi1.isUserInteractionEnabled = true
        icardi2.isUserInteractionEnabled = true
        icardi3.isUserInteractionEnabled = true
        icardi4.isUserInteractionEnabled = true
        icardi5.isUserInteractionEnabled = true
        icardi6.isUserInteractionEnabled = true
        icardi7.isUserInteractionEnabled = true
        icardi8.isUserInteractionEnabled = true
        icardi9.isUserInteractionEnabled = true

        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))

        icardi1.addGestureRecognizer(recognizer1)
        icardi2.addGestureRecognizer(recognizer2)
        icardi3.addGestureRecognizer(recognizer3)
        icardi4.addGestureRecognizer(recognizer4)
        icardi5.addGestureRecognizer(recognizer5)
        icardi6.addGestureRecognizer(recognizer6)
        icardi7.addGestureRecognizer(recognizer7)
        icardi8.addGestureRecognizer(recognizer8)
        icardi9.addGestureRecognizer(recognizer9)
        
        icardiArray = [icardi1,icardi2,icardi3,icardi4,icardi5,icardi6,icardi7,icardi8,icardi9]
        

//        Timers
        counter = 15
        timeLabel.text = String(counter)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.75, target: self, selector: #selector(hideIcardi), userInfo: nil, repeats: true)
        hideIcardi()
         
    }
    
    @objc func hideIcardi(){
        for icardi in icardiArray {
            icardi.isHidden = true
        }
        let random = Int (arc4random_uniform(UInt32(icardiArray.count - 1)))
        icardiArray[random].isHidden = false
        
    }

    @objc func increaseScore(){
        score += 1
        scoreLabel.text = "Score : \(score)"
        
    }

    @objc func countDown(){
        counter -= 1
        timeLabel.text = String(counter)
        
        if counter == 0{
            timer.invalidate()
            hideTimer.invalidate()
            for icardi in icardiArray {
                icardi.isHidden = true
            }
//           HighScore
            
            if self.score > self.highScore{
                self.highScore = self.score
                highScoreLabel.text = "High Score : \(self.highScore)"
                UserDefaults.standard.setValue(self.highScore, forKey: "highScore")
            }
            
//            Alert
            
            let alert = UIAlertController(title: "Time is up", message: "Do you want to play again", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "Okey", style: UIAlertAction.Style.cancel,handler: nil)
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { UIAlertAction in
//                replay
                self.score = 0
                self.scoreLabel.text = "Score : \(self.score)"
                self.counter = 15
                self.timeLabel.text = String(self.counter)
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideIcardi), userInfo: nil, repeats: true)
                
            }
            alert.addAction(replayButton)
            alert.addAction(okButton)
            self.present(alert, animated: true, completion: nil)
            
        }
    }
}
