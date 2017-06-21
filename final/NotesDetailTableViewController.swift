//
//  NotesDetailTableViewController.swift
//  final
//
//  Created by Ruan on 2017/6/17.
//  Copyright © 2017年 Ruan. All rights reserved.
//

import UIKit
import Social

class NotesDetailTableViewController: UITableViewController {
    
    var noteDic:[String:Any]!
    
    
    @IBOutlet weak var noteImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var noteUrl: UILabel!
    @IBOutlet weak var webviewer: UIWebView!
    @IBOutlet weak var noteText: UILabel!
    var add = "-"
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundView = UIImageView(image: UIImage(named: "Unknown"))
        self.tableView.backgroundView?.alpha = 0.5
        noteImage.isHidden = false
        webviewer.isHidden = true
        let temp = noteDic["noteUrl"] as! String
        print(temp)
        let temp2 = temp.substring(from:"11111111111111111".endIndex)
        print(temp2)
        getvideo(videocode:temp2)
        let notificationName = Notification.Name("AddNotes")
        
        NotificationCenter.default.addObserver(self, selector: #selector(NotesDetailTableViewController.editCoureNotification(noti:)), name: notificationName, object: nil)
        
        
        
        // Do any additional setup after loading the view.
        
        
        name.text = "名稱:\(noteDic["name"]!)-\(noteDic["noteType"]!)"
        noteUrl.text = "網址:\(noteDic["noteUrl"]!)"
        noteText.text = "心得內容:\(noteDic["noteText"]!)"
        navigationItem.title = noteDic["name"] as? String
        
        
        let fileManager = FileManager.default
        let docUrls =
            fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let docUrl = docUrls.first
        let url = docUrl?.appendingPathComponent((noteDic["photo"] as? String)!)
        noteImage.image = UIImage(contentsOfFile: url!.path)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.destination is AddNoteTableViewController
        {
            let controller = segue.destination as! AddNoteTableViewController
            controller.noteDic = self.noteDic
        }
        else if segue.destination is AddSongTableViewController
        {
            let controller = segue.destination as! AddSongTableViewController
            controller.noteDic = self.noteDic
        }
    }
    
    
    @IBAction func FacebookShare(_ sender: Any) {
        
        if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeFacebook)
        {
            let fbComposer = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            fbComposer?.setInitialText(name.text!+"\n"+noteUrl.text!+"\n"+noteText.text!)
            fbComposer?.add(noteImage.image)
            
            present(fbComposer!, animated: true, completion: nil)
            

        }
        else
        {
            let alert = UIAlertController(title: "未登入", message: "請登入fb", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            alert.addAction(UIAlertAction(title: "Login", style: .default, handler:
                { (action) in
                    if let settingURL = URL(string: UIApplicationOpenSettingsURLString){
                        UIApplication.shared.open(settingURL, options: [ : ], completionHandler: nil)
                    }
            }))
            present(alert , animated:true , completion: nil)
        }
    }
    
    
    @IBAction func weblink(_ sender: Any) {
        noteImage.isHidden = true
        webviewer.isHidden = false
        
    }
    func getvideo(videocode:String)
    {
        let url = URL(string:"https://www.youtube.com/embed/\(videocode)")
        webviewer.loadRequest(URLRequest(url: url!))
    }
    
    func editCoureNotification(noti:Notification)
    {
        
        noteDic = noti.userInfo as? [String:String]
        name.text = "名稱:\(noteDic["name"]!)-\(noteDic["noteType"]!)"
        noteUrl.text = "心得網址:\(noteDic["noteUrl"]!)"
        noteText.text = "心得內容:\(noteDic["noteText"]!)"
        
        navigationItem.title = noteDic["name"] as? String
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }   
 
}
