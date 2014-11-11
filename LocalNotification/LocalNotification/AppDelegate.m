//
//  AppDelegate.m
//  LocalNotification
//
//  Created by chenhao on 14/11/10.
//  Copyright (c) 2014年 chenhao. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //取消所有本地通知。限制最多只能存在64个通知
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    NSLog(@"begin===%d",[[UIApplication sharedApplication] scheduledLocalNotifications].count);
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
   
    [[NSNotificationCenter defaultCenter]postNotificationName:@"APPWILLENTERBACKGROUND" object:nil userInfo:nil];
    
    // 申请额外的
    UIApplication *app=[UIApplication sharedApplication];
    
    //一个后台任务标识符
    __block UIBackgroundTaskIdentifier taskId;
    
    //申请后台运行更多时间
    
    taskId=[app beginBackgroundTaskWithExpirationHandler:^(void){
        
        //超出系统延长的时间执行
        //        if (_mClient && _isLogin) {
        //            _mClient->Logout();
        //            _mClient->Close();
        //        }
        NSLog(@"Background task ran out of time and was termined.");
        
        [app endBackgroundTask:taskId];
        
    }];
    
    //申请失败
    
    if(taskId==UIBackgroundTaskInvalid){
        NSLog(@"Fail to start background task!");
        
        return;
        
    }

    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

//收到通知
-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"标题" message:notification.alertBody delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    
    [alert show];
    
}

@end
