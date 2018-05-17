//
//  UIView+ViewController.swift
//  CoreMotion
//
//  Created by mac on 16/7/27.
//  Copyright © 2016年 ZY. All rights reserved.
//

import Foundation
import UIKit
class nilClass : UIViewController{
    
    
}

extension UIView{
    
    func viewOfviewController() -> UIViewController{
        
        
        let next = self.nextResponder();
        repeat{
            
            if ((next?.isKindOfClass(UIViewController)) != nil){
                
                return next as! UIViewController;
            }
            
        }while next != nil;

        
        return nilClass();
    }
    
}

extension NSString{
    //返回字符串所占用的尺寸. 字体大小   最大值可以设置无限大
  
    func sizeWithFontMaxSize(font:UIFont,maxSize:CGSize) -> CGSize{
        let attrs = [NSFontAttributeName : font] as NSDictionary;
        
        
        return self.boundingRectWithSize(maxSize, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: attrs as? [String : AnyObject], context: nil).size;
    }
    
    
}

