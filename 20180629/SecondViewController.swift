//
//  SecondViewController.swift
//  20180629
//
//  Created by 丁国真 on 2018/6/29.
//  Copyright © 2018年 丁国真. All rights reserved.
//

import UIKit
import CoreBluetooth


private var peripheralManager: CBPeripheralManager?
private var characteristic: CBMutableCharacteristic?
public var tot_dis = 0




class SecondViewController: UIViewController {
    
    @IBOutlet weak var loadImageFromURL: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    public func reset_dis(){
        tot_dis = tot_dis - tot_dis
    }
    
    @IBAction func Add_dis(_ sender: Any) {
        let manager = FileManager.default
        let urlForDocument = manager.urls(for: .documentDirectory, in:.userDomainMask)
        let docPath = urlForDocument[0]
        let file = docPath.appendingPathComponent("hangge.txt")

        let readHandler = try! FileHandle(forReadingFrom:file)
        let data = readHandler.readDataToEndOfFile()
        let readString = String(data: data, encoding: String.Encoding.utf8)
        print("文件内容: \(readString)")
        tot_dis = Int(readString!)!
        let alertController = UIAlertController(title: "今日步数",
                                                message: "请输入今天走的步数", preferredStyle: .alert)
        alertController.addTextField {
            (textField: UITextField!) -> Void in
            textField.placeholder = "今天步数"
        }
        let okAction = UIAlertAction(title: "好的", style: .default, handler: {
            action in
            let login = alertController.textFields!.first!
            let get_int = Int(login.text!)
            print("您输入的步数：\(get_int)")
            tot_dis = tot_dis + get_int!
            var url1 :URL
            if tot_dis <= 5000 {
                url1 = URL(string: "https://s1.ax1x.com/2018/06/30/PFDt2Q.png")!
            } else if  tot_dis <= 10000{
                url1 = URL(string: "https://s1.ax1x.com/2018/06/30/PFDY8g.png")!
            } else if tot_dis <= 15000{
                url1 = URL(string: "https://s1.ax1x.com/2018/06/30/PFDaKs.png")!
            } else {
                 url1 = URL(string: "https://s1.ax1x.com/2018/06/30/PFDc24.png")!
            }
            
            let data = try? Data(contentsOf: url1)
            
            if let imageData = data {
                let image = UIImage(data: data!)
                self.loadImageFromURL.image = image
            }
            print ("tot :\(tot_dis)")
            if tot_dis >= 20000 {
                let chkfilePath:String = NSHomeDirectory() + "/Documents/chk.txt"
                let chkinfo = String("1")
                //            let srcUrl = NSHomeDirectory() + "/Documents/hangge.txt"
                //            try! fileManager.removeItem(atPath: srcUrl)
                try! chkinfo.write(toFile: chkfilePath, atomically: true, encoding: String.Encoding.utf8)
                print ("Writein")
                print (chkinfo)
                let alertController = UIAlertController(title: "恭喜你，已经到达法国",
                                                        message: nil, preferredStyle: .alert)
                //显示提示框
                self.present(alertController, animated: true, completion: nil)
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                    self.presentedViewController?.dismiss(animated: false, completion: nil)
                    
                }
                //2秒钟之后自动消失对话框
            }
            let filePath:String = NSHomeDirectory() + "/Documents/hangge.txt"
            let info = String(tot_dis)
//            let srcUrl = NSHomeDirectory() + "/Documents/hangge.txt"
//            try! fileManager.removeItem(atPath: srcUrl)
            try! info.write(toFile: filePath, atomically: true, encoding: String.Encoding.utf8)
        })
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)

        
    }
   
    
    
    
    @IBAction func Index(_ sender: Any) {
        let manager = FileManager.default
        let urlForDocument = manager.urls(for: .documentDirectory, in:.userDomainMask)
        let docPath = urlForDocument[0]
        let file = docPath.appendingPathComponent("hangge.txt")
        
        let readHandler = try! FileHandle(forReadingFrom:file)
        let data = readHandler.readDataToEndOfFile()
        let readString = String(data: data, encoding: String.Encoding.utf8)
        print("文件内容: \(readString)")
        let alertController = UIAlertController(title: readString,
                                                message: nil, preferredStyle: .alert)
        //显示提示框
        self.present(alertController, animated: true, completion: nil)
        //两秒钟后自动消失
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            self.presentedViewController?.dismiss(animated: false, completion: nil)
        }
    }
    
    
}

