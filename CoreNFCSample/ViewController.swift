//
//  ViewController.swift
//  CoreNFCSample
//
//  Created by Dobrinka Tabakova on 10/7/17.
//  Copyright © 2017 Dobrinka Tabakova. All rights reserved.
//

import UIKit
import CoreNFC
import Alamofire
import SwiftyJSON
import AlamofireObjectMapper

struct Product : Codable{
    let productId: String?
    let productName: String?
    let productBrand: String?
    let productCategory: String?
    let productColor: String?
    let productPrice: String?
    
}


class ViewController: UIViewController, NFCNDEFReaderSessionDelegate {
    
    
    var products = [Product]()
    //let URL_API = "http://www.youite.com/yeen/productGet.php?productId=17" // get id from tag result
    
    

    
    //var productId = [String]()
    //var productName = [String]()
    //var productBrand = [String]()

    var listProduct = ""
    /*
     [
     {
     "productPrice" : "12",
     "productBrand" : "t1",
     "productColor" : "t3",
     "productCategory" : " t2",
     "productName" : "ผ้า",
     "productId" : "17"
     }
     ]
     */
    
    
    ////
    
    @IBOutlet weak var infoTextView: UITextView!
    var arrRes = [[String:AnyObject]]() //Array of dictionary
    var productFromYeen = [[String: AnyObject]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        //  here login service
        Alamofire.request("http://www.youite.com/yeen/login.php?username=5806914&password=coptercopter").responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                let swiftyJsonVar = JSON(responseData.result.value!)
                print(swiftyJsonVar)
            }
        }
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func scanButtonTapped(_ sender: Any) {
        let nfcSession = NFCNDEFReaderSession.init(delegate: self, queue: nil, invalidateAfterFirstRead: true)
        nfcSession.alertMessage = "Hold iPhone near NFC tag."
        nfcSession.begin()
        
    }
    
    public func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        print("Your Session was invalidated - ", error.localizedDescription)
    }
    
    public func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        
        var result = ""
        for record in messages[0].records {
            //result += "Type name format: \(record.typeNameFormat)\n\n"
            //result += "Type: " + String.init(data: record.type, encoding: .utf8)! + "\n\n"
            //result += "Identifier: " + String.init(data: record.identifier, encoding: .utf8)! + "\n\n"
            result += String.init(data: record.payload, encoding: .utf8)!
        }
        
        
        //var dict = NSDictionary()
        // service product id = 17
        
        let URL_API = "http://www.youite.com/yeen/productGet.php?productId=17" // + result
        Alamofire.request(URL_API).responseJSON { response in
            let json = response.data
            
            do{
                //created the json decoder
                let decoder = JSONDecoder()
                
                //using the array to put values
                self.products = try decoder.decode([Product].self, from: json!)
                
                //printing all the hero names
                for product in self.products{
                    //var loadJson = ""
                    self.infoTextView.text += "รหัสสินค้า: \(product.productId!) \n\n" + "ชื่อสินค้า: \(product.productName!) \n\n" + "ยี่ห้อสินค้า: \(product.productBrand!) \n\n" + "ประเภทสินค้า: \(product.productCategory!) \n\n" + "สีของสินค้า: \(product.productColor!) \n\n" + "ราคาสินค้า: \(product.productPrice!) บาท"
                    //print(product.productName!)
                }
                
            } catch let err {
                print(err)
            }
        }
        /*
        Alamofire.request("http://www.youite.com/yeen/productGet.php?productId=17").responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                let swiftyJsonVar = JSON(responseData.result.value!) // as? [String: AnyObject]
                print(swiftyJsonVar)
                //self.infoTextView.text = responseData.result.value as? String
            }
            //self.infoTextView.text = responseData.result.value as? String
        */
        
        /* json response
         [
            {
                "productPrice" : "12",
                "productBrand" : "t1",
                "productColor" : "t3",
                "productCategory" : " t2",
                "productName" : "ผ้า",
                "productId" : "17"
            }
         ]
        */
        /*
        DispatchQueue.main.async {
            
            //self.infoTextView.text = result
            //self.infoTextView.text = "Products: \(JSON(responseData.value!) )"
            //self.infoTextView.text =
        }
 */
        
    } // end readerSession
    
        // Start alamofire and SwiftJSON
        /*
        Alamofire.request("http://api.androidhive.info/contacts/").responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                let swiftyJsonVar = JSON(responseData.result.value!)
                
                if let resData = swiftyJsonVar["contacts"].arrayObject {
                    self.arrRes = resData as! [[String:AnyObject]]
                }
                if self.arrRes.count > 0 {
                    //self.tblJSON.reloadData()
                }
            }
        }
 */
        
        //

    
    

}

