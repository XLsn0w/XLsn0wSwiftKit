
import UIKit

extension Date {
    
    static func getNowTime(_ dateFormat : String = "YYYY-MM-dd HH:mm:ss") -> String {
        
        let formatter = DateFormatter.init();
        formatter.dateFormat = dateFormat;
        
        let date = Date.init();
        
        let nowTime = formatter.string(from: date)
        
        return nowTime
    }
    
}
