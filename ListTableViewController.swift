//
//  ListTableViewController.swift
//  final
//
//  Created by Ruan on 2017/6/17.
//  Copyright © 2017年 Ruan. All rights reserved.
//

import UIKit

class ListTableViewController: UITableViewController {


    @IBOutlet var songlist: UITableView!
    var isUpdate = false
    var songs = [[String:Any]]()
    var noteDic:[String:Any]!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if isUpdate {
            //self.tableView.insertRows(at:[indexPath], with: UITableViewRowAnimation.automatic)
            isUpdate = false
        }
    }
    func getAddSongNoti(noti:Notification) {
        
        
        if self.songlist.indexPathForSelectedRow != nil {
            songs[self.songlist.indexPathForSelectedRow!.row] = noti.userInfo as! [String:Any]
        }
        else{
            
            self.songs.insert(noti.userInfo as! [String:Any], at: 0)
        }
        
        isUpdate = true
        let fileManager = FileManager.default
        let docUrls =
            fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let docUrl = docUrls.first
        let url = docUrl?.appendingPathComponent("song.txt")
        (songs as NSArray).write(to: url!, atomically: true)
        self.songlist.reloadData()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundView = UIImageView(image: UIImage(named: "Unknown"))
        self.tableView.backgroundView?.alpha = 0.5
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        let fileManager = FileManager.default
        let docUrls =
            fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let docUrl = docUrls.first
        let url = docUrl?.appendingPathComponent("song.txt")
        let array = NSArray(contentsOf: url!)
        if array != nil {
            songs = array as! [[String:String]]
        }
        
        let notiName = Notification.Name("AddSong")
        NotificationCenter.default.addObserver(self, selector: #selector(getAddSongNoti(noti:)), name: notiName, object: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "songcell", for: indexPath) as! ListTableViewCell
        
        // Configure the cell...
        let dic = songs[indexPath.row]
        cell.nameLable.text = dic["name"] as? String
        cell.songurl.text = dic["songUrl"] as? String
        

        
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.destination is SongDetailTableViewController
        {
            let controller = segue.destination as! SongDetailTableViewController
            let indexPath = tableView.indexPathForSelectedRow
            controller.songDic = songs[indexPath!.row]
        }
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        songs.remove(at: indexPath.row)
        let url = Setfile()
        (songs as NSArray).write(to: url!, atomically:true)
        tableView.reloadData()
    }
    func Setfile()->URL? {
        let fileManager = FileManager.default
        let docUrls = fileManager.urls(for: .documentDirectory,in: .userDomainMask)
        let docUrl = docUrls.first
        
        let url = docUrl?.appendingPathComponent("song.txt")
        return url
    }

}
