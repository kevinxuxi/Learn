//
//  AppDelegate.m
//  Learn
//
//  Created by mac on 2020/7/10.
//  Copyright © 2020 mac. All rights reserved.
//

#import "AppDelegate.h"
#import "RootVc.h"
#import <SingSound/SSOralEvaluatingManager.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self initWindow];
    [self registerVad];
    [self setUpNav];
    return YES;
}

- (void)initWindow
{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    RootVc *rootVc = [[RootVc alloc]init];
    UINavigationController *rootNav = [[UINavigationController alloc] initWithRootViewController:rootVc];
    self.window.rootViewController = rootNav;
    [self.window makeKeyAndVisible];
    
}
- (void)registerVad
{
    SSOralEvaluatingManagerConfig *config = [[SSOralEvaluatingManagerConfig alloc] init];
    config.appKey = @"a135";
    config.secretKey = @"5ceb63b8a5124854a92d046dca1e54a3";
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"SSerror"];
    config.logPath = path;
    config.isOutputLog = NO;
    config.vad = YES;
    config.allowDynamicService = YES;
    config.portNumber = @"8080";
    config.protocolHeader = @"ws";
    config.vad = YES;
    config.frontTime = 3;
    config.backTime = 0.5;
    [SSOralEvaluatingManager registerEvaluatingManagerConfig:config];
    [[SSOralEvaluatingManager shareManager] registerEvaluatingType:OralEvaluatingTypeLine];
}

- (void)setUpNav
{
    
    UINavigationBar *bar = [UINavigationBar appearance];
    // 导航栏背景色
    [bar setBarTintColor:[UIColor whiteColor]];
    // 导航栏标题色
    [bar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]}];
    // 返回按钮颜色
    [bar setTintColor:[UIColor darkGrayColor]];
    
    // 返回按钮
    UIBarButtonItem *backItem = [UIBarButtonItem appearance];
    [backItem setBackButtonTitlePositionAdjustment:UIOffsetMake(-500, 0) forBarMetrics:UIBarMetricsDefault];
    
}
@end
