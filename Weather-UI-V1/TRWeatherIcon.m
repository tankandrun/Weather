//
//  TRWeatherIcon.m
//  Weather-UI-V1
//
//  Created by soft on 15/9/21.
//  Copyright (c) 2015年 soft. All rights reserved.
//

#import "TRWeatherIcon.h"

@implementation TRWeatherIcon

+ (NSString *)setImageWithCondition:(NSString *)condition withTime:(NSString *)time {
    NSString *imageName = [[NSString alloc]init];
    condition = [[condition componentsSeparatedByString:@","] firstObject];
    if ([condition containsString:@"Sunny"]||[condition containsString:@"Clear"]) {
        if ([time isEqualToString:@"02:00"]||[time isEqualToString:@"20:00"]||[time isEqualToString:@"23:00"]) {
            imageName = @"weather-moon";
        }else {
            imageName = @"weather-clear";
        }
    }else if ([condition containsString:@"Cloudy"]||[condition containsString:@"Overcast"]||[condition containsString:@"cloudy"]){
        imageName = @"weather-broken";
    }else if ([condition containsString:@"Mist"]||[condition containsString:@"Fog"]){
        imageName = @"weather-mist";
    }else if ([condition containsString:@"rain"]||[condition containsString:@"drizzle"]||[condition containsString:@"sleet"]||[condition containsString:@"Rain"]){
        imageName = @"weather-rain";
    }else if ([condition containsString:@"showers"]||[condition containsString:@"shower"]){
        imageName = @"weather-shower";
    }else if ([condition containsString:@"snow"]||[condition containsString:@"Ice"]||[condition containsString:@"ice"]||[condition containsString:@"Blizzard"]){
        imageName = @"weather-snow";
    }else if ([condition containsString:@"thunder"]||[condition containsString:@"Thundery"]){
        imageName = @"weather-tstorm";
    }
    
    return imageName;
}


@end
