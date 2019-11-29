//
//  WWHealthViewController.m
//  WWLearnDemo
//
//  Created by wwchao on 2019/11/22.
//  Copyright © 2019 wwchao. All rights reserved.
//

#import "WWHealthViewController.h"
#import <UIKit/UIDevice.h>
#import <HealthKit/HealthKit.h>
#import <CoreMotion/CoreMotion.h>

#define HEALTH_SUCCESS_CODE @"0000"
#define HEALTH_ERROR_CODE_DENY @"-3000"
#define HEALTH_OTHER_ERROR_CODE_DEF @"-9999"
@interface WWHealthViewController ()

@end

@implementation WWHealthViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 100, 100, 60);
    button.backgroundColor = [UIColor greenColor];
    [button setTitle:@"获取步数" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(getStepCount) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(100, 100, 100, 100);
    button2.backgroundColor = [UIColor redColor];
    [button2 setTitle:@"设置中打开 app 运动与健身" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(opensetting) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
}

#pragma mark - 设置中打开 app 运动与健身
- (void)opensetting{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
}

#pragma mark - 开始获取步数流程
- (void)getStepCount{
    __weak __typeof(self) weakSelf = self;
    // "健康"授权
    [self authorizateHealthKit:^(BOOL success) {
        if (success) {
            /* step:步数
               tip :提示
               errCode:nil表示获取步数成功 ,  !=nil具体错误码
             */
            [weakSelf getHealthStepCount:^(double stepCount, NSString *tips, NSString *errCode) {
                if (errCode != nil) {
                }else {
                    NSLog(@"当天行走步数 = %lf",stepCount);
                }
                
            }];
        }
    }];
}

#pragma mark - 应用授权检查
- (void)authorizateHealthKit:(void (^)(BOOL success))resultBlock {
    
    if ([HKHealthStore isHealthDataAvailable]) {
        NSSet *readObjectTypes = [NSSet setWithObjects:[HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount], nil];
        
        HKHealthStore * healthStore = [[HKHealthStore alloc] init];
        
        [healthStore requestAuthorizationToShareTypes:nil readTypes:readObjectTypes completion:^(BOOL success, NSError * _Nullable error) {
            if (!error) {
                // success 表示是否在必要时提示用户,并不表示健康授权成功或失败
                resultBlock(success);
            }
        }];
    }
}

#pragma mark - 获取当天健康数据(步数)
- (void)getHealthStepCount:(void (^)(double stepCount, NSString *tips, NSString *errCode))queryResultBlock {
    __weak __typeof(self) weakSelf = self;
    HKQuantityType *quantityType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    HKStatisticsQuery *query = [[HKStatisticsQuery alloc]initWithQuantityType:quantityType quantitySamplePredicate:[weakSelf predicateForSamplesToday] options:HKStatisticsOptionCumulativeSum completionHandler:^(HKStatisticsQuery * _Nonnull query, HKStatistics * _Nullable result, NSError * _Nullable error) {
        if (error) {
            [weakSelf getCMPStepCount: queryResultBlock];
        } else {
            double stepCount = [result.sumQuantity doubleValueForUnit:[HKUnit countUnit]];
            
            if(stepCount > 0){
                if (queryResultBlock) {
                    queryResultBlock(stepCount,@"success",nil);
                }
            } else {
                [weakSelf getCMPStepCount: queryResultBlock];
            }
        }
        
    }];
    
    // 健康数据查询类
    HKHealthStore * healthStore = [[HKHealthStore alloc] init];
    [healthStore executeQuery:query];
}

#pragma mark - 构造当天时间段查询参数
- (NSPredicate *)predicateForSamplesToday {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *now = [NSDate date];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:now];
    [components setHour:0];
    [components setMinute:0];
    [components setSecond: 0];
    
    NSDate *startDate = [calendar dateFromComponents:components];
    NSDate *endDate = [calendar dateByAddingUnit:NSCalendarUnitDay value:1 toDate:startDate options:0];
    
    NSPredicate *predicate = [HKQuery predicateForSamplesWithStartDate:startDate endDate:endDate options:HKQueryOptionNone];
    return predicate;
}

#pragma mark - 获取协处理器步数
- (void)getCMPStepCount:(void(^)(double stepCount, NSString *tips, NSString *errCode))completion {
    if ([CMPedometer isStepCountingAvailable] && [CMPedometer isDistanceAvailable]) {
        // 协处理器类
        CMPedometer *pedometer = [[CMPedometer alloc]init];
        
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDate *now = [NSDate date];
        NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:now];
        // 开始时间
        NSDate *startDate = [calendar dateFromComponents:components];
        // 结束时间
        NSDate *endDate = [calendar dateByAddingUnit:NSCalendarUnitDay value:1 toDate:startDate options:0];
        [pedometer queryPedometerDataFromDate:startDate toDate:endDate withHandler:^(CMPedometerData * _Nullable pedometerData, NSError * _Nullable error) {
            // error.code = 105 也就是CMErrorMotionActivityNotAuthorized 具体的错误信息见 CMError.h
            if (error) {
                if(completion) {
                    completion(0 ,@"没有获取到您的运动与健身的权限",HEALTH_ERROR_CODE_DENY);
                }
            } else {
                double stepCount = [pedometerData.numberOfSteps doubleValue];
                if(completion) {
                    completion(stepCount ,@"success",nil);
                }
            }
            [pedometer stopPedometerUpdates];
        }];
    } else {
        if(completion){
            completion(0 ,@"处理器不可用",HEALTH_OTHER_ERROR_CODE_DEF);
        }
    }
}

@end
