//
//  AppDelegate.swift
//  XLsn0wSwiftKit
//
//  Created by ginlong on 2018/5/17.
//  Copyright © 2018年 ginlong. All rights reserved.
//
import UIKit

import UserNotifications

let IOS_verson = Float(UIDevice.current.systemVersion);


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // 申请注册通知权限
        replyPushNotification(application);
        return true
    }
    func replyPushNotification(_ application: UIApplication) {
        
        if #available(iOS 10.0, *) { // 10.0 以上的系统
            let center = UNUserNotificationCenter.current();
            center.delegate = self;
            center.requestAuthorization(options:[ .badge ,.alert,.sound] , completionHandler: { (_ granted :Bool, error:Error?) in
                if (error == nil) && granted {
                    print("iOS10 以后 注册成功");
                }else{
                    print("iOS10 以后的注册失败");
                }
            })
        }else {// 8.0~10.0
            let setting = UIUserNotificationSettings.init(types: [.alert,.badge,.sound], categories: nil);
            application.registerUserNotificationSettings(setting);
        }
        /// 是否通知的按钮
        if #available(iOS 10.0, *) {
            /// 显示通知按钮
            UNNotificationAction.addActionCategory();
        } else {
            // Fallback on earlier versions
        };
        // 注册远端信息获取device token
        application.registerForRemoteNotifications();
    }
    /// 获取远程推送得到的device token
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {

        let token = NSData.init(data: deviceToken)

        let tokenString = token.description;
        let set = CharacterSet.init(charactersIn: "<>");
        var device_token = tokenString.trimmingCharacters(in: set as CharacterSet);
        device_token = device_token.replacingOccurrences(of: " ", with: "");
        print("DeviceToken成功"+device_token);
    }
    /// 获取devicetoken失败调用的方法
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("DeviceToken失败"+error.localizedDescription);
    }
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}
/// ios 10.0 之后接受通知的方法
extension AppDelegate :UNUserNotificationCenterDelegate
{
    /// 应用在前台的时候，接受通知调用的方法
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        /// 收到推送的请求
        let request = notification.request as UNNotificationRequest;
        /// 收到推送的内容
        let content = request.content as UNNotificationContent;
        /// 收到用户的信息字段
        let info = content.userInfo as! [String : Any];
        /// 设置角标
//        let badge = content.badge! as NSNumber;
        /// 收到消息的bady
        let body = content.body as String;
        /// 推送消息的声音
//        let sound = content.sound! as UNNotificationSound;
        /// 推送的标题
        let title = content.title as String;
        /// 推送消息的副标题
        let subtitle = content.subtitle as String;
        /// 远程通知或者本地通知进行判断
        if (request.trigger?.isKind(of: UNPushNotificationTrigger.self))! {/// 远程通知
            /// 此处省略无数行代码，来进行你的逻辑判断，该调那里调那里
            print("我是远程");
        } else {
            //// 此处省略无数行代码，来进行你的逻辑判断，该调那里调那里
            print("我是本地");
        }
        print("通知，具体参数如下："+"\n body:"+body+"\n title:"+title+"\n subtitle"+subtitle);
        print(info);
        
        completionHandler([.alert,.badge,.sound]);
        
        
    }
    /// 点击通知调用的方法 
    /// 但是点击通知扩展上面的按钮同样调用的是此方法
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        /// 获取按钮的标识
        let indentifier = response.actionIdentifier;
        if response.isKind(of: UNTextInputNotificationResponse.self) {
            /// 获取输入的内容
            let textResponse = response as! UNTextInputNotificationResponse;
            let text = textResponse.userText;
            
            print("输入内容"+text);
            /// 此处省略亿万行代码
            
        }else{
            if indentifier == "action.confirm" {
                /// 此处省略亿万行代码
            }else if indentifier == "action.like"{
                print("点击的是喜欢按钮");
                /// 此处省略亿万行代码
            }else if indentifier == "action.cancel"{
                print("点击的是取消按钮");
                /// 此处省略亿万行代码
            }
        }
        
        /// 注意一定要实现
        completionHandler();
    }
}
/// ios 10.0之前调用通知的方法
extension AppDelegate{
    /// 接受本地通知调用的方法
    @objc(application:didReceiveLocalNotification:) func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
        
    }
    
    /// 接受远程通知调用的方法
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        
    }
    /// 点击远程通知调用的方法
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
    }
}
