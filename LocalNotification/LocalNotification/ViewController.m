//
//  ViewController.m
//  LocalNotification
//
//  Created by chenhao on 14/11/10.
//  Copyright (c) 2014年 chenhao. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(enterBackground) name:@"APPWILLENTERBACKGROUND" object:nil];
}

- (void)enterBackground{
    NSLog(@"enter background");
    [self performSelector:@selector(pushNotification) withObject:nil afterDelay:2.0];
}

-(void)pushNotification{
  
    
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    
    
    // 设置notification的属性
    localNotification.fireDate = [[NSDate date] dateByAddingTimeInterval:2]; //推送时间，2s后
    
    //时区
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    // 消息内容
    localNotification.alertBody = [NSString stringWithFormat:@" 邀请你聊天"];
    // 重复的时间间隔
    localNotification.repeatInterval = NSSecondCalendarUnit;
    // 触发消息时播放的声音
    localNotification.soundName = @"ring.caf";
  
    //            localNotification.applicationIconBadgeNumber ++; //应用程序Badge数目
    //            localNotification.applicationIconBadgeNumber = [[[UIApplication sharedApplication] scheduledLocalNotifications] count]+1;
   
    NSLog(@"push====%d",[[[UIApplication sharedApplication] scheduledLocalNotifications] count]);
   
    localNotification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber]+1;
    
    
    //存入的字典，用于传入数据，区分多个通知
    
    NSMutableDictionary *dicUserInfo = [[NSMutableDictionary alloc] init];
    
    [dicUserInfo setValue:@"" forKey:@"clockID"];
    
    float floatHeng = 100.0;
    
    float floatShu = 50.0;
    
    [dicUserInfo setValue:[NSString stringWithFormat:@"%f",floatHeng] forKey:@"heng"];
    
    [dicUserInfo setValue:[NSString stringWithFormat:@"%f",floatShu] forKey:@"shu"];
    
    localNotification.userInfo = [NSDictionary dictionaryWithObject:dicUserInfo forKey:@"dictionary"];
    
    //注册
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    
    /*
     根据字典删除个别通知
     
     key:发送通知时候传入的字典值来判断是哪个推送
     
     for (int i=0; i<[myArray count]; i++) {
     
     UILocalNotification    *myUILocalNotification=[myArray objectAtIndex:i];
     
     if ([[[myUILocalNotification userInfo] objectForKey:@"key"] intValue]==@"字典值") {
     
     [[UIApplication sharedApplication] cancelLocalNotification:myUILocalNotification];
     }
     }
     */
    
    

}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"APPWILLENTERBACKGROUND" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
