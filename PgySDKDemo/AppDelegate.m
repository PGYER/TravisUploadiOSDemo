//
//  AppDelegate.m
//  PgySDKDemo
//
//  Created by Scott Lei on 15/2/27.
//  Copyright (c) 2015年 蒲公英. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
//  关闭用户手势反馈，默认为开启。
//  [[PgyManager sharedPgyManager] setEnableFeedback:NO];
    
//  设置用户反馈激活模式为三指拖动，默认为摇一摇。
//  [[PgyManager sharedPgyManager] setFeedbackActiveType:kPGYFeedbackActiveTypeThreeFingersPan];
    
//  设置用户反馈界面的颜色，会影响到Title的背景颜色和录音按钮的边框颜色，默认为0x37C5A1(绿色)。
//  [[PgyManager sharedPgyManager] setThemeColor:[UIColor blackColor]];
    
//  设置摇一摇灵敏度，数字越小，灵敏度越高，默认为2.3。
//  [[PgyManager sharedPgyManager] setShakingThreshold:3.0];
    
//  是否显示蒲公英SDK的Debug Log，如果遇到SDK无法正常工作的情况可以开启此标志以确认原因，默认为关闭。
//  [[PgyManager sharedPgyManager] setEnableDebugLog:YES];

//  启动SDK
//  设置三指拖动激活摇一摇需在此调用之前
    [[PgyUpdateManager sharedPgyManager] startManagerWithAppId:PGY_APPKEY];
    [[PgyManager sharedPgyManager] startManagerWithAppId:PGY_APPKEY];
    
    return YES;
}

@end