//
//  FirstViewController.swift
//  20180629
//
//  Created by 丁国真 on 2018/6/29.
//  Copyright © 2018年 丁国真. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import CoreBluetooth
//import BabyBlueTooth

class FirstViewController: UIViewController {
    
//    var baby: BabyBluetooth?
    
    /*

    func babyDelegate() {
        //设置扫描到设备的委托
        baby.blockOnDiscoverToPeripherals = { central, peripheral, advertisementData, RSSI in
            print("搜索到了设备:\(peripheral?.name ?? "")")
        }
        //过滤器
        //设置查找设备的过滤器
        baby!.filterOnDiscoverPeripherals = { peripheralName, advertisementData, RSSI in
            //最常用的场景是查找某一个前缀开头的设备
            //if ([peripheralName hasPrefix:@"Pxxxx"] ) {
            //    return YES;
            //}
            //return NO;
            //设置查找规则是名称大于1 ， the search rule is peripheral.name length > 1
            if (peripheralName?.count ?? 0) > 1 {
                return true
            }
            return false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        super.viewDidLoad()
//        //初始化BabyBluetooth 蓝牙库
//        baby = BabyBluetooth.share()
//        //设置蓝牙委托
//        babyDelegate()
//        //设置委托后直接可以使用，无需等待CBCentralManagerStatePoweredOn状态
//        baby?.scanForPeripherals().begin()
    }
 */
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view, typically from a nib.
//
//    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var input_value: UITextField!
    @IBAction func Submitt(_ sender: UIButton) {
        print("Button Pressed")
        
        let input = input_value.text!
       
//            let videoURL = "http://172.18.16.92/1.mp4"
            
            
            
            let manager = FileManager.default
            let urlForDocument = manager.urls(for: .documentDirectory, in:.userDomainMask)
            let docPath = urlForDocument[0]
            let file = docPath.appendingPathComponent("chk.txt")
            
            let readHandler = try! FileHandle(forReadingFrom:file)
            let data = readHandler.readDataToEndOfFile()
            let readString = String(data: data, encoding: String.Encoding.utf8)
            print("文件内容: \(readString)")
            var chk = Int(readString!)!
            if chk == 1{
                let player = AVPlayer(url:URL(string: "http://172.20.10.2/1.mp4")!)
                let vc = AVPlayerViewController()
                vc.player = player
                present(vc, animated: true) {
                    vc.player?.play()
                }
            }else  {
                    let alertController = UIAlertController(title: "您未到达该地",
                                                            message: nil, preferredStyle: .alert)
                    //显示提示框
                    self.present(alertController, animated: true, completion: nil)
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                        self.presentedViewController?.dismiss(animated: false, completion: nil)
                        
                    }
                    //2秒钟之后自动消失对话框
                }
            
            
            
            
        
        
    }
   
    

    
    @IBAction func choose(_ sender: Any) {
//        super.viewDidAppear(animated)
        
        
        
        

        
        let alertController = UIAlertController(title: "系统提示",message: "您确定要设置法国为目的地吗？", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "好的", style: .default, handler: {
            action in
            print("点击了确定")
        })
        
        let chkfilePath:String = NSHomeDirectory() + "/Documents/chk.txt"
        let chkinfo = String("0")
        //            let srcUrl = NSHomeDirectory() + "/Documents/hangge.txt"
        //            try! fileManager.removeItem(atPath: srcUrl)
        try! chkinfo.write(toFile: chkfilePath, atomically: true, encoding: String.Encoding.utf8)
        
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
        let manager = FileManager.default
        let urlForDocument = manager.urls(for: .documentDirectory, in:.userDomainMask)
        let url = urlForDocument[0] as URL
        print(url)
        let filePath:String = NSHomeDirectory() + "/Documents/hangge.txt"
        let info = "0"
        try! info.write(toFile: filePath, atomically: true, encoding: String.Encoding.utf8)
        
        
    }
    
}


