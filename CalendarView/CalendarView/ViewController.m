//
//  ViewController.m
//  CalendarView
//
//  Created by rongwf on 2018/6/28.
//  Copyright © 2018年 rongwf. All rights reserved.
//

#import "ViewController.h"
#import "CalendarView.h"

@interface ViewController ()

@property (nonatomic, strong) CalendarView *calendarView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    layout.minimumInteritemSpacing = 0;
    self.calendarView = [[CalendarView alloc]initWithFrame:CGRectMake(0, 0, 300, 440) collectionViewLayout:layout];
    self.calendarView.center = self.view.center;
//    self.calendarView.calendarDelelgate = self;
    [self.view addSubview:self.calendarView];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
