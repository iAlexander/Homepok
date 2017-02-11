//
//  DropboxViewController.swift
//  HOMEPOK - Catalog of Ukrainian vehicle plates
//
//  Created by Alexander Iashchuk on 11/27/16.
//  Copyright © 2015 Alexander Iashchuk (iAlexander), https://iashchuk.com
//
//  This application is released under the MIT license. All rights reserved.
//

import UIKit
import AVFoundation

public class DropboxViewController: UIViewController, UIViewControllerTransitioningDelegate {
    
    var videosArray: [String] = Array()
    let savedVideosArrayKey = "savedVideosArray"
    var speechArray: [String] = Array()
    let savedSpeechArrayKey = "savedSpeechArray"
    let user = DropboxUser()
    
    @IBOutlet weak var dropboxLogoImageView: UIImageView!
    @IBOutlet weak var authorizeYourAccountTextLabel: UILabel!
    @IBOutlet weak var connectDropboxAccountButton: UIButton!
    
    @IBOutlet weak var disconnectDropboxAccountButton: UIButton!
    @IBOutlet weak var dropboxAccountAuthorizedLabel: UILabel!
    @IBOutlet weak var accountPhotoImageView: UIImageView!
    @IBOutlet weak var userNameTextLabel: UILabel!
    @IBOutlet weak var userEmailTextLabel: UILabel!
    @IBOutlet weak var loadingActivityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var uploadingProgress: UIProgressView!
    @IBOutlet weak var uploadingLabel: UILabel!
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var refreshProgressView: UIProgressView!
    
    public class DropboxUser {
        var authorized = false
        var name = "Dropbox User"
        var email = "youremail@dropbox.com"
        var avatar = UIImage(named: "Dropbox")!
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        let defaults = UserDefaults.standard
        if let arrayValue = defaults.array(forKey: savedVideosArrayKey) {
            videosArray = arrayValue as! [String]
        }
        user.authorized = checkAuthorization()
        super.viewWillAppear(animated)
    }
    
    @IBAction func testButton(_ sender: Any) {
        downloadAllFiles()
    }
    
    // MARK: Link Dropbox account via iOS application
    
    @IBAction func connectDropboxAccount(_ sender: Any) {
        linkDropboxViaApp()
    }
    
    // MARK: Unlink Dropbox account from current session
    
    @IBAction func disconnectDropboxAccount(_ sender: Any) {
        DropboxClientsManager.unlinkClients()
        loadingActivityIndicator.stopAnimating()
        accountPhotoImageView.isHidden = true
        userNameTextLabel.isHidden = true
        userEmailTextLabel.isHidden = true
        disconnectDropboxAccountButton.isHidden = true
        dropboxAccountAuthorizedLabel.isHidden = true
        dropboxLogoImageView.isHidden = false
        authorizeYourAccountTextLabel.isHidden = false
        connectDropboxAccountButton.isHidden = false
        let user = DropboxUser()
        user.authorized = false
    }
    
    // MARK: Check the current Dropbox account authorization
    
    func checkAuthorization() -> Bool {
        if DropboxClientsManager.authorizedClient != nil {
            loadingActivityIndicator.isHidden = false
            loadingActivityIndicator.startAnimating()
            dropboxLogoImageView.isHidden = true
            authorizeYourAccountTextLabel.isHidden = true
            connectDropboxAccountButton.isHidden = true
            _ = DropboxClientsManager.authorizedClient!.users.getCurrentAccount()
                .response { response, error in
                    if let response = response {
                        let user = DropboxUser()
                        user.email = response.email
                        user.name = response.name.displayName
                        if let userImageUrl = response.profilePhotoUrl {
                            if let url = URL(string: userImageUrl) {
                                if let data = NSData(contentsOf: url) {
                                    user.avatar = UIImage(data: data as Data)!
                                }
                            }
                        } else {
                            user.avatar = UIImage(named: "Dropbox")!
                        }
                        self.accountPhotoImageView.layer.cornerRadius = self.accountPhotoImageView.frame.width/4.0
                        self.accountPhotoImageView.clipsToBounds = true
                        self.accountPhotoImageView.image = user.avatar
                        self.userNameTextLabel.text = user.name
                        self.userEmailTextLabel.text = user.email
                        self.accountPhotoImageView.isHidden = false
                        self.userNameTextLabel.isHidden = false
                        self.userEmailTextLabel.isHidden = false
                        self.disconnectDropboxAccountButton.isHidden = false
                        self.dropboxAccountAuthorizedLabel.isHidden = false
                        self.loadingActivityIndicator.stopAnimating()
                    } else if let error = error {
                        print(error)
                    }
            }
            return true
        } else {
            loadingActivityIndicator.stopAnimating()
            accountPhotoImageView.isHidden = true
            userNameTextLabel.isHidden = true
            userEmailTextLabel.isHidden = true
            disconnectDropboxAccountButton.isHidden = true
            dropboxAccountAuthorizedLabel.isHidden = true
            dropboxLogoImageView.isHidden = false
            authorizeYourAccountTextLabel.isHidden = false
            connectDropboxAccountButton.isHidden = false
            return false
        }
    }
    
