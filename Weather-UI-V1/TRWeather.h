//
//  TRWeather.h
//  Weather-UI-V1
//
//  Created by 金顺度 on 15/9/22.
//  Copyright © 2015年 soft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRWeather : NSObject

@property (strong,nonatomic) NSString *cityName;
@property (strong,nonatomic) NSString *weatherDesc;
@property (strong,nonatomic) NSString *hiloIcon;

@property (strong,nonatomic) NSString *tempC;

@property (strong,nonatomic) NSString *time;
//@property (assign,nonatomic) float maxTemp;
//@property (assign,nonatomic) float minTemp;

//@property (strong,nonatomic) NSString *hourly;
//@property (strong,nonatomic) NSString *date;
//@property (assign,nonatomic) float time;

+ (id)weatherWithCurrentDic:(NSDictionary *)dic;
//+ (id)weatherWithHourlyDic:(NSDictionary *)dic;

@end
