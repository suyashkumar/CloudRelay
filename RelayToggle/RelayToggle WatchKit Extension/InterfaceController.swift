//
//  InterfaceController.swift
//  RelayToggle WatchKit Extension
//
//  Created by Suyash Kumar on 10/24/15.
//  Copyright © 2015 Suyash Kumar. All rights reserved.
//

import WatchKit
import Foundation
import Foundation




class InterfaceController: WKInterfaceController {

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        refreshStatus()
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    @IBOutlet var statusLabel: WKInterfaceLabel!
    @IBOutlet var toggleButton: WKInterfaceButton!
    @IBOutlet var refreshButton: WKInterfaceButton!
    
    @IBAction func refreshPress() {
        refreshStatus()
    }
    @IBAction func toggle() {
        let urlPath: String = "https://api.particle.io/v1/devices/250025001747343338333633/led?access_token=97bbe3755d84dc951179331beacf98cb93b4b6b0"
        let url1: NSURL = NSURL(string: urlPath)!
        var request1: NSMutableURLRequest = NSMutableURLRequest(URL: url1)
        request1.HTTPMethod="POST"
     
        
        request1.HTTPBody = ("{\"args\":\"toggle\"}" as NSString).dataUsingEncoding(NSUTF8StringEncoding,allowLossyConversion: true)
        
        request1.addValue("application/json", forHTTPHeaderField: "Content-Type")
     
        
        let connection:NSURLSession=NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration()
)
        let task:NSURLSessionTask=connection.dataTaskWithRequest(request1,completionHandler: {(data, response, error) -> Void in
            let responseData = String(data: data!, encoding: NSUTF8StringEncoding)
            print(responseData)
            do{
            let jsonData = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments)
                print(jsonData["return_value"]!!.description)
                //print((jsonData["return_value"]=="1")
                var currentValue=jsonData["return_value"]!!.description
                if (currentValue=="1"){
                    self.statusLabel.setText("SK Relay 1:\nOn")
                    //self.statusLabel.setTextColor(UIColor.greenColor())
                    self.toggleButton.setBackgroundColor(UIColor.redColor())
                    self.toggleButton.setTitle("Toggle Off")
                }
                else{
                    self.statusLabel.setText("SK Relay 1:\nOff")
                    //self.statusLabel.setTextColor(UIColor.whiteColor())
                    self.toggleButton.setBackgroundColor(UIColor.greenColor())
                    self.toggleButton.setTitle("Toggle On")
                    
                }
                
            }
            catch _{
                
            }
        
        });
        
        task.resume()
    }
    func refreshStatus(){
        let urlPath: String = "https://api.particle.io/v1/devices/250025001747343338333633/led?access_token=97bbe3755d84dc951179331beacf98cb93b4b6b0"
        let url1: NSURL = NSURL(string: urlPath)!
        var request1: NSMutableURLRequest = NSMutableURLRequest(URL: url1)
        request1.HTTPMethod="POST"
        
        
        request1.HTTPBody = ("{\"args\":\"status\"}" as NSString).dataUsingEncoding(NSUTF8StringEncoding,allowLossyConversion: true)
        
        request1.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        let connection:NSURLSession=NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration()
        )
        let task:NSURLSessionTask=connection.dataTaskWithRequest(request1,completionHandler: {(data, response, error) -> Void in
            let responseData = String(data: data!, encoding: NSUTF8StringEncoding)
            print(responseData)
            do{
                let jsonData = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments)
                print(jsonData["return_value"]!!.description)
                //print((jsonData["return_value"]=="1")
                var currentValue=jsonData["return_value"]!!.description
                if (currentValue=="1"){
                    self.statusLabel.setText("SK Relay 1:\nOn")
                    self.toggleButton.setBackgroundColor(UIColor.redColor())
                    self.toggleButton.setTitle("Toggle Off")
                }
                else{
                    self.statusLabel.setText("SK Relay 1:\nOff")
                    self.toggleButton.setBackgroundColor(UIColor.greenColor())
                    self.toggleButton.setTitle("Toggle On")
                    
                }
                
            }
            catch _{
                
            }
            
        });
        
        task.resume()
        

    }
}
