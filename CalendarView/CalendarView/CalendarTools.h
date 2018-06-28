//
//  CalendarTools.h
//  Calendar
//
//  Created by xxx on 16/5/16.
//  Copyright © 2016年 xxx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalendarTools : NSObject

+(int)getWeekOfFirstDayOfMonthWithYear:(int)year withMonth:(int)month;
+(int)getDaysOfMonthWithYear:(int)year withMonth:(int)month;
+(int)getYear;
+(int)getMonth;
+(int)getDay;
+(BOOL)isLoopYear:(NSInteger)year;

@end
