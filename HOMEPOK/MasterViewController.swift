//
//  MasterViewController.swift
//  Prestoid - Dropbox sync video camera app with speech to text recognition
//  Application version 1.3, build 21
//
//  Created by Alexander Iashchuk on 11/9/16.
//  Copyright © 2016 Alexander Iashchuk (iAlexander), http://iashchuk.com
//  Application owner - Scott Leatham. All rights reserved.
//

import UIKit
import AVFoundation

class MasterViewController: UITableViewController {
    
    var detailViewController: PlayerViewController? = nil
    var videosArray: [String] = Array()
    let savedVideosArrayKey = "savedVideosArray"
    var speechArray: [String] = Array()
    let savedSpeechArrayKey = "savedSpeechArray"
    
    var cellInformationContent = [Int: Bool]()
    var cellTextContent = [Int: Bool]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let defaults = UserDefaults.standard
        if let arrayValue = defaults.array(forKey: savedVideosArrayKey) {
            videosArray = arrayValue as! [String]
        }
        if let arrayValue = defaults.array(forKey: savedSpeechArrayKey) {
            speechArray = arrayValue as! [String]
        }
        self.tableView.reloadData()
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Segues: Prepare the data before the segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            let destination = segue.destination as! PlayerViewController
            if let pathIndex = tableView.indexPathForSelectedRow?.row {
                destination.path = videosArray[pathIndex]
            }
        }
    }
    
    // MARK: - Table View configuration
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 151.0;
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        print(videosArray.count)
        
        
        return videosArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        print(indexPath.row)
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)as! CellMasterView
        var thumbnail = UIImage()
        let fileName = videosArray[indexPath.row]
        let recognizedText = speechArray[indexPath.row]
        let docsPath: String = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last!
        let moviePath = docsPath + "/" + fileName + ".mov"
        print("MasterViewController movie path: \(moviePath)")
        do {
            let asset = AVURLAsset(url: URL(fileURLWithPath: moviePath), options: nil)
            let imgGenerator = AVAssetImageGenerator(asset: asset)
            imgGenerator.appliesPreferredTrackTransform = true
            let cgImage = try imgGenerator.copyCGImage(at: CMTimeMake(0, 1), actualTime: nil)
            thumbnail = UIImage(cgImage: cgImage)
        } catch let error as NSError {
            print("Error generating thumbnail: \(error)")
            thumbnail = UIImage(named: "PlayFilled")!
        }
        var creation = ""
        var duration = 0
        var latitude = ""
        var longitude = ""
        let movieURL = URL.init(fileURLWithPath: moviePath)
        let asset = AVURLAsset(url: movieURL, options: nil)
        var metadata = AVMetadataItem()
        if !asset.metadata.isEmpty {
            metadata = asset.metadata[0]
            let locationArray = String(describing: metadata.value!).components(separatedBy: "_")
            duration = Int(asset.duration.seconds)
            let creationDate = asset.creationDate!.value as! Date
            creation = creationDate.toString()
            latitude = locationArray[1]
            longitude = locationArray[3]
        } else {
            let dataArray = String(describing: fileName).components(separatedBy: "_")
            let stringLat = dataArray[3]
            let stringLon = dataArray[4]
            latitude = stringLat
            longitude = stringLon
            duration = Int(asset.duration.seconds)
            let creationDate = asset.creationDate!.value as! Date
            creation = creationDate.toString()
        }
        cell.cellImageView.image = thumbnail
        cell.cellDateTextLabel.text = String("Video recorded: \(creation)")
        cell.cellDurationTextLabel.text = String("Video duration: \(duration) seconds")
        cell.cellTopTextLabel.text = String("Latitude: \(latitude)")
        cell.cellBottomTextLabel.text = String("Longitude: \(longitude)")
        cell.cellSpeechTextView.text = recognizedText
        if (cellInformationContent[indexPath.row] != nil) {
            cell.cellInformationView.isHidden = cellInformationContent[indexPath.row]!
            cell.cellDateTextLabel.isHidden = cellInformationContent[indexPath.row]!
            cell.cellDurationTextLabel.isHidden = cellInformationContent[indexPath.row]!
            cell.cellTopTextLabel.isHidden = cellInformationContent[indexPath.row]!
            cell.cellBottomTextLabel.isHidden = cellInformationContent[indexPath.row]!
        } else {
            cellInformationContent[indexPath.row] = true
            cell.cellInformationView.isHidden = cellInformationContent[indexPath.row]!
            cell.cellDateTextLabel.isHidden = cellInformationContent[indexPath.row]!
            cell.cellDurationTextLabel.isHidden = cellInformationContent[indexPath.row]!
            cell.cellTopTextLabel.isHidden = cellInformationContent[indexPath.row]!
            cell.cellBottomTextLabel.isHidden = cellInformationContent[indexPath.row]!
        }
        if (cellTextContent[indexPath.row] != nil) {
            cell.cellTextView.isHidden = cellTextContent[indexPath.row]!
            cell.cellSpeechTextView.isHidden = cellTextContent[indexPath.row]!
        } else {
            cellTextContent[indexPath.row] = true
            cell.cellTextView.isHidden = cellTextContent[indexPath.row]!
            cell.cellSpeechTextView.isHidden = cellTextContent[indexPath.row]!
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // MARK: - Swipe buttons: Swipe to edit buttons configuration
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            
            // MARK: Swipe to delete cell (with video and text from iPhone and Dropbox)
            
            let filename = self.videosArray[indexPath.row]
            let path = (NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last! as NSString).appendingPathComponent((filename as NSString).appendingPathExtension("mov")!)
            if FileManager.default.fileExists(atPath: path) {
                do {
                    try FileManager.default.removeItem(atPath: path)
                    self.videosArray.remove(at: indexPath.row)
                    self.speechArray.remove(at: indexPath.row)
                    let defaults = UserDefaults.standard
                    defaults.set(self.videosArray, forKey: self.savedVideosArrayKey)
                    if (self.cellInformationContent[indexPath.row] != nil) {
                        self.cellInformationContent.removeValue(forKey: indexPath.row)
                    }
                    defaults.set(self.speechArray, forKey: self.savedSpeechArrayKey)
                    if (self.cellTextContent[indexPath.row] != nil) {
                        self.cellTextContent.removeValue(forKey: indexPath.row)
                    }
                    let dropbox = DropboxViewController()
                    dropbox.deleteFile(name: filename)
                    tableView.deleteRows(at: [indexPath], with: .fade)
                }
                catch {
                    print("Could not remove file at url: \(URL(fileURLWithPath: path))")
                }
            } else {
                self.videosArray.remove(at: indexPath.row)
                self.speechArray.remove(at: indexPath.row)
                let defaults = UserDefaults.standard
                defaults.set(self.videosArray, forKey: self.savedVideosArrayKey)
                defaults.set(self.speechArray, forKey: self.savedSpeechArrayKey)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
        
        let text = UITableViewRowAction(style: .normal, title: "Speech") { (action, indexPath) in
            
            // MARK: Swipe to show the recognized text from speech
            
            if (self.cellTextContent[indexPath.row] != nil) {
                self.cellTextContent[indexPath.row] = !self.cellTextContent[indexPath.row]!
            } else {
                self.cellTextContent[indexPath.row] = false
            }
            self.cellInformationContent[indexPath.row] = true
            tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.right)
            tableView.setEditing(false, animated: true)
        }
        let metadata = UITableViewRowAction(style: .normal, title: "File info") { (action, indexPath) in
            
            // MARK: Swipe to show metadata of the video file
            
            if (self.cellInformationContent[indexPath.row] != nil) {
                self.cellInformationContent[indexPath.row] = !self.cellInformationContent[indexPath.row]!
            } else {
                self.cellInformationContent[indexPath.row] = false
            }
            self.cellTextContent[indexPath.row] = true
            tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.right)
            tableView.setEditing(false, animated: true)
        }
        text.backgroundColor = UIColor.blue
        metadata.backgroundColor = UIColor.orange
        print("self.cellInformationContent")
        print(self.cellInformationContent)
        print("self.cellTextContent")
        print(self.cellTextContent)
        return [delete, metadata, text]
    }
    
    @IBAction func unwindInMaster(_ segue: UIStoryboardSegue)  {
    }
    
}

// MARK: - Extension: Date formatter extension

extension Date {
    
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium
        return dateFormatter.string(from: self)
    }
    
}
