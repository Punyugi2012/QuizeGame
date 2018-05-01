//
//  FinishedImageQuestionViewController.swift
//  QuizeGame
//
//  Created by punyawee  on 29/4/61.
//  Copyright © พ.ศ. 2561 punyawee . All rights reserved.
//

import UIKit

class FinishedImageQuestionViewController: UIViewController {
    
    @IBOutlet weak var correctedLabel: UILabel!
    @IBOutlet weak var inCorrectedLabel: UILabel!
    
    var getCorreted: Int = 0
    var typeAgain: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.correctedLabel.text = "ถูก \(getCorreted) ข้อ"
        self.inCorrectedLabel.text = "ผิด \(10-getCorreted) ข้อ"

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onPlayAgain(_ sender: UIButton) {
        performSegue(withIdentifier: self.typeAgain, sender: self)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
