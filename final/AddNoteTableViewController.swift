//
//  AddNoteTableViewController.swift
//  final
//
//  Created by Ruan on 2017/6/17.
//  Copyright © 2017年 Ruan. All rights reserved.
//

import UIKit


class AddNoteTableViewController: UITableViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate,UIPickerViewDelegate,UIPickerViewDataSource {

    var dataPicker : UIDatePicker!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var noteTextField: UITextView!
    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var noteImageView: UIImageView!
    @IBOutlet weak var noteType: UITextField!
    @IBOutlet weak var typepicker: UIPickerView!
    let type = ["抒情","搖滾","流行","教育","體育","搞笑"]
  
   
    var chose = 0
    
    
    
    
    var notehttp = "https://www.youtube.com/results?search_query="
    var notehttp2 = "https://www.google.com.tw/imghp?hl=zh-TW"
    var noteDic:[String:Any]!
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return type[row]
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return type.count;
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    
    @IBAction func submit(_ sender: Any) {
        noteType.text = type[chose]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        chose = row
    }
    
    
    
    
   
    @IBAction func done(_ sender: UIBarButtonItem) {
        if nameTextField.text?.characters.count == 0
        {
            let controller = UIAlertController(title: "提醒", message: "請輸入心得名稱", preferredStyle: UIAlertControllerStyle.alert)
            
            let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
                
            }
            )
            controller.addAction(action)
            
            present(controller, animated: true, completion: nil)
            
            return
        }
        else if urlTextField.text?.characters.count == 0
        {
            let controller = UIAlertController(title: "提醒", message: "請輸入影片網址", preferredStyle: UIAlertControllerStyle.alert)
            
            let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
                
            }
            )
            controller.addAction(action)
            
            present(controller, animated: true, completion: nil)
            
            return
        }
        else if noteTextField.text?.characters.count == 0
        {
            let controller = UIAlertController(title: "提醒", message: "請輸入心得內容", preferredStyle: UIAlertControllerStyle.alert)
            
            let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
                
            }
            )
            controller.addAction(action)
            present(controller, animated: true, completion: nil)
            
            return
        }
        else if noteImageView.image == nil
        {
            let controller = UIAlertController(title: "提醒", message: "請輸入照片", preferredStyle: UIAlertControllerStyle.alert)
            
            let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
                
            }
            )
            controller.addAction(action)
            
            present(controller, animated: true, completion: nil)
            
            return
        }
        
        let interval = Date().timeIntervalSinceReferenceDate
        
        let data = UIImageJPEGRepresentation(noteImageView.image!, 0.8)
        let fileManager = FileManager.default
        let docUrls =
            fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let docUrl = docUrls.first
        let url = docUrl?.appendingPathComponent("\(interval)")
        
        try? data?.write(to: url!)
        
        
        let dic:[String:Any] = ["name":nameTextField.text!, "photo":"\(interval)","noteUrl":urlTextField.text!,"noteText":noteTextField.text!,"noteType":noteType.text!]
        
        let notiName = Notification.Name("AddNotes")
        NotificationCenter.default.post(name: notiName, object: nil, userInfo: dic)
        
        
        self.navigationController?.popViewController(animated: true)
        
        
    }



 

 
    @IBAction func weblink2(_ sender: Any) {

        let search = notehttp2
        UIApplication.shared.open(URL(string:search)!)
        
    }
    @IBAction func weblink(_ sender: Any) {
        
        if nameTextField.text?.characters.count == 0
        {
            let controller = UIAlertController(title: "提醒", message: "請輸入搜尋名稱", preferredStyle: UIAlertControllerStyle.alert)
            
            let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
                
            }
            )
            controller.addAction(action)
            
            present(controller, animated: true, completion: nil)
            
            return
        }
        let temp = nameTextField.text!.replacingOccurrences(of: " ", with: "+")
        let search = notehttp + temp
        UIApplication.shared.open(URL(string:search)!)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print(info)
        noteImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        dismiss(animated: true, completion: nil)
        
    }
    
    
    
    
    @IBAction func selectPhoto(_ sender: UIButton) {
        let controller = UIImagePickerController()
        controller.delegate = self
        controller.sourceType = .photoLibrary
        present(controller, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {

        super.viewDidLoad()
        self.tableView.backgroundView = UIImageView(image: UIImage(named: "Unknown"))
        self.tableView.backgroundView?.alpha = 0.5
        typepicker.delegate = self
        typepicker.dataSource = self
        if noteDic != nil {
            nameTextField.text=noteDic["name"] as? String
            urlTextField.text=noteDic["noteUrl"] as? String
            noteTextField.text=noteDic["noteText"] as? String
            noteType.text=noteDic["noteType"] as? String
            let fileManager = FileManager.default
            let docUrls =
                fileManager.urls(for: .documentDirectory, in: .userDomainMask)
            let docUrl = docUrls.first
            let url = docUrl?.appendingPathComponent((noteDic["photo"] as? String)!)
            noteImageView.image = UIImage(contentsOfFile: url!.path)
        }


    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    
    
}
