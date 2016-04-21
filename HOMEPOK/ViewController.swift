//
//  ViewController.swift
//  HOMEPOK
//
//  Created by Alexander Iashchuk on 4/15/16.
//  Copyright © 2016 Alexander Iashchuk. All rights reserved.
//

import UIKit
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
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		self.textFieldTwoLetters.delegate = self
		textFieldTwoLetters.becomeFirstResponder()
		labelTopDescription.text = "Введіть перші дві літери номера"
	}
	
	func textFieldShouldReturn(textField: UITextField) -> Bool {
		checkTheRegion(textFieldTwoLetters.text!)
		textFieldTwoLetters.resignFirstResponder()
		return true
	}
	
	func checkTheRegion (input: String) {
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
	}
	
	func transformLetters (letters: String) -> String {
		let firstLetter = String(letters.characters.prefix(1))
		let secondLetter = String(letters.characters.suffix(1))
		var result = transformLetterToLatin(firstLetter)
		result += transformLetterToLatin(secondLetter)
		return result
	}
	
	func transformLetterToLatin (letter: String) -> String {
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
			result = letter.uppercaseString
		}
		return result
	}
	
	func regionsIndexChecker (letters: String) -> Int {
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
	
	func regionsChecker (input: Int) -> String {
		var result = ""
		switch input {
		case 1:
			imageMapUkraine.image = UIImage(named: "mapUkraine01")
			imageCoatOfArms.image = UIImage(named: "coatOfArms01")
			result = "Автономна Республіка Крим"
		case 2:
			imageMapUkraine.image = UIImage(named: "mapUkraine02")
			imageCoatOfArms.image = UIImage(named: "coatOfArms02")
			result = "Вінницька область"
		case 3:
			imageMapUkraine.image = UIImage(named: "mapUkraine03")
			imageCoatOfArms.image = UIImage(named: "coatOfArms03")
			result = "Волинська область"
		case 4:
			imageMapUkraine.image = UIImage(named: "mapUkraine04")
			imageCoatOfArms.image = UIImage(named: "coatOfArms04")
			result = "Дніпропетровська область"
		case 5:
			imageMapUkraine.image = UIImage(named: "mapUkraine05")
			imageCoatOfArms.image = UIImage(named: "coatOfArms05")
			result = "Донецька область"
		case 6:
			imageMapUkraine.image = UIImage(named: "mapUkraine06")
			imageCoatOfArms.image = UIImage(named: "coatOfArms06")
			result = "Житомирська область"
		case 7:
			imageMapUkraine.image = UIImage(named: "mapUkraine07")
			imageCoatOfArms.image = UIImage(named: "coatOfArms07")
			result = "Закарпатська область"
		case 8:
			imageMapUkraine.image = UIImage(named: "mapUkraine08")
			imageCoatOfArms.image = UIImage(named: "coatOfArms08")
			result = "Запорізька область"
		case 9:
			imageMapUkraine.image = UIImage(named: "mapUkraine09")
			imageCoatOfArms.image = UIImage(named: "coatOfArms09")
			result = "Івано-Франківська область"
		case 10:
			imageMapUkraine.image = UIImage(named: "mapUkraine10")
			imageCoatOfArms.image = UIImage(named: "coatOfArms10")
			result = "Київська область"
		case 11:
			imageMapUkraine.image = UIImage(named: "mapUkraine11")
			imageCoatOfArms.image = UIImage(named: "coatOfArms11")
			result = "Місто Київ"
		case 12:
			imageMapUkraine.image = UIImage(named: "mapUkraine12")
			imageCoatOfArms.image = UIImage(named: "coatOfArms12")
			result = "Кіровоградська область"
		case 13:
			imageMapUkraine.image = UIImage(named: "mapUkraine13")
			imageCoatOfArms.image = UIImage(named: "coatOfArms13")
			result = "Луганська область"
		case 14:
			imageMapUkraine.image = UIImage(named: "mapUkraine14")
			imageCoatOfArms.image = UIImage(named: "coatOfArms14")
			result = "Львівська область"
		case 15:
			imageMapUkraine.image = UIImage(named: "mapUkraine15")
			imageCoatOfArms.image = UIImage(named: "coatOfArms15")
			result = "Миколаївська область"
		case 16:
			imageMapUkraine.image = UIImage(named: "mapUkraine16")
			imageCoatOfArms.image = UIImage(named: "coatOfArms16")
			result = "Одеська область"
		case 17:
			imageMapUkraine.image = UIImage(named: "mapUkraine17")
			imageCoatOfArms.image = UIImage(named: "coatOfArms17")
			result = "Полтавська область"
		case 18:
			imageMapUkraine.image = UIImage(named: "mapUkraine18")
			imageCoatOfArms.image = UIImage(named: "coatOfArms18")
			result = "Рівненська область"
		case 19:
			imageMapUkraine.image = UIImage(named: "mapUkraine19")
			imageCoatOfArms.image = UIImage(named: "coatOfArms19")
			result = "Сумська область"
		case 20:
			imageMapUkraine.image = UIImage(named: "mapUkraine20")
			imageCoatOfArms.image = UIImage(named: "coatOfArms20")
			result = "Тернопільська область"
		case 21:
			imageMapUkraine.image = UIImage(named: "mapUkraine21")
			imageCoatOfArms.image = UIImage(named: "coatOfArms21")
			result = "Харківська область"
		case 22:
			imageMapUkraine.image = UIImage(named: "mapUkraine22")
			imageCoatOfArms.image = UIImage(named: "coatOfArms22")
			result = "Херсонська область"
		case 23:
			imageMapUkraine.image = UIImage(named: "mapUkraine23")
			imageCoatOfArms.image = UIImage(named: "coatOfArms23")
			result = "Хмельницька область"
		case 24:
			imageMapUkraine.image = UIImage(named: "mapUkraine24")
			imageCoatOfArms.image = UIImage(named: "coatOfArms24")
			result = "Черкаська область"
		case 25:
			imageMapUkraine.image = UIImage(named: "mapUkraine25")
			imageCoatOfArms.image = UIImage(named: "coatOfArms25")
			result = "Чернігівська область"
		case 26:
			imageMapUkraine.image = UIImage(named: "mapUkraine26")
			imageCoatOfArms.image = UIImage(named: "coatOfArms26")
			result = "Чернівецька область"
		case 27:
			imageMapUkraine.image = UIImage(named: "mapUkraine27")
			imageCoatOfArms.image = UIImage(named: "coatOfArms27")
			result = "Місто Севастополь"
		case 28:
			imageMapUkraine.image = UIImage(named: "mapUkraine28")
			imageCoatOfArms.image = UIImage(named: "coatOfArms28")
			result = "Загальнодержавна серія"
		default:
			imageMapUkraine.image = UIImage(named: "mapUkraine28")
			imageCoatOfArms.image = UIImage(named: "coatOfArms29")
			result = "Такого автомобільного номера не існує"
		}
		return result
	}

	func descriptionOutput (region: String, name: String, index: Int) {
		switch index {
		case 28:
			labelTopDescription.text = "Серія " + region + " - " + name
			labelBottomDescription.text = "Загальнодержавна серія номерних знаків для держслужбовців." + "\n\n" + "З 2006 року припинено видачу номерів серії ІІ."
		case 29:
			labelTopDescription.text = name
			labelBottomDescription.text = "Ви помилково ввели \"" + region + "\"... " + "Нажаль такого номера не існує. Гляньте навкруги, та спробуйте ввести перші літери з номера реального автомобіля що поруч!"
		default:
			labelTopDescription.text = "Серія " + region + " - " + name
			labelBottomDescription.text = name + "\n\n" + "Серії номерів: " + seriesOne + ", " + seriesTwo
		}
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

