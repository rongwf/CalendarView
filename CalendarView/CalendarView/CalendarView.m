//
//  CalendarView.m
//  Calendar
//
//  Created by xxx on 16/5/16.
//  Copyright © 2016年 xxx. All rights reserved.
//

#import "CalendarView.h"

@implementation CalendarView

-(NSMutableArray*)registerArr{
    if (!_registerArr) {
#pragma arguments-初始化应该加载本地或者服务器端签到日期，敲到完成上传或者本地存储；
        
        _registerArr=[[NSMutableArray alloc]init];
        
    }
    return _registerArr;
    
}

-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    self=[super initWithFrame:frame collectionViewLayout:layout];
    
    if (self) {
        
        [self registerClass:[CalendarCell class] forCellWithReuseIdentifier:@"cell"];
        self.scrollEnabled=NO;
        // UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
        //layout.minimumInteritemSpacing=0;
        //
        self.delegate=self;
        self.backgroundColor=[UIColor whiteColor];
        self.dataSource=self;
        //[self registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        //
        self.year=[CalendarTools getYear];
        
        self.searchYear = self.year;
        
        self.month = [CalendarTools getMonth];
        
        self.searchMonth = self.month;
        
        self.day = [CalendarTools getDay];
        
        self.searchDay = self.day;
        
        self.daysOfMonth = [CalendarTools getDaysOfMonthWithYear:self.year withMonth:self.month];
        
        self.searchDaysOfMonth = self.daysOfMonth;
        
        //
        self.cellWidth=(frame.size.width - 8 * 5) / 7;
        //
        [self setHeaderViewWithWidth:frame.size.width];
        //
        //  NSLog(@"%d",[JF_CalendarTools getWeekOfFirstDayOfMonthWithYear:self.year withMonth:self.month]);
        
    }
    return self;
}

-(void)setHeaderViewWithWidth:(CGFloat)width{
    NSArray *a=[NSArray arrayWithObjects:@"日", @"一",@"二",@"三",@"四",@"五",@"六",nil];
    [self.headerView removeFromSuperview];
    self.headerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, width, 80)];
    //self.headerView.backgroundColor=[UIColor blueColor];
    //
    UIButton *nextButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [nextButton setFrame:CGRectMake(width-90, 10, 20, 20)];
    [nextButton addTarget:self action:@selector(next:) forControlEvents:UIControlEventTouchUpInside];
    [nextButton setImage:[UIImage imageNamed:@"next.png"] forState:UIControlStateNormal];
   // nextButton.backgroundColor=[UIColor blackColor];
    [self.headerView addSubview:nextButton];
    UIButton *preButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [preButton setFrame:CGRectMake(70, 10, 20, 20)];
    [preButton addTarget:self action:@selector(pre:) forControlEvents:UIControlEventTouchUpInside];
    [preButton setImage:[UIImage imageNamed:@"pre.png"] forState:UIControlStateNormal];
   // preButton.backgroundColor=[UIColor blackColor];

    [self.headerView addSubview:preButton];
    //
    UILabel *dateLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 16, 100, 30)];
    dateLabel.textAlignment=1;
    dateLabel.center=CGPointMake(width/2, 20);
    dateLabel.text=[NSString stringWithFormat:@"%d-%.2d",self.searchYear,self.searchMonth];
    [self.headerView addSubview:dateLabel];
    //
    UIView *blueView=[[UIView alloc]initWithFrame:CGRectMake(10, 40, width-20, 35)];
