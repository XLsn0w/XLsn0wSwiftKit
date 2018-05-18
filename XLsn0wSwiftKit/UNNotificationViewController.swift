

import UIKit
import UserNotifications
import CoreLocation
/** 目的:
        1.答应给别人写Demo，就必须去完成
        2.也是自己去系统去学习一下通知的应用
        3.最重要的，又可以装逼了。或者不装逼和闲鱼有什么区别，嘎嘎
 */
/** 总结：
        1.UNUserNotificationCenter 是通知的管理大脑，我们要把通知的触请求到UNUserNotificationCenter里面，UNUserNotificationCenter会根据通知请求（UNNotificationRequest）里面的通知本身(UNNotificationContent)里面的设置来响应设置的通知
        2.UNNotificationRequest  是通知请求，我们是把通知的触发器和通知本身来创建一个通知请求，并可以直接添加到通知中心里面。我们可以在通知中心根据不同的indentifier来区分请求，其实一个请求就是一个通知
        3.UNNotificationTrigger     通知触发器，抽象类，一般使用子类UNPushNotificationTrigger(远程通知）、UNTimeIntervalNotificationTrigger(间隔触发器)、UNCalendarNotificationTrigger(日历触发器)、UNLocationNotificationTrigger(地区触发器)，其中间隔触发器、日历触发器、地区触发器都是本地通知
        4.UNNotificationContent     通知内容本身，我们可以设置通知的title。body、useinfo、sound、brage等属性来。但是它是只读对象，我们一般使用它的子类UNMutableNotificationContent来设置。当然我们也是可以设置通知本身的category或者Attachment
        5.UNNotificationCategory    通知的分类，我们可以根据通知分类的indenterfiter来使用Notification Content扩展来自定义展示通知内容
        6.UNNotificationAction      通知按钮，我们可以将创建的category来制定action(也就是按钮)，当我们点击按钮的时候，我们可以在appdelegate里面func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) 来获取点击的按钮，特别是回复按钮比较使用
        7.UNNotificationAttachment  通知的附件，附件可以携带,音频5M  图像10M支持  jepg，png。git   视频50M,注意：如果是网络信息，这些附件必须是https连接，并且notification servicer只由30秒的下载时间
 */
/**
    参考资料：感谢以下作者，辛苦了
        http://blog.csdn.net/a454431208/article/details/52780882
        http://blog.csdn.net/a454431208/article/details/52780857
        http://www.jianshu.com/p/f77d070a8812
 */
class UNNotificationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ///  当你测试远程推送的时候，你可以使用 NWPusher 进行远程推送，那样就不需要进行继承第三方的来获取了
        /// 详细地址  https://github.com/noodlewerk/NWPusher
        /// Asset里面由应用的图片
        
        
        /** 注意：远程通知里面必须设置‘mutable-content’字段必须是‘1’
                如果想自定义通知展开动画，必须设置category和你添加的category一致
            */
        /** 注意：远程通知里面必须设置‘mutable-content’字段必须是‘1’
         如果想自定义通知展开动画，必须设置category和你添加的category一致
         */
        /** 注意：远程通知里面必须设置‘mutable-content’字段必须是‘1’
         如果想自定义通知展开动画，必须设置category和你添加的category一致
         */
        
        let button = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 40, height: 40));
        button.setTitle("七秒", for: .normal);
        button.setTitleColor(UIColor.red, for: .normal);
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: button);
    }

}

extension UNNotificationViewController
{
    /// 获取当前用户通知状态 注意只能在iOS10.0 以后可以获取到用户的通知信息
    @IBAction func useNotificationStatua(_ sender: UIButton) {
        
        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            center.getNotificationSettings { (setting:UNNotificationSettings) in
                if setting.authorizationStatus == .notDetermined
                {
                    print("用户没有决定时候");
                }else if setting.authorizationStatus  == .denied {
                    print("用户拒绝了");
                }else if setting.authorizationStatus == .authorized{
                    print("用户允许通知");
                }
            }
        } else {
            
        };
        
    }
}
//MARK:- 本地通知
extension UNNotificationViewController
{
    /// 定时推送
    @IBAction func timeIntervalTrigger(_ sender: UIButton) {
        if #available(iOS 10.0, *) {
            /// 创建触发器  5.0秒后发送推送，不循环推送
            /// 注意 只有在间隔时间大于60秒的时候，才可以使用循环推送
            let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: 5.0, repeats: false);
            UNNotification.sendLocalNotification(trigger);
           
        } else {
            // Fallback on earlier versions
        };
        
        
    }
    /// 创建一个日历通知
    @IBAction func calendarTrigger(_ sender: UIButton) {
        /// 创建一个定期对象
        var components = DateComponents.init();
        components.weekday = 4;
        components.hour = 17;
        components.second = 03;
        
        /// 创建一个日历的出发器
        if #available(iOS 10.0, *) {
            let trigger = UNCalendarNotificationTrigger.init(dateMatching: components, repeats: false)
           
            UNNotification.sendLocalNotification(trigger);

        } else {
            // Fallback on earlier versions
        };
    }
    /// 创建
    @IBAction func locationTrigger(_ sender: UIButton) {
        /// 创建经纬度
        let center  = CLLocationCoordinate2D.init(latitude: 26.336164, longitude: 52.030018);
        /// 创建地区适配器
        let region = CLCircularRegion.init(center: center, radius: 500, identifier: "苏州");
        /// 进入该地区
        region.notifyOnExit = true;
    
        /// 离开该地区
        region.notifyOnEntry = true;
        /// 创建地区触发器
        if #available(iOS 10.0, *) {
            let trigger = UNLocationNotificationTrigger.init(region: region, repeats: false);
            /// 创建通知本身
            UNNotification.sendLocalNotification(trigger);
        } else {
            // Fallback on earlier versions
        };
        
    }

}

import UserNotifications

extension UNNotificationViewController
{
    /// 添加一般的action
    @IBAction func categoryAction(_ sender: UIButton) {
        if #available(iOS 10.0, *) {
            /// 注意 只有在间隔时间大于60秒的时候，才可以使用循环推送
            let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: 3.0, repeats: false);
            UNNotification.sendLocalNotification(trigger,identifier: "wj_sevenSeconds");
            
        } else {
            // Fallback on earlier versions
        };
    }
    /// 添加可以回复的action
    @IBAction func categoryTextAction(_ sender: UIButton) {
        if #available(iOS 10.0, *) {
            /// 注意 只有在间隔时间大于60秒的时候，才可以使用循环推送
            let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: 3.0, repeats: false);
            UNNotification.sendLocalNotification(trigger,identifier: "wj_sevenSeconds_text");
            
        } else {
            // Fallback on earlier versions
        };
    }
    /// 自定义UI界面显示
    @IBAction func notificationCustomUI(_ sender: UIButton) {
        if #available(iOS 10.0, *) {
            let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: 3.0, repeats: false)
            UNNotification.sendLocalNotification(trigger,identifier: "wj_sevenSeconds_customUI",isAttachment: true);
        } else {
            // Fallback on earlier versions
        };
        
    }
    /// 删除通知
    @IBAction func removeNotification(_ sender: UIButton) {
        
        if #available(iOS 10.0, *) {
            let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: 5.0, repeats: false)
            UNNotification.sendLocalNotification(trigger,identifier: "wj_sevenSeconds_remove",isRemove: true);
        } else {
            // Fallback on earlier versions
        }
        
    }
}

