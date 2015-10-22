//
//  TRLeftViewController.m
//  Weather-UI-V1
//
//  Created by 金顺度 on 15/10/4.
//  Copyright © 2015年 soft. All rights reserved.
//

#import "TRLeftViewController.h"

@interface TRLeftViewController ()<UITableViewDelegate>

@end

@implementation TRLeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:1]];
    
    UITableView *tableView = [[UITableView alloc]init];
    tableView.frame = CGRectMake(0, self.view.frame.size.height*0.3, self.view.frame.size.width, self.view.frame.size.height*0.7);
//    tableView.dataSource = self;
    tableView.delegate = self;
//    [tableView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:tableView];
}


//- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    return 180;
//}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 180;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