//    blueView.backgroundColor=Blue_textColor;
    [self.headerView addSubview:blueView];
    CGFloat labelWidth=(width-35)/7;
    for (int i=0; i<7; i++) {
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(i*labelWidth+3, 0, labelWidth, 30)];
        label.text=[a objectAtIndex:i];
        label.textAlignment=1;
        label.textColor=[UIColor whiteColor];
        if ([label.text isEqualToString:@"日"] || [label.text isEqualToString:@"六"]) {
            label.textColor = getColor(@"fc4848");
        } else {
            label.textColor = [UIColor colorWithRed:26/256.0  green:168/256.0 blue:186/256.0 alpha:1];
        }
        [blueView addSubview:label];
    }
    [self addSubview:self.headerView];
}
-(void)next:(UIButton*)sender{
    //NSLog(@"next");
    if (self.searchMonth==12) {
        self.searchMonth=1;
        self.searchYear++;
        
    }else{
        self.searchMonth++;
    }
    // self.searchDay=[JF_CalendarTools getDay]
    
    [self setHeaderViewWithWidth:self.frame.size.width];
    [self reloadData];
}
-(void)pre:(UIButton*)sender{
   // NSLog(@"pre");
    if (self.searchMonth==1) {
        self.searchMonth=12;
        self.searchYear--;
        
    }else{
        self.searchMonth--;
    }
    // self.searchDay=[JF_CalendarTools getDay]
    self.searchDaysOfMonth = [CalendarTools getDaysOfMonthWithYear:self.searchYear withMonth:self.searchMonth];
    [self setHeaderViewWithWidth:self.frame.size.width];
    [self reloadData];
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
   // return _datasourceArr.count;
    return 42;
}
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//定义每个UICollectionCell 的大小

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //return CGSizeMake((K_Width-5)/4, 130);
    return CGSizeMake(self.cellWidth, self.cellWidth-10);
}
//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    //  UIEdgeInsetsMake(<#CGFloat top#>, <#CGFloat left#>, <#CGFloat bottom#>, <#CGFloat right#>)
    return UIEdgeInsetsMake(80, 17.5, 1, 17.5);
    
}
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CalendarCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.numLabel.font = [UIFont systemFontOfSize:18];
    int dateNum = (int)indexPath.row - [CalendarTools getWeekOfFirstDayOfMonthWithYear:self.searchYear withMonth:self.searchMonth] + 1;
    
    /*
     统一日期设置
     */
    //月内
    if (dateNum>=1&&(indexPath.row<self.searchDaysOfMonth+[CalendarTools getWeekOfFirstDayOfMonthWithYear:self.searchYear withMonth:self.searchMonth])) {
        cell.numLabel.text=[NSString stringWithFormat:@"%d",dateNum];
        cell.numLabel.textColor=[UIColor colorWithRed:26/256.0  green:168/256.0 blue:186/256.0 alpha:1];
        if ((indexPath.item + 1) % 7 == 0 || (indexPath.item + 1) % 7 == 1) {
            cell.numLabel.textColor = getColor(@"fc4848");
        }
        
    }
    
    //前一个月
    if (dateNum<1) {
        // cell.numLabel.text=@"";
        cell.numLabel.textColor=[UIColor grayColor];
        
        int days;
        if (self.searchMonth!=1) {
            days=[CalendarTools getDaysOfMonthWithYear:self.searchYear withMonth:self.searchMonth-1];
        }else if(self.searchMonth==1){
            days=[CalendarTools getDaysOfMonthWithYear:self.searchYear-1 withMonth:12];
        }
        cell.numLabel.text=[NSString stringWithFormat:@"%d",dateNum+days];
        cell.numLabel.text = @"";
    }
    
    //后一个月
    if (dateNum>self.searchDaysOfMonth) {
        cell.numLabel.text=[NSString stringWithFormat:@"%d",dateNum-self.searchDaysOfMonth];
        cell.numLabel.textColor=[UIColor grayColor];
        cell.numLabel.text = @"";
    }
    /*
     背景颜色设置
     */
    //当前月
    if ([NSString stringWithFormat:@"%d%.2d",self.year,self.month].intValue==[NSString stringWithFormat:@"%d%.2d",self.searchYear,self.searchMonth].intValue) {
        cell.numLabel.backgroundColor=[UIColor whiteColor];
        cell.numLabel.layer.masksToBounds=YES;
        cell.numLabel.layer.borderColor=[UIColor grayColor].CGColor;
        cell.numLabel.layer.borderWidth=0;
        //月内
        if (dateNum>=1&&(dateNum<=self.searchDay)) {
            //            cell.numLabel.backgroundColor=Gray_textColor;
            cell.numLabel.text=[NSString stringWithFormat:@"%d",dateNum];
            cell.numLabel.textColor=[UIColor lightGrayColor];
            //            cell.numLabel.layer.borderWidth=1;
            
        }
        
    }
    //之后的月
    if ([NSString stringWithFormat:@"%d%.2d",self.year,self.month].intValue<[NSString stringWithFormat:@"%d%.2d",self.searchYear,self.searchMonth].intValue) {
        // NSLog(@"大于");
        cell.numLabel.layer.masksToBounds=YES;
        cell.numLabel.layer.borderColor=[UIColor grayColor].CGColor;
        cell.numLabel.layer.borderWidth=0;
        cell.numLabel.backgroundColor=[UIColor whiteColor];
    }
    //之前的月
    if ([NSString stringWithFormat:@"%d%.2d",self.year,self.month].intValue>[NSString stringWithFormat:@"%d%.2d",self.searchYear,self.searchMonth].intValue) {
        //NSLog(@"小于");
        cell.numLabel.layer.masksToBounds=YES;
        cell.numLabel.layer.borderColor=[UIColor grayColor].CGColor;
        cell.numLabel.layer.borderWidth=0;
        cell.numLabel.backgroundColor=[UIColor whiteColor];
        //月内
        if (dateNum >= 1 && (indexPath.row < self.searchDaysOfMonth + [CalendarTools getWeekOfFirstDayOfMonthWithYear:self.searchYear withMonth:self.searchMonth])) {
            cell.numLabel.text=[NSString stringWithFormat:@"%d",dateNum];
            cell.numLabel.textColor=[UIColor lightGrayColor];
        }
    }
    /*
     设置签到颜色
     */
