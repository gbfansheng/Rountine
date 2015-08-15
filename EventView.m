//
//  EventView.m
//  Rountine
//
//  Created by lifei on 15/8/6.
//  Copyright (c) 2015年 fan. All rights reserved.
//

#import "EventView.h"

@implementation EventView

- (void)sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event
{
    [super sendAction:action to:target forEvent:event];
    NSLog(@"sendAction");
    NSLog(@"Event:%@",event.description);
    
    NSArray* array = @[@"",@""];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
