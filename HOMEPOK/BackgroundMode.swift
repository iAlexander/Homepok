//
//  BackgroundMode.swift
//  Prestoid - Dropbox sync video camera app with speech to text recognition
//  Application version 1.3, build 21
//
//  Created by Alexander Iashchuk on 2/12/17.
//  Copyright © 2016 Alexander Iashchuk (iAlexander), http://iashchuk.com
//  Application owner - Scott Leatham. All rights reserved.
//

import Foundation

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelTopDescription: UILabel!
    @IBOutlet weak var labelBottomDescription: UILabel!
    @IBOutlet weak var textFieldTwoLetters: UITextField!
    @IBOutlet weak var imageMapUkraine: UIImageView!
    @IBOutlet weak var imageCoatOfArms: UIImageView!
    
    var seriesOne: String = ""
    var seriesTwo: String = ""
    var launchCount: Double = 0
    var searchCount: Double = 0
    var reviewFrequency: Double = 0
    let numberOfAppLaunchesKey = "numberOfAppLaunches"
    let numberOfSearchesKey = "numberOfSearches"
    let reviewFrequencyKey = "reviewFrequency"
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        launchCount = defaults.double(forKey: numberOfAppLaunchesKey)
        searchCount = defaults.double(forKey: numberOfSearchesKey)
        reviewFrequency = defaults.double(forKey: reviewFrequencyKey)
        textFieldTwoLetters.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if launchCount > 0 {
            launchCount += 1
            defaults.set(launchCount, forKey: numberOfAppLaunchesKey)
            print("App Launch Count: \(launchCount)")
            textFieldTwoLetters.becomeFirstResponder()
        } else {
            launchCount += 1
            defaults.set(launchCount, forKey: numberOfAppLaunchesKey)
            reviewFrequency = 5
            defaults.set(reviewFrequency, forKey: reviewFrequencyKey)
            print("App Launch Count: \(launchCount)")
            goToTutorial()
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func tutorialButton(_ sender: Any) {
        goToTutorial()
    }
    
    @IBAction func unwindToMainView(segue: UIStoryboardSegue) {
    }
    
    func goToTutorial() {
        performSegue(withIdentifier: "tutorialSegue", sender: nil)
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        checkTheRegion(textFieldTwoLetters.text!)
        textFieldTwoLetters.resignFirstResponder()
        return true
    }
    
    func checkTheRegion (_ input: String) {
        if input == "" {
            return
        }
        textFieldTwoLetters.text!.removeAll()
        var twoLetters = String(input.characters.prefix(2))
        twoLetters = transformLetters(twoLetters)
        textFieldTwoLetters.placeholder = twoLetters
        let regionIndex = regionsIndexChecker(twoLetters)
        let region = regionsChecker(regionIndex)
        descriptionOutput(twoLetters, name: region, index: regionIndex)
        searchCount += 1
        defaults.set(searchCount, forKey: numberOfSearchesKey)
        print("Search Count: \(searchCount)")
        print("Review Frequency: \(reviewFrequency)")
        if searchCount.truncatingRemainder(dividingBy: reviewFrequency) == 0 {
            askAboutReview()
        }
    }
    
    func transformLetters (_ letters: String) -> String {
        let firstLetter = String(letters.characters.prefix(1))
        let secondLetter = String(letters.characters.suffix(1))
        var result = transformLetterToLatin(firstLetter)
        result += transformLetterToLatin(secondLetter)
        return result
    }
    
    func transformLetterToLatin (_ letter: String) -> String {
        var result = letter
        switch letter {
        case "A", "a", "А", "а":
            result = "A"
        case "B", "b", "В", "в":
            result = "B"
        case "C", "С", "c", "с":
            result = "C"
        case "E", "Е", "e", "е":
            result = "E"
        case "H", "Н", "h", "н":
            result = "H"
        case "I", "І", "i", "і":
            result = "I"
        case "K", "К", "k", "к":
            result = "K"
        case "M", "М", "m", "м":
            result = "M"
        case "O", "О", "o", "о":
            result = "O"
        case "P", "Р", "p", "р":
            result = "P"
        case "T", "Т", "t", "т":
            result = "T"
        case "X", "Х", "x", "х":
            result = "X"
        default:
            result = letter.uppercased()
        }
        return result
    }
    
    func regionsIndexChecker (_ letters: String) -> Int {
        var result = 29
        switch letters {
        case "AK", "KK":
            result = 1
            seriesOne = "AK"
            seriesTwo = "KK"
        case "AB", "KB":
            result = 2
            seriesOne = "AB"
            seriesTwo = "KB"
        case "AC", "KC":
            result = 3
            seriesOne = "AC"
            seriesTwo = "KC"
        case "AE", "KE":
            result = 4
            seriesOne = "AE"
            seriesTwo = "KE"
        case "AH", "KH":
            result = 5
            seriesOne = "AH"
            seriesTwo = "KH"
        case "AM", "KM":
            result = 6
            seriesOne = "AM"
            seriesTwo = "KM"
        case "AO", "KO":
            result = 7
            seriesOne = "AO"
            seriesTwo = "KO"
        case "AP", "KP":
            result = 8
            seriesOne = "AP"
            seriesTwo = "KP"
        case "AT", "KT":
            result = 9
            seriesOne = "AT"
            seriesTwo = "KT"
        case "AI", "KI":
            result = 10
            seriesOne = "AI"
            seriesTwo = "KI"
        case "AA", "KA":
            result = 11
            seriesOne = "AA"
            seriesTwo = "KA"
        case "BA", "HA":
            result = 12
            seriesOne = "BA"
            seriesTwo = "HA"
        case "BB", "HB":
            result = 13
            seriesOne = "BB"
            seriesTwo = "HB"
        case "BC", "HC":
            result = 14
            seriesOne = "BC"
            seriesTwo = "HC"
        case "BE", "HE":
            result = 15
            seriesOne = "BE"
            seriesTwo = "HE"
        case "BH", "HH":
            result = 16
            seriesOne = "BH"
            seriesTwo = "HH"
        case "BI", "HI":
            result = 17
            seriesOne = "BI"
            seriesTwo = "HI"
        case "BK", "HK":
            result = 18
            seriesOne = "BK"
            seriesTwo = "HK"
        case "BM", "HM":
            result = 19
            seriesOne = "BM"
            seriesTwo = "HM"
        case "BO", "HO":
            result = 20
            seriesOne = "BO"
            seriesTwo = "HO"
        case "AX", "KX":
            result = 21
            seriesOne = "AX"
            seriesTwo = "KX"
        case "BT", "HT":
            result = 22
            seriesOne = "BT"
            seriesTwo = "HT"
        case "BX", "HX":
            result = 23
            seriesOne = "BX"
            seriesTwo = "HX"
        case "CA", "IA":
            result = 24
            seriesOne = "CA"
            seriesTwo = "IA"
        case "CB", "IB":
            result = 25
            seriesOne = "CB"
            seriesTwo = "IB"
        case "CE", "IE":
            result = 26
            seriesOne = "CE"
            seriesTwo = "IE"
        case "CH", "IH":
            result = 27
            seriesOne = "CH"
            seriesTwo = "IH"
        case "II":
            result = 28
            seriesOne = "II"
        default:
            result = 29
        }
        return result
    }
    
    func regionsChecker (_ input: Int) -> String {
        var result = ""
        switch input {
        case 1:
            imageMapUkraine.image = UIImage(named: "mapUkraine01")
            imageCoatOfArms.image = UIImage(named: "coatOfArms01")
            result = localizedTextOutput("01")
        case 2:
            imageMapUkraine.image = UIImage(named: "mapUkraine02")
            imageCoatOfArms.image = UIImage(named: "coatOfArms02")
            result = localizedTextOutput("02")
        case 3:
            imageMapUkraine.image = UIImage(named: "mapUkraine03")
            imageCoatOfArms.image = UIImage(named: "coatOfArms03")
            result = localizedTextOutput("03")
        case 4:
            imageMapUkraine.image = UIImage(named: "mapUkraine04")
            imageCoatOfArms.image = UIImage(named: "coatOfArms04")
            result = localizedTextOutput("04")
        case 5:
            imageMapUkraine.image = UIImage(named: "mapUkraine05")
            imageCoatOfArms.image = UIImage(named: "coatOfArms05")
            result = localizedTextOutput("05")
        case 6:
            imageMapUkraine.image = UIImage(named: "mapUkraine06")
            imageCoatOfArms.image = UIImage(named: "coatOfArms06")
            result = localizedTextOutput("06")
        case 7:
            imageMapUkraine.image = UIImage(named: "mapUkraine07")
            imageCoatOfArms.image = UIImage(named: "coatOfArms07")
            result = localizedTextOutput("07")
        case 8:
            imageMapUkraine.image = UIImage(named: "mapUkraine08")
            imageCoatOfArms.image = UIImage(named: "coatOfArms08")
            result = localizedTextOutput("08")
        case 9:
            imageMapUkraine.image = UIImage(named: "mapUkraine09")
            imageCoatOfArms.image = UIImage(named: "coatOfArms09")
            result = localizedTextOutput("09")
        case 10:
            imageMapUkraine.image = UIImage(named: "mapUkraine10")
            imageCoatOfArms.image = UIImage(named: "coatOfArms10")
            result = localizedTextOutput("10")
        case 11:
            imageMapUkraine.image = UIImage(named: "mapUkraine11")
            imageCoatOfArms.image = UIImage(named: "coatOfArms11")
            result = localizedTextOutput("11")
        case 12:
            imageMapUkraine.image = UIImage(named: "mapUkraine12")
            imageCoatOfArms.image = UIImage(named: "coatOfArms12")
            result = localizedTextOutput("12")
        case 13:
            imageMapUkraine.image = UIImage(named: "mapUkraine13")
            imageCoatOfArms.image = UIImage(named: "coatOfArms13")
            result = localizedTextOutput("13")
        case 14:
            imageMapUkraine.image = UIImage(named: "mapUkraine14")
            imageCoatOfArms.image = UIImage(named: "coatOfArms14")
            result = localizedTextOutput("14")
        case 15:
            imageMapUkraine.image = UIImage(named: "mapUkraine15")
            imageCoatOfArms.image = UIImage(named: "coatOfArms15")
            result = localizedTextOutput("15")
        case 16:
            imageMapUkraine.image = UIImage(named: "mapUkraine16")
            imageCoatOfArms.image = UIImage(named: "coatOfArms16")
            result = localizedTextOutput("16")
        case 17:
            imageMapUkraine.image = UIImage(named: "mapUkraine17")
            imageCoatOfArms.image = UIImage(named: "coatOfArms17")
            result = localizedTextOutput("17")
        case 18:
            imageMapUkraine.image = UIImage(named: "mapUkraine18")
            imageCoatOfArms.image = UIImage(named: "coatOfArms18")
            result = localizedTextOutput("18")
        case 19:
            imageMapUkraine.image = UIImage(named: "mapUkraine19")
            imageCoatOfArms.image = UIImage(named: "coatOfArms19")
            result = localizedTextOutput("19")
        case 20:
            imageMapUkraine.image = UIImage(named: "mapUkraine20")
            imageCoatOfArms.image = UIImage(named: "coatOfArms20")
            result = localizedTextOutput("20")
        case 21:
            imageMapUkraine.image = UIImage(named: "mapUkraine21")
            imageCoatOfArms.image = UIImage(named: "coatOfArms21")
            result = localizedTextOutput("21")
        case 22:
            imageMapUkraine.image = UIImage(named: "mapUkraine22")
            imageCoatOfArms.image = UIImage(named: "coatOfArms22")
            result = localizedTextOutput("22")
        case 23:
            imageMapUkraine.image = UIImage(named: "mapUkraine23")
            imageCoatOfArms.image = UIImage(named: "coatOfArms23")
            result = localizedTextOutput("23")
        case 24:
            imageMapUkraine.image = UIImage(named: "mapUkraine24")
            imageCoatOfArms.image = UIImage(named: "coatOfArms24")
            result = localizedTextOutput("24")
        case 25:
            imageMapUkraine.image = UIImage(named: "mapUkraine25")
            imageCoatOfArms.image = UIImage(named: "coatOfArms25")
            result = localizedTextOutput("25")
        case 26:
            imageMapUkraine.image = UIImage(named: "mapUkraine26")
            imageCoatOfArms.image = UIImage(named: "coatOfArms26")
            result = localizedTextOutput("26")
        case 27:
            imageMapUkraine.image = UIImage(named: "mapUkraine27")
            imageCoatOfArms.image = UIImage(named: "coatOfArms27")
            result = localizedTextOutput("27")
        case 28:
            imageMapUkraine.image = UIImage(named: "mapUkraine28")
            imageCoatOfArms.image = UIImage(named: "coatOfArms28")
            result = localizedTextOutput("28")
        default:
            imageMapUkraine.image = UIImage(named: "mapUkraine28")
            imageCoatOfArms.image = UIImage(named: "coatOfArms29")
            result = localizedTextOutput("29")
        }
        return result
    }
    
    func descriptionOutput (_ region: String, name: String, index: Int) {
        switch index {
        case 28:
            labelTopDescription.text = localizedTextOutput("30") + " " + region + " - " + name
            labelBottomDescription.text = localizedTextOutput("31") + "\n\n" + localizedTextOutput("32")
        case 29:
            labelTopDescription.text = name
            labelBottomDescription.text = localizedTextOutput("33") + region + "\"...\n" + localizedTextOutput("34")
        default:
            labelTopDescription.text = localizedTextOutput("30") + " " + region + " - " + name
            labelBottomDescription.text = name + "\n\n" + localizedTextOutput("35") + " " + seriesOne + ", " + seriesTwo
        }
    }
    
    func localizedTextOutput (_ key: String) -> String {
        let path = Bundle.main.path(forResource: "LocalizedStrings", ofType: "plist")
        let localizedDict = NSDictionary(contentsOfFile: path!) as? [String: String]
        let result = localizedDict![key]! as String
        return result
    }
    
    func askAboutReview() {
        let url = URL(string: "itms-apps://itunes.apple.com/app/id1105827929")!
        let title = localizedTextOutput("rev1")
        let message = localizedTextOutput("rev2")
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        let cancelAction = UIAlertAction(title: localizedTextOutput("rev3"), style: .destructive, handler: { alertAction in
            self.reviewFrequency = self.reviewFrequency * 2
            self.defaults.set(self.reviewFrequency, forKey: self.reviewFrequencyKey)
        })
        let rateAction = UIAlertAction(title: localizedTextOutput("rev4"), style: .default, handler: { alertAction in
            if UIApplication.shared.canOpenURL(url) {
                self.reviewFrequency = self.reviewFrequency * 10
                self.defaults.set(self.reviewFrequency, forKey: self.reviewFrequencyKey)
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
            alert.dismiss(animated: true, completion: nil)
        })
        
        alert.addAction(cancelAction)
        alert.addAction(rateAction)
        present(alert, animated: true, completion: nil)
    }
    
}

class TutorialController: UIViewController {
    
    @IBOutlet weak var tutorialImageView: UIImageView!
    @IBOutlet weak var topTextLabel: UILabel!
    @IBOutlet weak var bottomTextLabel: UILabel!
    @IBOutlet weak var tutorialButton: UIButton!
    @IBOutlet weak var finishButton: UIButton!
    
    var tutorialSteps = 0
    var tutorialLaunchCount: Double = 0
    let numberOfTutorialLaunchesKey = "numberOfTutorialLaunches"
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tutorialLaunchCount = defaults.double(forKey: numberOfTutorialLaunchesKey)
        finishButton.isHidden = true
        if tutorialLaunchCount == 0 {
            tutorialLaunchCount += 1
            defaults.set(tutorialLaunchCount, forKey: numberOfTutorialLaunchesKey)
            topTextLabel.text = localizedTextOutput("t01")
            bottomTextLabel.text = localizedTextOutput("t02")
            print("Tutorial Launch Count: \(tutorialLaunchCount)")
        } else {
            tutorialLaunchCount += 1
            defaults.set(tutorialLaunchCount, forKey: numberOfTutorialLaunchesKey)
            tutorialSteps += 1
            tutorialImageView.image = UIImage(named: "Tutorial1")
            topTextLabel.text = localizedTextOutput("t11")
            bottomTextLabel.text = localizedTextOutput("t12")
            print("Tutorial Launch Count: \(tutorialLaunchCount)")
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
    
    @IBAction func nextButton(_ sender: Any) {
        tutorialSteps += 1
        if tutorialSteps == 1 {
            tutorialImageView.image = UIImage(named: "Tutorial1")
            topTextLabel.text = localizedTextOutput("t11")
            bottomTextLabel.text = localizedTextOutput("t12")
        } else if tutorialSteps == 2 {
            tutorialImageView.image = UIImage(named: "Tutorial2")
            topTextLabel.text = localizedTextOutput("t21")
            bottomTextLabel.text = localizedTextOutput("t22")
        } else if tutorialSteps == 3 {
            tutorialImageView.image = UIImage(named: "Tutorial3")
            topTextLabel.text = localizedTextOutput("t31")
            bottomTextLabel.text = localizedTextOutput("t32")
            tutorialButton.isHidden = true
            finishButton.isHidden = false
        }
    }
    
    func localizedTextOutput (_ key: String) -> String {
        let path = Bundle.main.path(forResource: "LocalizedStrings", ofType: "plist")
        let localizedDict = NSDictionary(contentsOfFile: path!) as? [String: String]
        let result = localizedDict![key]! as String
        return result
    }
    
}
