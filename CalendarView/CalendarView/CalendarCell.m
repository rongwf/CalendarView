//
//  CalendarCell.m
//  Calendar
//
//  Created by xxx on 16/5/16.
//  Copyright © 2016年 xxx. All rights reserved.
//

#import "CalendarCell.h"

@implementation CalendarCell

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        self.numLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 35, 28)];
       // self.numLabel.backgroundColor=[UIColor grayColor];
        self.numLabel.textAlignment=1;
        self.numLabel.layer.masksToBounds=YES;
        //self.numLabel.layer.borderWidth=1;
        self.numLabel.layer.cornerRadius=28/2;
         // self.numLabel.center=self.center;
        [self addSubview:self.numLabel];
    }
    
    return self;
    
}
@end
