
import UIKit

extension String {
    ////
    ///Swift4 中NSFontAttributeName废弃报错问题
    ///NSAttributedStringKey.font 替代 NSFontAttributeName
    ///NSAttributedStringKey.foregroundColor
    
    /// 设置颜色和大小
    ///
    /// - parameter rangString: 需要改变的文字
    /// - parameter color:      改变颜色
    /// - parameter font:       改变的大小
    ///
    /// - returns:
    func wj_deleteAttributes(rangString:String,color:UIColor,font:CGFloat)->NSMutableAttributedString {
        
        let attr = NSMutableAttributedString(string: self);
        let wj_string = self as NSString;
        let wj_rang:NSRange = wj_string.range(of:rangString);
        attr.setAttributes([NSAttributedStringKey.foregroundColor:color,NSAttributedStringKey.font:UIFont.systemFont(ofSize: font)], range: wj_rang);
//        NSStrikethroughStyleAttributeName:NSNumber(value: 1)删除线
        return attr;
     
    }
    
    /// 改变文字的颜色
    ///
    /// - parameter rangString: 需要查找的文字
    /// - parameter color:      颜色
    ///
    /// - returns:
    func wj_Attributes(rangString:String,color:UIColor)->NSMutableAttributedString {
        
        let attr = NSMutableAttributedString(string: self);
        let wj_string = self as NSString;
        let wj_rang = wj_string.range(of: rangString)
        attr.setAttributes([kCTForegroundColorAttributeName as NSAttributedStringKey:color], range: wj_rang);
        return attr;
        
    }
    /// 改变文字的大小
    ///
    /// - parameter rangString: 需要查找的文字
    /// - parameter color:      颜色
    ///
    /// - returns:
    func wj_Attributes(rangString:String,font:CGFloat)->NSMutableAttributedString {
        
        let attr = NSMutableAttributedString(string: self);
        let wj_string = self as NSString;
        let wj_rang = wj_string.range(of: rangString)
        attr.setAttributes([NSAttributedStringKey.font:UIFont.systemFont(ofSize: font)], range: wj_rang);
        return attr;
        
    }
    
    /// 计算文字的size
    ///
    /// - parameter font: 大小
    /// - parameter size: 文本的打下
    ///
    /// - returns: 返回size
    func wj_computedTextHeight(font:CGFloat,size:CGSize)->CGSize{
        print(self,size);
        let str = self as NSString;
        let maxSize = str.boundingRect(with: size, options:NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: font)], context: nil).size
        
        return maxSize;
    }
    
    /// 得到沙盒缓存的路径
    ///
    /// - parameter fileName: 文件名字
    ///
    /// - returns: 返回路径的名字
    func wj_getCachesPath() -> String {
        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last;
        return path! + "/" + self;
    }
    /// 得到带有文件件沙盒缓存的路径
    ///
    /// - parameter fileName: 文件名字
    ///
    /// - returns: 返回路径的名字
    func wj_getCachesPath(folder:String) -> String {
        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last;
        return path! + "/" + folder + "/" + self;
    }
}