    //MARK: Link Dropox account via the iOS application (if installed on iPhone)
    
    func linkDropboxViaApp(completion: ((Bool) -> Swift.Void)? = nil) {
        DropboxClientsManager.authorizeFromController(UIApplication.shared,
                                                      controller: self,
                                                      openURL: { (url: URL) -> Void in
                                                        if #available(iOS 10.0, *) {
                                                            UIApplication.shared.open(url, options: [:], completionHandler: nil)
                                                        } else {
                                                            UIApplication.shared.openURL(url)
                                                        }
        })
    }
    
    func linkDropboxViaBrowser() {
        DropboxClientsManager.authorizeFromController(UIApplication.shared,
                                                      controller: self,
                                                      openURL: {(url: URL) -> Void in
                                                        if #available(iOS 10.0, *) {
                                                            UIApplication.shared.open(url, options: [:], completionHandler: nil)
                                                        } else {
                                                            UIApplication.shared.openURL(url)
                                                        }
        }, browserAuth: true)
    }
    
    // MARK: Download all new files (video and text)
    
    public func downloadAllFiles() {
        if let client = DropboxClientsManager.authorizedClient {
            client.files.listFolder(path: "/PrestoidMedia/Video")
                .response { response, error in
                    let defaults = UserDefaults.standard
                    if let arrayValue = defaults.array(forKey: self.savedVideosArrayKey) {
                        self.videosArray = arrayValue as! [String]
                    }
                    if let response = response?.entries {
                        for item in response {
                            let dropboxName = item.name
                            let dropboxPath = item.pathDisplay!
//                            var localName = ""
//                            print(localName)
                            var match = false
                            for name in self.videosArray {
                                let filename = "\(name).mov"
//                                localName = name
                                if (filename == dropboxName) {
                                    print("Already have this file")
                                    match = true
                                }
                            }
                            if !match {
                                self.downloadFile(fromPath: dropboxPath, localName: dropboxName)
                                self.downloadTextFile(fromPath: dropboxName)
                            }
                        }
                    } else if let error = error {
                        print(error)
                    }
            }
        }
    }
    
    // MARK: Download video file to data
    
    public func downloadFile(fromPath: String, localName: String) {
        var result = NSData()
        let nameArray = String(describing: localName).components(separatedBy: ".")
        let fileName = nameArray[0] + "." + nameArray[1] + "." + nameArray[2]
        if let client = DropboxClientsManager.authorizedClient {
            client.files.download(path: fromPath)
                .response { response, error in
                    if let response = response {
                        
                        // If you need metadata - replace the next line wit this code
                        //let responseMetadata = response.0
                        
                        _ = response.0
//                        print("Response Metadata: \(responseMetadata)")
                        let fileContents = response.1
                        result = fileContents as NSData
                        self.saveFile(fileContents: result, localName: fileName)
                        self.refreshProgressView.isHidden = true
                        self.refreshButton.isEnabled = true
                    } else if let error = error {
                        print(error)
//                        self.downloadAllFiles()
                        self.downloadFile(fromPath: fromPath, localName: localName)
                        print("Retry please the video file download")
                        self.refreshProgressView.isHidden = true
                        self.refreshButton.isEnabled = true
                    }
                }
                .progress { progressData in
                    self.refreshProgressView.isHidden = false
                    self.refreshButton.isEnabled = false
                    self.refreshProgressView.progress = Float(progressData.fractionCompleted)
            }
        }
    }
    
    // MARK: Save video file inside the application
    
    func saveFile(fileContents: NSData, localName: String) {
        let defaults = UserDefaults.standard
        if let arrayValue = defaults.array(forKey: self.savedVideosArrayKey) {
            self.videosArray = arrayValue as! [String]
        }
        let docsPath: String = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last!
        let filePath = docsPath + "/" + localName + ".mov"
        fileContents.write(toFile: filePath, atomically: false)
        self.videosArray.append(localName)
        defaults.set(self.videosArray, forKey: self.savedVideosArrayKey)
    }
    
    // MARK: Download text file to data
    
    public func downloadTextFile(fromPath: String) {
        let pathArray = String(describing: fromPath).components(separatedBy: ".")
        let dropboxPath = "/PrestoidMedia/Text/" + pathArray[0] + "." + pathArray[1] + "." + pathArray[2] + "." + "txt"
        if let client = DropboxClientsManager.authorizedClient {
            client.files.download(path: dropboxPath)
                .response { response, error in
                    if let response = response {
                        
                        // If you need metadata - replace the naxt line wit this code
                        //let responseMetadata = response.0
                        
                        _ = response.0
//                        print("Response Metadata: \(responseMetadata)")
                        let fileContents = response.1
                        
                        // MARK: Save text file inside the application
                        
                        let defaults = UserDefaults.standard
                        if let result = String(data: fileContents, encoding: .utf8) {
                            if let arrayValue = defaults.array(forKey: self.savedSpeechArrayKey) {
                                self.speechArray = arrayValue as! [String]
                            }
                            self.speechArray.append(result)
                            defaults.set(self.speechArray, forKey: self.savedSpeechArrayKey)
                            //                        print("VideosArray: \(self.speechArray)")
                            self.refreshProgressView.isHidden = true
                            self.refreshButton.isEnabled = true
                        }
                    } else if let error = error {
                        print(error)
//                        self.downloadAllFiles()
                        self.downloadTextFile(fromPath: fromPath)
                        print("Retry please the text file download")
                        self.refreshProgressView.isHidden = true
                        self.refreshButton.isEnabled = true
                    }
                }
                .progress { progressData in
                    self.refreshProgressView.isHidden = false
                    self.refreshButton.isEnabled = false
                    self.refreshProgressView.progress = Float(progressData.fractionCompleted)
            }
        }
    }
    
    // MARK: Delete video and text file
    
    public func deleteFile(name: String) {
        let videoFilePath = "/PrestoidMedia/Video/" + name + ".mov"
        if let client = DropboxClientsManager.authorizedClient {
            client.files.delete(path: videoFilePath)
        }
        let textFilePath = "/PrestoidMedia/Text/" + name + ".txt"
        if let client = DropboxClientsManager.authorizedClient {
            client.files.delete(path: textFilePath)
        }
    }
    
    // MARK: Upload video and text file
    
    public func uploadVideoFile(filePath: String) {
        let defaults = UserDefaults.standard
        if let arrayValue = defaults.array(forKey: savedVideosArrayKey) {
            videosArray = arrayValue as! [String]
        }
        if let arrayValue = defaults.array(forKey: savedSpeechArrayKey) {
            speechArray = arrayValue as! [String]
        }
        if let client = DropboxClientsManager.authorizedClient {
            let path = filePath
            let docsPath: String = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last!
            let videoFileDataPath = docsPath + "/" + path + ".mov"
            let videoFileURL = URL.init(fileURLWithPath: videoFileDataPath)
            do {
                let videoFileData = try Data(contentsOf: videoFileURL)
                let fileData = videoFileData
                _ = client.files.upload(path: "/PrestoidMedia/Video/\(path).mov", input: fileData)
                    .response { response, error in
                        if let response = response {
                            print(response)
                        } else if let error = error {
                            self.uploadVideoFile(filePath: filePath)
                            print("Video file upload error: \(error)")
                        }
                    }
                    .progress { progressData in
                        print(progressData)
                }
                
                // in case you want to cancel the request
                //        if someConditionIsSatisfied {
                //            request.cancel()
                //        }
                
            } catch {
                print("Can't load data file from iPhone memory")
            }
            let textFileData = speechArray.last!.data(using: .utf8)
            let fileData = textFileData!
            _ = client.files.upload(path: "/PrestoidMedia/Text/\(path).txt", input: fileData)
                .response { response, error in
                    if let response = response {
                        print(response)
                    } else if let error = error {
                        self.uploadVideoFile(filePath: filePath)
                        print("Text file upload error: \(error)")
                    }
                }
                .progress { progressData in
                    print(progressData)
            }
            
            // Use this in case you want to cancel the request
            //        if someConditionIsSatisfied {
            //            request.cancel()
            //        }
            
        }
    }
    
}
