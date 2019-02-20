//
//  ViewController.swift
//  LocalNotificationn
//
//  Created by Greens6 on 27/10/18.
//  Copyright © 2018 Greens6. All rights reserved.
//

import UIKit
import UserNotifications
class ViewController: UIViewController{

    @IBAction func sendNotification(_ sender: Any) {
        //scheduling local notification
        UNUserNotificationCenter.current().getNotificationSettings{(settings) in
            guard settings.authorizationStatus == .authorized else{return}
            let content = UNMutableNotificationContent()
            content.categoryIdentifier = "dailyRemainderNotification"
            content.title = "Gud Morning"
            content.body = "Lets get started"
            content.subtitle = "some subtitile"
            content.sound = UNNotificationSound.default()
            var date = DateComponents()
            date.hour = 6
            date.minute = 00
            date.second = 00
            let trigger = 	UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
            let uuidString = UUID().uuidString
            let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // #1.1 - Create "the notification's category value--its type."

        let dailyRemainderCategory = UNNotificationCategory(identifier: "dailyRemainderNotification", actions: [], intentIdentifiers: [],options: [])
        // #1.2 - Register the notification type.
        UNUserNotificationCenter.current().setNotificationCategories([dailyRemainderCategory])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        completionHandler([.alert, .sound, .badge]) //required to show notification when in foreground
    }


}


