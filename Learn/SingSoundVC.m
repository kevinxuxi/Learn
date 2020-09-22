//
//  SingSoundVC.m
//  Learn
//
//  Created by 徐锡 on 2020/9/22.
//  Copyright © 2020 mac. All rights reserved.
//

#import "SingSoundVC.h"
#import <AVFoundation/AVFoundation.h>
#import <SingSound/SSOralEvaluatingManager.h>

@interface SingSoundVC ()<SSOralEvaluatingManagerDelegate>

@end

@implementation SingSoundVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"SingSound";
   
    // 请求录音权限
    AVAuthorizationStatus recordStauts = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
    if (recordStauts == AVAuthorizationStatusNotDetermined) {
        [[AVAudioSession sharedInstance] requestRecordPermission:^(BOOL granted) {
            
        }];
    }else if (recordStauts == AVAuthorizationStatusDenied || recordStauts == AVAuthorizationStatusRestricted){
        [self recordAVAuthorizationStatusDenied];
    }else{
        NSLog(@"已经授权");
    }
    
    [SSOralEvaluatingManager shareManager].delegate = self;
}

- (void)recordAVAuthorizationStatusDenied
{
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"麦克风权限未开启" message:@"麦克风权限未开启，请进入系统【设置】>【隐私】>【麦克风】中打开开关,开启麦克风功能" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *setAction = [UIAlertAction actionWithTitle:@"去设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }];
    [alertVc addAction:cancelAction];
    [alertVc addAction:setAction];
    [self presentViewController:alertVc animated:YES completion:nil];
}
- (IBAction)clickStart:(id)sender
{
    SSOralEvaluatingConfig *config = [[SSOralEvaluatingConfig alloc] init];
    config.oralType = OralTypeEnglishPcha;
    NSArray *strs = @[@"hello",@"this",@"happy",@"sad",@"button"];
    NSMutableArray *answerArray = [NSMutableArray array];
    for (NSString *str in strs) {
        SSOralEvaluatingAnswer *answer = [[SSOralEvaluatingAnswer alloc] init];
        answer.answer = str;
        [answerArray addObject:answer];
    }
    config.answerArray = answerArray;
    [[SSOralEvaluatingManager shareManager] startEvaluateOralWithConfig:config];
    
    
}

- (IBAction)clickStop:(id)sender
{
    [[SSOralEvaluatingManager shareManager] stopEvaluate];
}

- (void)timeEvent{
    
}
- (void)oralEvaluatingDidStart
{
    NSLog(@"评测开始");
}

- (void)oralEvaluatingDidEndError:(NSError *)error
{
    NSLog(@"%@",error);
}

- (void)oralEvaluatingDidEndWithResult:(NSDictionary *)result isLast:(BOOL)isLast
{
    NSLog(@"%@",result);
}

- (void)oralEvaluatingDidVADBackTimeOut
{
    NSLog(@"后置超时");
}

- (void)oralEvaluatingDidVADFrontTimeOut
{
    NSLog(@"前置超时");
}
@end
