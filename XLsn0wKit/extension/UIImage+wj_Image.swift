//
//  UIImage+wj_Image.swift
//  BQPReader
//
//  Created by wsj on 16/7/30.
//  Copyright © 2016年 BQP. All rights reserved.
//

import UIKit
import CoreAudio

extension UIImage {
    /**
     直接获取二维码
     
     - parameter title:  二维码的内筒
     - parameter height: 二维码的搞
     
     - returns: 反悔二维码
     */
    class func imageWithCode(title:String,height:CGFloat)->(UIImage) {
        
        return getCodeCIImage(title: title, height: height);
    }
    /**
     返回带有中间图片的二维码
     
     - parameter title:             二维码的内容
     - parameter height:            二维码的高度
     - parameter centerImageName:   二维码中间图片的名字
     - parameter centerImageHeight: 二维码中间图片的高度
     */
    class func  imageWithCode(title:String,height:CGFloat,centerImageName:String,centerImageHeight:CGFloat)->(UIImage) {
        
        let one_image = getCodeCIImage(title: title, height: height);
        UIGraphicsBeginImageContext(CGSizeMake(height, height));
        one_image.drawInRect(CGRectMake(0, 0, height, height));
        let centerX = (height-centerImageHeight)/2;
        UIImage(named: centerImageName)?.drawInRect(CGRectMake(centerX, centerX, centerImageHeight, centerImageHeight));
        let newImage = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        return newImage;
    }
    /**
     带有边框和中间图片的二维码
     
     - parameter title:             二维码内容
     - parameter height:            二维码高度
     - parameter borderImageName:   边框图片名称
     - parameter borderHeight:      边框的高度
     - parameter centerImageName:   中间图片的名称
     - parameter centerImageHeight: 中间图片的高度
     
     - returns: 反悔二维码
     */
    class func imageWithCode(title:String,height:CGFloat,borderImageName:String,borderHeight:CGFloat, centerImageName:String,centerImageHeight:CGFloat)->(UIImage) {
        
        let one_image = getCodeCIImage(title, height: height);
        
        UIGraphicsBeginImageContext(CGSizeMake(borderHeight, borderHeight));
        UIImage(named:borderImageName)!.drawInRect(CGRectMake(0, 0, borderHeight, borderHeight));
        let codeX = (borderHeight-height)/2;
        one_image.drawInRect(CGRectMake(codeX, codeX, height, height));
        
        let centerX = (borderHeight-centerImageHeight)/2;
        UIImage(named: centerImageName)?.drawInRect(CGRectMake(centerX, centerX, centerImageHeight, centerImageHeight));
        let newImage = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        return newImage;
    }
    class func getCodeCIImage(title:String,height:CGFloat)->(UIImage){
        
        let file = CIFilter(name: "CIQRCodeGenerator");// 二维码过滤器
        file?.setDefaults();
        file?.setValue(title.dataUsingEncoding(4), forKeyPath: "inputMessage");
        
        let  onColor = UIColor.blackColor().CGColor;// 绘制的颜色
        let offColor = UIColor.whiteColor().CGColor;// 空白的颜色
        let colorFile = CIFilter(name: "CIFalseColor");// 创建一个黑白过滤器
        colorFile!.setDefaults();
        colorFile?.setValue(file!.outputImage, forKey: "inputImage");
        colorFile?.setValue(CIColor(CGColor: onColor), forKey: "inputColor0");// 上颜色
        colorFile?.setValue(CIColor(CGColor: offColor), forKey: "inputColor1");// 上颜色
        let CIimage = colorFile!.outputImage;// 取出图片
        
        let cgImage = CIContext(options: nil).createCGImage(CIimage!, fromRect: CIimage!.extent);
        
        UIGraphicsBeginImageContext(CGSizeMake(height, height));
        
         let context = UIGraphicsGetCurrentContext();
        CGContextSetInterpolationQuality(context, CGInterpolationQuality.None);
        CGContextScaleCTM(context, 1.0, -1.0);
        CGContextDrawImage(context, CGContextGetClipBoundingBox(context), cgImage);
        let codeImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
//        CGImageRelease(cgImage);
        

        return codeImage;

    }
}
