//
//  CalendarView.h
//  Calendar
//
//  Created by xxx on 16/5/16.
//  Copyright © 2016年 xxx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalendarTools.h"

#import "CalendarCell.h"


#define Blue_textColor [UIColor colorWithRed:105/255.0 green:187/255.0 blue:229/255.0 alpha:1.0]
#define Gray_textColor [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0]

@protocol CalendarDelelgate <NSObject>

- (void)passValue:(NSString *)date;

@end

@interface CalendarView : UICollectionView<UICollectionViewDataSource,UICollectionViewDelegate>

@property(nonatomic,assign) int year;
@property(nonatomic,assign) int searchYear;

@property(nonatomic,assign) int month;
@property(nonatomic,assign) int searchMonth;


@property(nonatomic,assign) int day;
@property(nonatomic,assign) int searchDay;

@property(nonatomic,assign) int daysOfMonth;
@property(nonatomic,assign) int searchDaysOfMonth;

@property(nonatomic,assign) CGFloat cellWidth;

@property(nonatomic,strong) UIView *headerView;

@property(nonatomic,strong) NSMutableArray *registerArr;

@property (nonatomic, assign) id<CalendarDelelgate>calendarDelelgate;


@end
