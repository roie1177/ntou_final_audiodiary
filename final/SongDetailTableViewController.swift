//
//  SongDetailTableViewController.swift
//  final
//
//  Created by Ruan on 2017/6/17.
//  Copyright © 2017年 Ruan. All rights reserved.
//

import UIKit

class SongDetailTableViewController: UITableViewController {

   var songDic:[String:Any]!
    
    @IBOutlet weak var songurl: UILabel!
    @IBOutlet weak var songname: UILabel!
    
    
    @IBOutlet weak var songview: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundView = UIImageView(image: UIImage(named: "Unknown"))
        self.tableView.backgroundView?.alpha = 0.5
        let notificationName = Notification.Name("AddSong")
        
        NotificationCenter.default.addObserver(self, selector: #selector(SongDetailTableViewController.editCoureNotification(noti:)), name: notificationName, object: nil)
        
        
        
        // Do any additional setup after loading the view.
        
        
        
        songname.text = "名稱:\(songDic["name"]!)"
        songurl.text = "網址:\(songDic["songUrl"]!)"
        
        navigationItem.title = songDic["name"] as? String
        
        let temp = songDic["songUrl"] as! String
        print(temp)
        let temp2 = temp.substring(from:"11111111111111111".endIndex)
        print(temp2)
        
        getvideo(videocode:temp2)
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let controller = segue.destination as! AddSongTableViewController
        controller.songDic = self.songDic
        
    }
    
    func getvideo(videocode:String)
    {
        let url = URL(string:"https://www.youtube.com/embed/\(videocode)")
        songview.loadRequest(URLRequest(url: url!))
    }
    
    func editCoureNotification(noti:Notification)
    {
        
        songDic = noti.userInfo as? [String:String]
        songname.text = "心得名稱:\(songDic["name"]!)"
        songurl.text = "心得網址:\(songDic["songUrl"]!)"
        navigationItem.title = songDic["name"] as? String
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
}
