//
//  TRWeather.m
//  Weather-UI-V1
//
//  Created by 金顺度 on 15/9/22.
//  Copyright © 2015年 soft. All rights reserved.
//

#import "TRWeather.h"

@implementation TRWeather
#pragma mark - 解析首页label数据
+ (id)weatherWithCurrentDic:(NSDictionary *)dic {
    return [[self alloc]initWithCurrentDic:dic];
}
- (id)initWithCurrentDic:(NSDictionary *)dic {
    if (self = [super init]) {
//        self.cityName = dic[@"data"][@"request"][0][@"query"];
        self.tempC = [NSString stringWithFormat:@"%@°",dic[@"data"][@"current_condition"][0][@"temp_C"]];
        self.weatherDesc = dic[@"data"][@"current_condition"][0][@"weatherDesc"][0][@"value"];
        self.hiloIcon = [NSString stringWithFormat:@" %@° / %@°",dic[@"data"][@"weather"][0][@"mintempC"],dic[@"data"][@"weather"][0][@"maxtempC"]];
        self.time = [NSString stringWithFormat:@"%02d:00",[dic[@"time"] intValue]/100];
    }
    return self;
}
//#pragma mark - 解析hourly部分的数据
//+ (id)weatherWithHourlyDic:(NSDictionary *)dic {
//    return [[self alloc]initWithHourlyDic:dic];
//}
//- (id)initWithHourlyDic:(NSDictionary *)dic {
//    if (self = [super init]) {
//        self.tempC = dic[@"tempC"];
//        self.time = [dic[@"time"] floatValue]/100;
//        self.weatherDesc = dic[@"weatherDesc"][0][@"value"];
//    }
//    return self;
//}


@end
