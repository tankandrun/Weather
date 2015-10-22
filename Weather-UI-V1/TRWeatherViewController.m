//
//  TRWeatherViewController.m
//  Weather-UI-V1
//
//  Created by soft on 15/9/21.
//  Copyright (c) 2015年 soft. All rights reserved.
//

#import "TRWeatherViewController.h"
#import "TRLabelTool.h"
#import "TRHeaderView.h"
#import "TRWeatherIcon.h"
#import "TRWeather.h"
@import CoreLocation;
@interface TRWeatherViewController ()<UITableViewDataSource,UITableViewDelegate,CLLocationManagerDelegate>{
    //定义实例变量
    CLLocationManager *_locationManager;
    //地理编码
    CLGeocoder *_geocoder;
    
    BOOL _isLoading;
}

//设置私有属性
@property (strong,nonatomic) UITableView *tableView;
@property (strong,nonatomic) UIImageView *backgroundImageView;
@property (strong,nonatomic) TRHeaderView *headerView;
@property (strong,nonatomic) NSArray *dailyWeather;
@property (strong,nonatomic) NSArray *hourlyWeather;
//位置信息
@property (assign,nonatomic) CLLocationCoordinate2D coord;
@property (strong,nonatomic) NSString *location;

@end

@implementation TRWeatherViewController
- (NSArray *)dailyWeather {
    if (!_dailyWeather) {
        _dailyWeather = [NSArray array];
    }
    return _dailyWeather;
}
- (NSArray *)hourlyWeather {
    if (!_hourlyWeather) {
        _hourlyWeather = [NSArray array];
    }
    return _hourlyWeather;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self startlocation];//定位
    [self initTableView];//初始化tableView
    [self initHeaderView];//初始化headerView
    _isLoading = NO;
}

#pragma mark - 解析数据
- (void)initHeaderView {
    CGRect headerFrame = [UIScreen mainScreen].bounds;
    self.headerView = [[TRHeaderView alloc]initWithFrame:headerFrame];
    self.headerView.backgroundColor = [UIColor clearColor];
    //发送http请求，获取json数据
    self.tableView.tableHeaderView = self.headerView;
 }
- (void)sendRequest {
    //创建请求对象
    NSURL *weatherURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://api.worldweatheronline.com/free/v2/weather.ashx?q=%f,%f&num_of_days=4&format=json&tp=3&key=6405cc105dd4a196e30136be48c08",self.coord.latitude,self.coord.longitude]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:weatherURL];
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSInteger responseCode = [(NSHTTPURLResponse *)response statusCode];
        //服务器返回json数据成功
        if (responseCode == 200) {
            NSLog(@"返回成功:%@",[NSThread currentThread]);
            NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            //解析json对象
            [self parseJsonData:jsonData];
        }else {
            NSLog(@"fail:%@",error.userInfo);
        }
    }];
    [task resume];
}
//解析json数据
- (void)parseJsonData:(NSDictionary *)jsonData {
    //对象NSDictionary-->TRWeather
    TRWeather *currentWeather = [TRWeather weatherWithCurrentDic:jsonData];
    //解析每天
    self.dailyWeather = jsonData[@"data"][@"weather"];
    //解析每小时
    self.hourlyWeather = jsonData[@"data"][@"weather"][0][@"hourly"];
    //GCD队列：串行，并行，global queue，main_queue
    //发送方式：sync，async
    dispatch_async(dispatch_get_main_queue(), ^{
        self.headerView.cityLabel.text = self.location;
        self.headerView.conditionsLabel.text = currentWeather.weatherDesc;
        self.headerView.temperatureLabel.text = currentWeather.tempC;
        self.headerView.hiloLabel.text = currentWeather.hiloIcon;
        self.headerView.iconView.image = [UIImage imageNamed:[TRWeatherIcon setImageWithCondition:currentWeather.weatherDesc withTime:currentWeather.time]];
        [self.tableView reloadData];
        _isLoading = NO;
    });
}

