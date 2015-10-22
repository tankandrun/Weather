//
//  TRLabelTool.m
//  Weather-UI-V1
//
//  Created by soft on 15/9/21.
//  Copyright (c) 2015年 soft. All rights reserved.
//

#import "TRLabelTool.h"

@implementation TRLabelTool

+ (UILabel *)labelWithFrame:(CGRect)frame {
    
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    label.text = @"_(:з」∠)_Loading...";
    label.textColor = [UIColor whiteColor];
//    label.textAlignment = NSTextAlignmentCenter;
//    label.backgroundColor = [UIColor redColor]
    label.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:25];
    
    return label;
}

@end
