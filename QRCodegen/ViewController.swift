//
//  ViewController.swift
//  QRCodegen
//
//  Created by Carlos Vázquez on 11/01/16.
//  Copyright © 2016 Carlos Vázquez. All rights reserved.
//

import UIKit
import CoreImage

class ViewController: UIViewController {
    
    @IBOutlet weak var inputField: UITextField!
    @IBOutlet weak var btnGenerate: UIButton!
    @IBOutlet weak var imgQRCode: UIImageView!
    @IBOutlet weak var slider: UISlider!
    
    var qrcodeImage: CIImage!
    
    
    //MARK: Actions
    
    @IBAction func performButtonAction(sender: AnyObject)
    {
        if qrcodeImage == nil
        {
            if inputField.text == ""{
                return
            }
            
            btnGenerate.setTitle("Clear", forState: UIControlState.Normal)
            slider.hidden = false
            
            displayQRCodeImage()
            inputField.resignFirstResponder()
        }
        else
        {
            clearCurrentQRCodeGenerated()
        }
        
//        inputField.enabled = !inputField.enabled
//        slider.hidden = !slider.hidden
    }
    
    @IBAction func changeImageViewScale(sender: AnyObject)
    {
        imgQRCode.transform = CGAffineTransformMakeScale(CGFloat(slider.value), CGFloat(slider.value))
    }
    
    

    //MARK: Configure
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        
    }
    
    //MARK: Managers
    

    func generateImageForQRCode() -> CIImage
    {
        let data = inputField.text?.dataUsingEncoding(NSISOLatin1StringEncoding, allowLossyConversion: false)
        
        let filter = CIFilter(name: "CIQRCodeGenerator")
        filter?.setValue(data, forKey: "inputMessage")
        filter?.setValue("Q", forKey: "inputCorrectionLevel")
        
        qrcodeImage = filter?.outputImage
        
        return qrcodeImage
    }
    
    func displayQRCodeImage()
    {
        let image:CIImage = generateImageForQRCode()
        let scaleX = imgQRCode.frame.size.width / image.extent.size.width
        let scaleY = imgQRCode.frame.size.height / image.extent.size.height
        let scaledImage = image.imageByApplyingTransform(CGAffineTransformMakeScale(scaleX, scaleY))
        
        imgQRCode.image = UIImage(CIImage: scaledImage)
    }
    
    func clearCurrentQRCodeGenerated()
    {
        inputField.text = ""
        imgQRCode.image = nil
        qrcodeImage = nil
        btnGenerate.setTitle("Generate", forState: UIControlState.Normal)
    }

}

