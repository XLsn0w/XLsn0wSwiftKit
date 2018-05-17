
import UIKit

extension String{
    /**
    将当前的字符串拼接到cache目录后面
    
    - returns: 返回路径
    */
    public func cacheDir()->String{
        /* last! as NSString
         last! 必须要值
         as NSString转化为NSString类型才可以拼接路径
        */
        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask
            .userDomainMask, true).last! as NSString
        /*(self as NSString).lastPathComponent
          self as NSString 将调用方法的string类型转化为NSString类型
          lastPathComponent为最后一个拼接的字符串  例如http://www.baidu.com/wj.jgp截取为wj.jpg
        */
        let filePath = path.appendingPathComponent((self as NSString).lastPathComponent)
        
        return filePath;
        
    }
    /**
    将字符串拼接到docoment目录后面
    
    - returns: 返回路径
    */
    public func documentDir()->String{
        
        let path = NSSearchPathForDirectoriesInDomains( FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last! as NSString
        let filePath = path.appendingPathComponent((self as NSString).lastPathComponent)
        return filePath
    }
    /**
    将字符串拼接到tem目录下面
    
    - returns: 返回路径
    */
    public func temDir ()->String{
        let path = NSTemporaryDirectory() as NSString
        let filePath = path.appendingPathComponent((self as NSString).lastPathComponent)
        return filePath
    }
}
