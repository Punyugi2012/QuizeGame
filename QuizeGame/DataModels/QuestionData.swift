//
//  imageQuestionData.swift
//  QuizeGame
//
//  Created by punyawee  on 30/4/61.
//  Copyright © พ.ศ. 2561 punyawee . All rights reserved.
//

import Foundation

class QuestionData {
    class func getImageQuestions() -> [ImageQuestion] {
        return  [
            ImageQuestion("นก", ["นก", "แมว", "สุนัข", "น้ำตก"], "นก"),
            ImageQuestion("แมว", ["นก", "แมว", "สุนัข", "น้ำตก"], "แมว"),
            ImageQuestion("สุนัข", ["นก", "แมว", "สุนัข", "น้ำตก"], "สุนัข"),
            ImageQuestion("น้ำตก", ["นก", "แมว", "สุนัข", "น้ำตก"], "น้ำตก")
        ]
    }
    class func getSoundQuestions() -> [SoundQuestion] {
        return [
            SoundQuestion("ค้างคาว", ["ค้างคาว", "สุนัข", "งู", "นก"], "ค้างคาว")
        ]
    }
}