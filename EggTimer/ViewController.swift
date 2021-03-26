//
//  ViewController.swift
//  EggTimer
//
//  Created by Павел Кривцов on 26.03.2021.
//

import UIKit

enum EggTimer: Int {
    case SoftBoiled = 140
    case InAPouch = 280
    case HardBoiled = 360
}

class ViewController: UIViewController {
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var softBoiledButton: UIButton!
    @IBOutlet weak var inAPouchButton: UIButton!
    @IBOutlet weak var hardBoiledButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    
    var selectedTimer: EggTimer = .HardBoiled
    var timer = Timer()
    var isTimerStarted = false
    var counter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hightlightSelectedButton()
        timerLabel.text = NSString(format: "%0.2d:%0.2d",
                                   selectedTimer.rawValue / 60,
                                   selectedTimer.rawValue % 60) as String
    }

    @IBAction func eggButtonPressed(_ sender: UIButton) {
        switch sender {
        case softBoiledButton:
            selectedTimer = .SoftBoiled
        case inAPouchButton:
            selectedTimer = .InAPouch
        case hardBoiledButton:
            selectedTimer = .HardBoiled
        default:
            break
        }
        
        hightlightSelectedButton()
        resetCounter()
    }
    
    @IBAction func startButtonPressed(_ sender: UIButton) {
        isTimerStarted.toggle()
        updateButtons()
        
        if isTimerStarted {
            timer = Timer.scheduledTimer(timeInterval: 1,
                                         target: self,
                                         selector: #selector(ViewController.timerTick),
                                         userInfo: nil,
                                         repeats: true)
        } else {
            timer.invalidate()
            resetCounter()
        }
    }
    
    @objc func timerTick() {
        counter -= 1
        if counter < 0 {
            timerLabel.text = "DONE!"
        } else {
            timerLabel.text = NSString(format: "%0.2d:%0.2d", counter / 60, counter % 60) as String
        }
    }
    
    func resetCounter() {
        counter = selectedTimer.rawValue
        timerLabel.text = NSString(format: "%0.2d:%0.2d", counter / 60, counter % 60) as String
    }
    
    func updateButtons() {
        softBoiledButton.isEnabled = !isTimerStarted
        inAPouchButton.isEnabled = !isTimerStarted
        hardBoiledButton.isEnabled = !isTimerStarted
        
        startButton.setImage(UIImage(named: isTimerStarted ? "stop-button" : "play-button"), for: .normal)
        
        if selectedTimer == .SoftBoiled {
            softBoiledButton.setImage(UIImage(named: isTimerStarted ? "selectedEggCook" : "egg1"), for: .normal)
        } else if selectedTimer == .InAPouch {
            inAPouchButton.setImage(UIImage(named: isTimerStarted ? "selectedEggCook" : "egg2"), for: .normal)
        } else if selectedTimer == .HardBoiled {
            hardBoiledButton.setImage(UIImage(named: isTimerStarted ? "selectedEggCook" : "egg3"), for: .normal)
        }
    }
    
    func hightlightSelectedButton() {
        softBoiledButton.isHighlighted = selectedTimer != .SoftBoiled
        inAPouchButton.isHighlighted = selectedTimer != .InAPouch
        hardBoiledButton.isHighlighted = selectedTimer != .HardBoiled
    }
    
}

