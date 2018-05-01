//
//  SoundQuestionViewController.swift
//  QuizeGame
//
//  Created by punyawee  on 1/5/61.
//  Copyright © พ.ศ. 2561 punyawee . All rights reserved.
//

import UIKit
import AVFoundation

class SoundQuestionViewController: UIViewController, AVAudioPlayerDelegate {

    @IBOutlet weak var currentQuestionLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet var buttons: [UIButton]!
    @IBOutlet weak var myConstraint: NSLayoutConstraint!
    @IBOutlet weak var myView: UIView!
    
    var questions: [SoundQuestion] = []
    var bufferQuestions: [SoundQuestion] = []
    var audioPlayer: AVAudioPlayer!
    var timer: Timer!
    var playing = false
    var currentQuestion = 1
    var corrected = 0
    var answer: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bufferQuestions = QuestionData.getSoundQuestions()
        self.questions = self.chooseSoundQuestion(10)
        self.setCurrentQuestionLabel()
        self.setQuestion()
    }
    
    func setCurrentQuestionLabel() {
        self.currentQuestionLabel.text = "ข้อ \(self.currentQuestion) / 10"
    }
    
    func setQuestion() {
        let numOfQuestion = Int(arc4random_uniform(UInt32(self.questions.count)))
        let question = self.questions[numOfQuestion]
        self.answer = question.soundName
        for i in 0...3 {
            self.buttons[i].setTitle(question.answers[i], for: .normal)
        }
        self.questions.remove(at: numOfQuestion)
    }
    
    @IBAction func onTouchAnswer(_ sender: UIButton) {
        UIApplication.shared.beginIgnoringInteractionEvents()
        if !questions.isEmpty {
            let preColor = sender.backgroundColor
            var preButton = UIButton()
            self.currentQuestion += 1
            if sender.currentTitle == self.answer {
                self.corrected += 1
                sender.backgroundColor = UIColor.green
            }
            else {
                sender.backgroundColor = UIColor.red
                for i in 0...3 {
                    if self.buttons[i].currentTitle == self.answer {
                        preButton = self.buttons[i]
                        self.buttons[i].backgroundColor = UIColor.green
                        break
                    }
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                self.stopSound()
                self.myConstraint.constant = -500
                sender.backgroundColor = preColor
                preButton.backgroundColor = preColor
                self.animateView()
            }
        }
        else {
            if sender.currentTitle == self.answer {
                self.corrected += 1
                sender.backgroundColor = UIColor.green
            }
            else {
                sender.backgroundColor = UIColor.red
                for i in 0...3 {
                    if self.buttons[i].currentTitle == self.answer {
                        self.buttons[i].backgroundColor = UIColor.green
                        break
                    }
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                self.stopSound()
                self.performSegue(withIdentifier: "ToFinish", sender: self)
                UIApplication.shared.endIgnoringInteractionEvents()
            }
        }
    }
    

    func chooseSoundQuestion(_ number: Int) -> [SoundQuestion] {
        var soundQuestions: [SoundQuestion] = []
        var i = 1
        while i <= number {
            let random = Int(arc4random_uniform(UInt32(self.bufferQuestions.count)))
            if (soundQuestions.index { (soundQuestion) -> Bool in
                return soundQuestion.soundName == self.bufferQuestions[random].soundName
            }) == nil {
                soundQuestions.append(self.bufferQuestions[random])
                i += 1
            }
        }
        return soundQuestions
    }
    
    @IBAction func onPlay() {
        if self.playing == false {
            guard let url = Bundle.main.url(forResource: self.answer, withExtension: "mp3") else {
                print("Error URl")
                return
            }
            
            do {
                self.audioPlayer = try AVAudioPlayer(contentsOf: url)
                self.audioPlayer.delegate = self
                self.audioPlayer.prepareToPlay()
                self.audioPlayer.currentTime = 0
                self.audioPlayer.play()
                self.playing = true
            } catch let error as NSError {
                print(error.debugDescription)
                return
            }
            
            let pulse = Pulsing(numberOfPulses: 1, radius: 110, position: self.playButton.center)
            pulse.animationDuration = 0.8
            pulse.backgroundColor = UIColor.blue.cgColor
            self.myView.layer.insertSublayer(pulse, below: self.playButton.layer)
            
            self.timer = Timer.scheduledTimer(withTimeInterval: 0.8, repeats: true) { (timer) in
                let pulse = Pulsing(numberOfPulses: 1, radius: 110, position: self.playButton.center)
                pulse.animationDuration = 0.8
                pulse.backgroundColor = UIColor.blue.cgColor
                self.myView.layer.insertSublayer(pulse, below: self.playButton.layer)
            }
        }
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        self.stopTimer()
        self.playing = false
    }
    
    
    func stopSound() {
        if self.audioPlayer != nil {
            self.audioPlayer.stop()
            self.audioPlayer.currentTime = 0
        }
        self.playing = false
        self.stopTimer()
    }
    
    func stopTimer() {
        if self.timer != nil {
            self.timer.invalidate()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToFinish" {
            let destination = segue.destination as! FinishedImageQuestionViewController
            destination.getCorreted = self.corrected
            destination.typeAgain = "ToSoundQuestionAgain"
        }
    }
    
    func animateView() {
        UIView.transition(with: self.myView, duration: 0.3, options: [], animations: {
            self.playButton.alpha = 0
            self.myView.alpha = 0
            self.myConstraint.constant = -500
            self.view.layoutIfNeeded()
        }) { (true) in
            self.setCurrentQuestionLabel()
            self.setQuestion()
            UIView.transition(with: self.myView, duration: 0.3, options: [], animations: {
                self.playButton.alpha = 1
                self.myView.alpha = 1
                self.myConstraint.constant = 0
            }, completion: { (true) in
                UIApplication.shared.endIgnoringInteractionEvents()
            })
        }
    }
    
}

