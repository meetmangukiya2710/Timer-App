//
//  ViewController.swift
//  Timer App
//
//  Created by R95 on 27/02/24.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var timerLableOutlet: UILabel!
    
    @IBOutlet weak var startButtonOutlet: UIButton!
    
    @IBOutlet weak var resetButtonOutlet: UIButton!
    
    var timer : Timer = Timer()
    var cout : Int = 0
    var timerCounting : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startButtonOutlet.setTitleColor(UIColor.green, for: .normal)
    }

    
    @IBAction func resetButtonAction(_ sender: Any) {
        let alert = UIAlertController(title: "Reset Timer", message: "Reset Timer", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "cancel", style: .default))
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { _ in
            self.cout = 0
            self.timer.invalidate()
            self.timerLableOutlet.text = self.timeString(hour: 0, minutes: 0, second: 0)
            self.startButtonOutlet.setTitle("Start", for: .normal)
            self.startButtonOutlet.setTitleColor(UIColor.green, for: .normal)
        }))
        
        present(alert, animated: true)
    }
    
    @IBAction func startButtonAction(_ sender: Any) {
        if (timerCounting ) {
            timerCounting = false
            timer.invalidate()
            startButtonOutlet.setTitle("Start", for: .normal)
            startButtonOutlet.setTitleColor(UIColor.green, for: .normal)
        }
        else {
            timerCounting = true
            startButtonOutlet.setTitle("Stop", for: .normal)
            startButtonOutlet.setTitleColor(UIColor.red, for: .normal)
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
        }
    }
    
    @objc func timerCounter() -> Void {
        cout = cout + 1
        let time = secToHourMinuSec(sec: cout)
        let timeString = timeString(hour: 0, minutes: time.1, second: time.2)
        timerLableOutlet.text = timeString
    }
    
    func secToHourMinuSec(sec: Int) -> (Int, Int, Int) {
        return ((sec/3600) , ((sec%3600)/60), ((sec%3600)%60))
    }
    
    func timeString(hour: Int, minutes: Int, second: Int)-> String {
        var timeString = ""
        
        timeString += String(format: "0%2d", hour)
        timeString += " : "
        
        timeString += String(format: "0%2d", minutes)
        timeString += " : "
        
        timeString += String(format: "0%2d", second)
        
        return timeString
    }
    
}

