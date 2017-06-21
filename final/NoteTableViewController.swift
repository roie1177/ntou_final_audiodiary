//
//  NoteTableViewController.swift
//  final
//
//  Created by Ruan on 2017/6/17.
//  Copyright © 2017年 Ruan. All rights reserved.
//

import UIKit

class NoteTableViewController: UITableViewController {
    
    
    @IBOutlet var noteTableView: UITableView!
    var isUpdate = false
    var Notes = [[String:Any]]()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if isUpdate {
            //self.tableView.insertRows(at:[indexPath], with: UITableViewRowAnimation.automatic)
            isUpdate = false
        }
    }
    
    func getAddNotesNoti(noti:Notification) {
        
        
        if self.noteTableView.indexPathForSelectedRow != nil {
            Notes[self.noteTableView.indexPathForSelectedRow!.row] = noti.userInfo as! [String:Any]
        }
        else{
            
            self.Notes.insert(noti.userInfo as! [String:Any], at: 0)
        }
        
        isUpdate = true
        let fileManager = FileManager.default
        let docUrls =
            fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let docUrl = docUrls.first
        let url = docUrl?.appendingPathComponent("notes.txt")
        (Notes as NSArray).write(to: url!, atomically: true)
        self.noteTableView.reloadData()
        
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
        let url = docUrl?.appendingPathComponent("notes.txt")
        let array = NSArray(contentsOf: url!)
        if array != nil {
            Notes = array as! [[String:String]]
        }
        
        let notiName = Notification.Name("AddNotes")
        NotificationCenter.default.addObserver(self, selector: #selector(getAddNotesNoti(noti:)), name: notiName, object: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Notes.count
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotesCell", for: indexPath) as! NoteTableViewCell
        
        // Configure the cell...
        let dic = Notes[indexPath.row]
        cell.name.text = dic["name"] as? String
        
        let fileManager = FileManager.default
        let docUrls =
            fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let docUrl = docUrls.first
        let url = docUrl?.appendingPathComponent((dic["photo"] as? String)!)
        cell.noteImage.image = UIImage(contentsOfFile: url!.path)
        
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.destination is NotesDetailTableViewController
        {
            let controller = segue.destination as! NotesDetailTableViewController
            let indexPath = tableView.indexPathForSelectedRow
            controller.noteDic = Notes[indexPath!.row]
        }
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        Notes.remove(at: indexPath.row)
        let url = Setfile()
        (Notes as NSArray).write(to: url!, atomically:true)
        tableView.reloadData()
    }
    func Setfile()->URL? {
        let fileManager = FileManager.default
        let docUrls = fileManager.urls(for: .documentDirectory,in: .userDomainMask)
        let docUrl = docUrls.first
        
        let url = docUrl?.appendingPathComponent("notes.txt")
        return url
    }
    
}
