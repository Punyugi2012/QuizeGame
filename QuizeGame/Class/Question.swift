//
//  Question.swift
//  QuizeGame
//
//  Created by punyawee  on 29/4/61.
//  Copyright © พ.ศ. 2561 punyawee . All rights reserved.
//

import Foundation

class ImageQuestion {
    var image: String
    var answers: [String]
    var answer: String
    init(_ image: String, _ answers: [String], _ answer: String) {
        self.image = image
        self.answers = answers
        self.answer = answer
    }
}

class SoundQuestion {
    var soundName: String
    var answers: [String]
    var answer: String
    init(_ soundName: String, _ answers: [String], _ answer: String) {
        self.soundName = soundName
        self.answers = answers
        self.answer = answer
    }
}