#pragma arguments-数组内包含当前日期则说明此日期签到了，设置颜色为蓝色；
    if(dateNum - self.day == 0 && self.year == self.searchYear && self.month == self.searchMonth){
        cell.numLabel.textColor=[UIColor colorWithRed:1.000 green:0.747 blue:0.486 alpha:1.000];
        cell.numLabel.font = [UIFont systemFontOfSize:14];
        cell.numLabel.text = @"今天";
    } else if (dateNum - self.day == 1 && self.year == self.searchYear && self.month == self.searchMonth) {
        cell.numLabel.textColor=[UIColor colorWithRed:1.000 green:0.747 blue:0.486 alpha:1.000];
        cell.numLabel.font = [UIFont systemFontOfSize:14];
        cell.numLabel.text = @"明天";
    } else if (dateNum - self.day == 2 && self.year == self.searchYear && self.month == self.searchMonth) {
        //        cell.numLabel.backgroundColor=Blue_textColor;
        cell.numLabel.textColor=[UIColor colorWithRed:1.000 green:0.747 blue:0.486 alpha:1.000];
        cell.numLabel.font = [UIFont systemFontOfSize:14];
        cell.numLabel.text = @"后天";
    }
    
    if ([self.registerArr containsObject:[NSString stringWithFormat:@"%.4d%.2d%.2d",self.searchYear,self.searchMonth,dateNum]] ) {
        cell.numLabel.backgroundColor=Blue_textColor;
        cell.numLabel.textColor=[UIColor whiteColor];
        cell.numLabel.layer.masksToBounds=YES;
        cell.numLabel.font = [UIFont systemFontOfSize:18];
        cell.numLabel.text=[NSString stringWithFormat:@"%d",dateNum];
    }
    
    return cell;
    
}

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    int dateNum = (int)indexPath.row - [CalendarTools getWeekOfFirstDayOfMonthWithYear:self.searchYear withMonth:self.searchMonth] + 1;
    NSString *str = [NSString stringWithFormat:@"%.4d%.2d%.2d", self.year, self.month, self.day];
    NSString *str1 = [NSString stringWithFormat:@"%.4d%.2d%.2d", self.searchYear, self.searchMonth, dateNum];
    if (dateNum >= 1 && dateNum <= self.searchDaysOfMonth && [str1 integerValue] >= [str integerValue]) {
        [self.registerArr removeAllObjects];
        [self.registerArr addObject:[NSString stringWithFormat:@"%.4d%.2d%.2d",self.searchYear,self.searchMonth,dateNum]];
        [collectionView reloadData];
        if ([_calendarDelelgate respondsToSelector:@selector(passValue:)]) {
            [_calendarDelelgate passValue:[NSString stringWithFormat:@"%.4d-%.2d-%.2d", self.searchYear, self.searchMonth, dateNum]];
        }
    }
    
}

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

UIColor* getColor(NSString * hexColor) {
    unsigned int red, green, blue;
    NSRange range;
    range.length = 2;
    
    range.location = 0;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&red];
    range.location = 2;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&green];
    range.location = 4;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&blue];
    
    return [UIColor colorWithRed:(float)(red/255.0f) green:(float)(green/255.0f) blue:(float)(blue/255.0f) alpha:1.0f];
}


@end
