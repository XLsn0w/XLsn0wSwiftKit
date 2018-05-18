
import UIKit
import UserNotifications

@available(iOS 10.0, *)

extension UNNotificationAction {
    static func addActionCategory() {
       
        /// 创建category
        /// identifier为了区分多个category时候使用，当使用远程通知的时候，推送上面必须带有
        let category = UNNotificationCategory.init(identifier: "wj_sevenSeconds", actions: createAction(), intentIdentifiers: [], options: .customDismissAction);
        let text_category = UNNotificationCategory.init(identifier: "wj_sevenSeconds_text", actions: createAction(true), intentIdentifiers: [], options: .customDismissAction);
        let customUI_category = UNNotificationCategory.init(identifier: "wj_sevenSeconds_customUI", actions: [], intentIdentifiers: [], options: .customDismissAction);
        /// 添加到通知中心
        let  center = UNUserNotificationCenter.current();
       
        center.setNotificationCategories(Set.init(arrayLiteral: category,text_category,customUI_category));
        
    }    
    static func createAction(_ isText: Bool?=false)->[UNNotificationAction]
    {
        /// 前台不吊起App
        let lookAction = UNNotificationAction.init(identifier: "action.confirm", title: "确认", options: .authenticationRequired);
        /// 红字但是不吊起App
        let cancelAction = UNNotificationAction.init(identifier: "action.cancel", title: "取消", options: .destructive);
        
        /// foreground 表示点击要掉起App
        let likeAction = UNNotificationAction.init(identifier: "action.like", title: "喜欢", options: .foreground);
        var actionArray:[UNNotificationAction] = [];
        if isText == true {
            let textAction = UNTextInputNotificationAction.init(identifier: "action.text", title: "回复", options: .authenticationRequired, textInputButtonTitle: "完成", textInputPlaceholder: "输入回复的内容");
            
            actionArray.append(textAction);
        }else{
            actionArray = [lookAction,likeAction,cancelAction];
        }
        return actionArray;
    }
}
@available(iOS 10.0, *)
extension UNNotification {
    
    static func sendLocalNotification(_ trigger:UNNotificationTrigger,identifier:String?="",isAttachment:Bool?=false,isRemove:Bool?=false)
    {
        /// 创建通知内容对象
        let content = self.getNotificationContent("时间间隔通知",categoryIdentifier: identifier,isAttachment: isAttachment);
        /// 将触发器和通知内容本身添加到通知中心里面
        self.addNotification(content, trigger: trigger,isRemove: isRemove);
    }
    
}
//MARK:- 公共方法
@available(iOS 10.0, *)
extension UNNotification
{
    /// 获取地址的方法
    static fileprivate func getRequestIdentifier()->String
    {
        return String.init(format: "%p", "七秒记忆");
    }
    /// 得到一个通知的实体信息
    @available(iOS 10.0, *)
    static fileprivate func getNotificationContent(_ title:String,categoryIdentifier:String?=nil,isAttachment:Bool?=false)->UNNotificationContent
    {
        /// 创建通知内容对象
        let content = UNMutableNotificationContent.init();
        /// 设置标题
        content.title = "七秒";
        /// 设置副标题
        content.subtitle = title + Date.getNowTime();
        /// 设置body
        content.body = "我是七秒，联系我可以关注简书 http://www.jianshu.com/u/e3402afea1f1"
        /// 设置icon数字
        content.badge = NSNumber.init(value: 888);
        /// 设置声音
        content.sound = UNNotificationSound.default();
        if (categoryIdentifier != nil) {
            /// 设置通知分类的标识符
            content.categoryIdentifier = categoryIdentifier!;
        }
        /// 设置内容，这个也是根据需求，跳转不同的界面
        content.userInfo = ["name":"七秒","简书地址":"http://www.jianshu.com/u/e3402afea1f1"];
        
        if isAttachment == true {
            /// 设置通知的附件
            let imagas = ["xianyu.png","222.png","111.png","333.png","444.png","cry.gif"];
            let count = Int(arc4random_uniform(5));
            let imageName = imagas[count];
            let url = Bundle.main.url(forResource: imageName, withExtension: nil);
            let attachment = try! UNNotificationAttachment.init(identifier: "photo", url: url!);
            
            content.attachments = [attachment];

        }
        return content.copy() as! UNNotificationContent;
    }
    
    @available(iOS 10.0, *)
    static fileprivate func addNotification(_ content:UNNotificationContent , trigger:UNNotificationTrigger,isRemove:Bool? = false)
    {
        /// 设置当前通知的标识
        let indentifier = self.getRequestIdentifier();
        
        /// 将触发器和通知的内容添加到通知的请求中
        let request = UNNotificationRequest.init(identifier: indentifier, content: content, trigger: trigger);
        /// 将请求添加到通知中心
        let center = UNUserNotificationCenter.current();
        center.getDeliveredNotifications { (notificatinArray:[UNNotification]) in
            if isRemove == true{
                removeNotification(center,notificatinArray: notificatinArray);
            }
        }
        center.add(request, withCompletionHandler: { (error:Error?) in
            guard error == nil else {
                print("本地时间延迟通知添加失败");
                return;
            }
            print("本地时间延迟通知添加成功");
        })
    }
    /// 删除通知
    private static func removeNotification(_ center : UNUserNotificationCenter, notificatinArray:[UNNotification]){
        
        var indentifier = [String]();
        for notificatin in notificatinArray {
            let request = notificatin.request as UNNotificationRequest;
            indentifier.append(request.identifier);
            /// 也可以根据title 或者useinfo里面的内容进行判断，从而来删除不需要的通知等等
            /// let  content = request.content as UNNotificationContent;
            /// content.title = "七秒";
            /// content.userInfo = [];
        }
        center.removeDeliveredNotifications(withIdentifiers: indentifier);
    }
}
