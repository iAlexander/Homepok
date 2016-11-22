//
//  TutorialController.swift
//  HOMEPOK
//
//  Created by Alexander Iashchuk on 11/21/16.
//  Copyright © 2016 Alexander Iashchuk. All rights reserved.
//

import UIKit

class TutorialController: UIViewController {
    
    @IBOutlet weak var tutorialImageView: UIImageView!
    @IBOutlet weak var topTextLabel: UILabel!
    @IBOutlet weak var bottomTextLabel: UILabel!
    @IBOutlet weak var tutorialButton: UIButton!
    @IBOutlet weak var finishButton: UIButton!
    
    var tutorialSteps = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        finishButton.isHidden = true
        topTextLabel.text = "Для того щоб перевірити номер"
        bottomTextLabel.text = "потрібно тапнути на перші дві літери"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func nextButton(_ sender: Any) {
        tutorialSteps += 1
        if tutorialSteps == 2 {
            tutorialImageView.image = UIImage(named: "Tutorial2")
            topTextLabel.text = "Тепер введіть перші дві літери"
            bottomTextLabel.text = "й тапніть на кнопку \"Пошук\""
        } else if tutorialSteps == 3 {
            tutorialImageView.image = UIImage(named: "Tutorial3")
            topTextLabel.text = "Вітаємо, ви закінчили навчання!"
            bottomTextLabel.text = "Тепер можете користуватись програмою"
            tutorialButton.isHidden = true
            finishButton.isHidden = false
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .portrait
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
//    }

}
