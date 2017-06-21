//
//  AddSongTableViewController.swift
//  final
//
//  Created by Ruan on 2017/6/17.
//  Copyright © 2017年 Ruan. All rights reserved.
//

import UIKit

class AddSongTableViewController:UITableViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    

    @IBOutlet weak var songName: UITextField!
    
    @IBOutlet weak var songUrl: UITextField!
    var notehttp = "https://www.youtube.com/results?search_query="
    var songDic:[String:Any]!
    var noteDic:[String:Any]!
    
   
    @IBAction func done(_ sender: Any) {
        if songName.text?.characters.count == 0
        {
            let controller = UIAlertController(title: "提醒", message: "請輸入心得名稱", preferredStyle: UIAlertControllerStyle.alert)
            
            let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
                
            }
            )
            controller.addAction(action)
            
            present(controller, animated: true, completion: nil)
            
            return
        }
        else if songUrl.text?.characters.count == 0
        {
            let controller = UIAlertController(title: "提醒", message: "請輸入影片網址", preferredStyle: UIAlertControllerStyle.alert)
            
            let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
                
            }
            )
            controller.addAction(action)
            
            present(controller, animated: true, completion: nil)
            
            return
        }
        let dic:[String:Any] = ["name":songName.text!,"songUrl":songUrl.text!]
        
        let notiName = Notification.Name("AddSong")
        NotificationCenter.default.post(name: notiName, object: nil, userInfo: dic)
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func weblink(_ sender: Any) {
        
        if songName.text?.characters.count == 0
        {
            let controller = UIAlertController(title: "提醒", message: "請輸入搜尋名稱", preferredStyle: UIAlertControllerStyle.alert)
            
            let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
                
            }
            )
            controller.addAction(action)
            
            present(controller, animated: true, completion: nil)
            
            return
        }
        let temp = songName.text!.replacingOccurrences(of: " ", with: "+")
        let search = notehttp + temp
        UIApplication.shared.open(URL(string:search)!)
        
    }
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.tableView.backgroundView = UIImageView(image: UIImage(named: "Unknown"))
        self.tableView.backgroundView?.alpha = 0.5
        if songDic != nil {
            songName.text=songDic["name"] as? String
            songUrl.text=songDic["songUrl"] as? String


        }
        if noteDic != nil {
            songName.text=noteDic["name"] as? String
            songUrl.text=noteDic["noteUrl"] as? String
            
            
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
}
