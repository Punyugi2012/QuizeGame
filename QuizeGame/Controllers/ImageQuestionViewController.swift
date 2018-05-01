//
//  ImageQuestionViewController.swift
//  QuizeGame
//
//  Created by punyawee  on 29/4/61.
//  Copyright © พ.ศ. 2561 punyawee . All rights reserved.
//

import UIKit

class ImageQuestionViewController: UIViewController {

    var questions: [ImageQuestion] = []
    var bufferQuestions: [ImageQuestion] = []
    @IBOutlet var myButtons: [UIButton]!
    @IBOutlet weak var questionImage: UIImageView!
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var myConstraint: NSLayoutConstraint!
    @IBOutlet weak var currentQuestionLabel: UILabel!
    
    var answer = ""
    var corrected = 0
    var currentQuestion = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bufferQuestions = QuestionData.getImageQuestions()
        self.questions = self.chooseImageQuestion(10)
        self.currentQuestionLabel.text = "ข้อ \(self.currentQuestion) / 10"
        self.setQuestion()
    }
    
    func chooseImageQuestion(_ number: Int) -> [ImageQuestion] {
        var imageQuestions: [ImageQuestion] = []
        var i = 1
        while i <= number {
            let random = Int(arc4random_uniform(UInt32(self.bufferQuestions.count)))
            if (imageQuestions.index { (imageQuestion) -> Bool in
                return imageQuestion.image == self.bufferQuestions[random].image
            }) == nil {
                imageQuestions.append(self.bufferQuestions[random])
                i += 1
            }
        }
        return imageQuestions
    }
    
    func setQuestion() {
        let numOfQuestion = Int(arc4random_uniform(UInt32(self.questions.count)))
        let question = self.questions[numOfQuestion]
        self.answer = question.image
        self.questionImage.image = UIImage(named: question.image)
        for i in 0...3 {
            self.myButtons[i].setTitle(question.answers[i], for: .normal)
        }
        self.questions.remove(at: numOfQuestion)
    }
    
    
    @IBAction func touchAnswer(_ sender: UIButton) {
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
                    if self.myButtons[i].currentTitle == self.answer {
                        preButton = self.myButtons[i]
                        self.myButtons[i].backgroundColor = UIColor.green
                        break
                    }
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
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
                    if self.myButtons[i].currentTitle == self.answer {
                        self.myButtons[i].backgroundColor = UIColor.green
                        break
                    }
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.performSegue(withIdentifier: "ToFinish", sender: self)
                UIApplication.shared.endIgnoringInteractionEvents()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToFinish" {
            let destination = segue.destination as! FinishedImageQuestionViewController
            destination.getCorreted = self.corrected
        }
    }
    
    func animateView() {
        UIView.transition(with: self.myView, duration: 0.3, options: [], animations: {
            self.myView.alpha = 0
            self.myConstraint.constant = -500
            self.view.layoutIfNeeded()
        }) { (true) in
            self.currentQuestionLabel.text = "ข้อ \(self.currentQuestion) / 10"
            self.setQuestion()
            UIView.transition(with: self.myView, duration: 0.3, options: [], animations: {
                self.myView.alpha = 1
                self.myConstraint.constant = 0
            }, completion: { (true) in
                UIApplication.shared.endIgnoringInteractionEvents()
            })
        }
    }
    
}