#pragma mark - 手动搭建UI
- (void)initTableView {
    //设置背景图片
    CGRect bounds = self.view.bounds;
    self.backgroundImageView = [[UIImageView alloc]initWithFrame:bounds];
    self.backgroundImageView.image = [UIImage imageNamed:@"bg"];
    [self.view addSubview:self.backgroundImageView];
    //创建tableViwe
    self.tableView = [UITableView new];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.frame = bounds;
    //设置dataSource和delegate
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    //设置tableView的间隔线 
    self.tableView.separatorColor = [UIColor colorWithWhite:1 alpha:0.2];
    //设置开启分页功能，将滚动试图UIScrollView分割成独立的段
    self.tableView.pagingEnabled = YES;
    //加载tableView
    [self.view addSubview:self.tableView];
}

#pragma mark - dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return section == 0 ? self.hourlyWeather.count+1 : self.dailyWeather.count+1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"weatherCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    //创建cell
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        cell.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = @"Loading...";
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            [self configureCell:cell title:@"Hourly Forecast"];
        }else{
            NSDictionary *weather =self.hourlyWeather[indexPath.row-1];
            [self configureCell:cell weather:weather isHourly:YES];
        }
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            [self configureCell:cell title:@"Daily Forecast"];
        }else{
            NSDictionary *weather = self.dailyWeather[indexPath.row-1];
            [self configureCell:cell weather:weather isHourly:NO];
        }
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return indexPath.section == 0 ? self.view.frame.size.height/(self.hourlyWeather.count+1) : self.view.frame.size.height/(self.dailyWeather.count+1);
}

#pragma mark - 配置cell头部
- (void)configureCell:(UITableViewCell *)cell title:(NSString *)title {
    cell.textLabel.text = title;
    cell.detailTextLabel.text = nil;
    cell.imageView.image = nil;
}

#pragma mark - 配置非第一行数据
- (void)configureCell:(UITableViewCell *)cell weather:(NSDictionary *)dic isHourly:(BOOL)isHourly {
    
    cell.textLabel.text = isHourly ? [NSString stringWithFormat:@"%02d:00",[dic[@"time"] intValue]/100] : dic[@"date"];
    
    cell.detailTextLabel.text = isHourly ? [NSString stringWithFormat:@"%@°",dic[@"tempC"]] : [NSString stringWithFormat:@"%@° / %@°",dic[@"maxtempC"],dic[@"mintempC"]];

    cell.imageView.image = isHourly ?
     [UIImage imageNamed:[TRWeatherIcon setImageWithCondition:dic[@"weatherDesc"][0][@"value"] withTime:[NSString stringWithFormat:@"%02d:00",[dic[@"time"] intValue]/100]]] :
     [UIImage imageNamed:[TRWeatherIcon setImageWithCondition:dic[@"hourly"][3][@"weatherDesc"][0][@"value"] withTime:[NSString stringWithFormat:@"%02d:00",[dic[@"time"] intValue]/100]]];
                                       
}

#pragma mark - 定位,获取位置信息
- (void)startlocation {
    _locationManager = [[CLLocationManager alloc]init];
    if (![CLLocationManager locationServicesEnabled]) {
        NSLog(@"需要开启定位");
        return;
    }
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
        [_locationManager requestWhenInUseAuthorization];
    }
    _locationManager.delegate = self;
    _locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;//精度为10米
    _locationManager.distanceFilter = 1000.0;//位置超出10米定位一次
    [_locationManager startUpdatingLocation];
    
}
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *location = [locations firstObject];
    CLLocationCoordinate2D coord = location.coordinate;
    self.coord = coord;
    NSLog(@"%f,%f",coord.longitude,coord.latitude);
    
    _geocoder = [[CLGeocoder alloc]init];
    CLLocation *llocation = [[CLLocation alloc]initWithLatitude:coord.latitude longitude:coord.longitude];
    [_geocoder reverseGeocodeLocation:llocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        CLPlacemark *placemark = [placemarks firstObject];
        NSDictionary *dic = placemark.addressDictionary;
        NSLog(@"%@",dic[@"City"]);
        self.location = dic[@"City"];
        [self sendRequest];
    }];
}

#pragma mark - 下拉刷新
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (!_isLoading) {
        if (-scrollView.contentOffset.y / _tableView.frame.size.height > 0.2) {
            _isLoading = YES;
            NSLog(@"...");
            self.headerView.cityLabel.text = @"_(:з」∠)_Loading...";
            self.headerView.conditionsLabel.text = @"_(:з」∠)_Loading...";
            self.headerView.hiloLabel.text = @"_(:з」∠)_Loading...";
            self.headerView.temperatureLabel.text = @"◎";
            [self sendRequest];
        }
    }
}

@end
