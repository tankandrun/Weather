//
//  TRHeaderView.m
//  Weather-UI-V1
//
//  Created by soft on 15/9/21.
//  Copyright (c) 2015年 soft. All rights reserved.
//

#import "TRHeaderView.h"
#import "TRLabelTool.h"

static CGFloat cityHeight = 30;
static CGFloat statusBarHeight = 20;
static CGFloat inset = 20;
static CGFloat temperatureHeight = 100;
static CGFloat hiloHeight = 30;
static CGFloat iconHeight = 30;

@implementation TRHeaderView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        //创建cityLabel
        CGRect cityFrame = CGRectMake(0, statusBarHeight, frame.size.width, cityHeight);
        self.cityLabel = [TRLabelTool labelWithFrame:cityFrame];
        self.cityLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.cityLabel];
        //创建temperatureLabel
        CGRect temperatureFrame = CGRectMake(inset, frame.size.height - (temperatureHeight + hiloHeight + inset), frame.size.width - 2*inset, temperatureHeight);
        self.temperatureLabel = [TRLabelTool labelWithFrame:temperatureFrame];
        self.temperatureLabel.text = @"◎";
        self.temperatureLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:100];
         [self addSubview:self.temperatureLabel];
        //创建iconView
        CGRect iconViewFrame = CGRectMake(inset, frame.size.height - hiloHeight - temperatureHeight - iconHeight - inset, iconHeight, iconHeight);
        self.iconView = [[UIImageView alloc]initWithFrame:iconViewFrame];
        self.iconView.image = [UIImage imageNamed:@"weather-clear"];
        [self addSubview:self.iconView];
        //创建conditionsLabel
        CGRect conditionsFrame = CGRectMake(inset + iconHeight + 10, frame.size.height - hiloHeight - temperatureHeight - iconHeight - inset, frame.size.width - 2*inset - iconHeight, iconHeight);
        self.conditionsLabel = [TRLabelTool labelWithFrame:conditionsFrame];
        [self addSubview:self.conditionsLabel];
        //创建hiloLabel
        CGRect hiloFrame = CGRectMake(inset, frame.size.height - inset - hiloHeight, frame.size.width - 2*inset, hiloHeight);
        self.hiloLabel = [TRLabelTool labelWithFrame:hiloFrame];
        [self addSubview:self.hiloLabel];
    }
    return self;
}

@end
