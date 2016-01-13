//
//  ViewController.swift
//  RelayToggle
//
//  Created by Suyash Kumar on 10/24/15.
//  Copyright © 2015 Suyash Kumar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var toggleButton: UIButton!
    
    var keyDict:NSDictionary?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let path = NSBundle.mainBundle().pathForResource("keys", ofType: "plist") {
            keyDict = NSDictionary(contentsOfFile: path) as? Dictionary<String,String>
        }
        self.title="RelayToggle"
        updateStatus()
    }
   
    @IBAction func togglePressed(sender: UIButton) {
        toggle()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func toggle(){
        request("toggle")
    }
    func updateStatus(){
        request("status")
    }
    
    func request(reqType: String){
        let urlPath: String = keyDict!["POSTURL"] as! String
        let url1: NSURL = NSURL(string: urlPath)!
        var request1: NSMutableURLRequest = NSMutableURLRequest(URL: url1)
        request1.HTTPMethod="POST"
        
        
        request1.HTTPBody = ("{\"args\":\""+reqType+"\"}" as NSString).dataUsingEncoding(NSUTF8StringEncoding,allowLossyConversion: true)
        
        request1.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        let connection:NSURLSession=NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration()
        )
        let task:NSURLSessionTask=connection.dataTaskWithRequest(request1,completionHandler: {(data, response, error) -> Void in
            let responseData = String(data: data!, encoding: NSUTF8StringEncoding)
            print(responseData)
            do{
                let jsonData = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments)
                print(jsonData["return_value"]!!.description)
                
                var currentValue=jsonData["return_value"]!!.description
                if (currentValue=="1"){
                    dispatch_async(dispatch_get_main_queue(), {
                        // code here
                        
                        self.statusLabel.text="On"
                        //self.statusLabel.textColor=UIColor.greenColor()
                        
                        //self.statusLabel.setTextColor(UIColor.greenColor())
                        self.toggleButton.backgroundColor=UIColor.redColor()
                        self.toggleButton.setTitle("Toggle Off", forState: UIControlState.Normal)
                    })
                }
                else{
                    dispatch_async(dispatch_get_main_queue(), {
                        // code here
                        
                        self.statusLabel.text="Off"
                        //self.statusLabel.setTextColor(UIColor.whiteColor())
                        self.toggleButton.backgroundColor=UIColor.greenColor()
                        self.toggleButton.setTitle("Toggle On", forState: UIControlState.Normal)
                    })
                    
                }
                
            }
            catch _{
                
            }
            
        });
        
        task.resume()
        
        
    }
    

        
        
    }


