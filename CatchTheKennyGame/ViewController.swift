//
//  ViewController.swift
//  CatchTheKennyGame
//
//  Created by Hüseyin Özen Albayrak on 23.06.2023.
//

import UIKit

class ViewController: UIViewController {
    
    //Variables
    
    var score = 0
    var highscore = 0
    var timer = Timer()
    var counter = 0
    var kennyArray = [UIImageView]()
    var hideTimer = Timer()
    
    //Views
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highscoreLabel: UILabel!
    
    @IBOutlet weak var kenny1: UIImageView!
    @IBOutlet weak var kenny2: UIImageView!
    @IBOutlet weak var kenny3: UIImageView!
    @IBOutlet weak var kenny4: UIImageView!
    @IBOutlet weak var kenny5: UIImageView!
    @IBOutlet weak var kenny6: UIImageView!
    @IBOutlet weak var kenny7: UIImageView!
    @IBOutlet weak var kenny8: UIImageView!
    @IBOutlet weak var kenny9: UIImageView!
    @IBOutlet weak var kenny10: UIImageView!
    @IBOutlet weak var kenny11: UIImageView!
    @IBOutlet weak var kenny12: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        scoreLabel.text = "Score: \(score)"
        
        //HighScore check
        
        let storedHighScore = UserDefaults.standard.object(forKey: "highscore")
        
        if storedHighScore == nil {
            highscore = 0
            highscoreLabel.text = "Highscore: \(highscore)"
        }
        
        if let newScore = storedHighScore as? Int {
            highscore = newScore
            highscoreLabel.text = "Highscore: \(highscore)"
        }
        
        //Images & UITapGestureRecognizer
        
        kenny1.isUserInteractionEnabled = true
        kenny2.isUserInteractionEnabled = true
        kenny3.isUserInteractionEnabled = true
        kenny4.isUserInteractionEnabled = true
        kenny5.isUserInteractionEnabled = true
        kenny6.isUserInteractionEnabled = true
        kenny7.isUserInteractionEnabled = true
        kenny8.isUserInteractionEnabled = true
        kenny9.isUserInteractionEnabled = true
        kenny10.isUserInteractionEnabled = true
        kenny11.isUserInteractionEnabled = true
        kenny12.isUserInteractionEnabled = true
        
        let gestureRecognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer10 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer11 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer12 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        kenny1.addGestureRecognizer(gestureRecognizer1)
        kenny2.addGestureRecognizer(gestureRecognizer2)
        kenny3.addGestureRecognizer(gestureRecognizer3)
        kenny4.addGestureRecognizer(gestureRecognizer4)
        kenny5.addGestureRecognizer(gestureRecognizer5)
        kenny6.addGestureRecognizer(gestureRecognizer6)
        kenny7.addGestureRecognizer(gestureRecognizer7)
        kenny8.addGestureRecognizer(gestureRecognizer8)
        kenny9.addGestureRecognizer(gestureRecognizer9)
        kenny10.addGestureRecognizer(gestureRecognizer10)
        kenny11.addGestureRecognizer(gestureRecognizer11)
        kenny12.addGestureRecognizer(gestureRecognizer12)
        
        
        kennyArray = [kenny1, kenny2, kenny3, kenny4, kenny5, kenny6, kenny7, kenny8, kenny9, kenny10, kenny11, kenny12]
        //kennyArray.append(kenny1) ile aynı daha kısası (tek satırda)
        
        hideKenny()
        
        //Timer
        counter = 10
        timeLabel.text = "\(counter)"
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.7, target: self, selector: #selector(hideKenny), userInfo: nil, repeats: true)

    }

    @objc func hideKenny() {
        
        for kenny in kennyArray {
            kenny.isHidden = true
        }
        
        let random = Int(arc4random_uniform(UInt32(kennyArray.count - 1)))
        kennyArray[random].isHidden = false
    }
    
    @objc func increaseScore() {
        score += 1
        scoreLabel.text = "Score: \(score)"
    }
    
    @objc func countDown() {
        counter -= 1
        timeLabel.text = String(counter)
        
        if counter <= 0 {
            timer.invalidate()
            hideTimer.invalidate()
            
            //HighScore
            
            if score >= highscore {
                highscore = score
                highscoreLabel.text = "Highscore: \(highscore)"
                UserDefaults.standard.set(highscore, forKey: "highscore")
            }
            
            for kenny in kennyArray {
                kenny.isHidden = true
            }
            
            //Alert
            
            let alert = UIAlertController(title: "Time's Up", message: "Do you want to play again?", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { (UIAlertAction) in
                //replay function
                
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                self.counter = 10
                self.timeLabel.text = "\(self.counter)"
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.6, target: self, selector: #selector(self.hideKenny), userInfo: nil, repeats: true)
                
            }
            
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}

