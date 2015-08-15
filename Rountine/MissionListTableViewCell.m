//
//  MissionListTableViewCell.m
//  Trying
//
//  Created by lifei on 15-7-19.
//  Copyright (c) 2015年 fan.com. All rights reserved.
//

#import "MissionListTableViewCell.h"
@interface MissionListTableViewCell () {
    NSString* _catergory;
    NSString* _title;
    BOOL _reminder;
    BOOL _status;
    NSDate* _date;
}
@end

@implementation MissionListTableViewCell

- (id)initWithParams:(NSURL*)imageUrl reuseIdentifier:(NSString*)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(8, 4, 64, 64)];
        [self.imageView setImage:[UIImage imageNamed:@"image-1"]];
        self.imageView.clipsToBounds = YES;
        [[self.imageView layer] setCornerRadius:8];
        [self addSubview:imageView];

        UILabel* catergoryLabel = [[UILabel alloc] initWithFrame:CGRectMake(81, 4, 64, 16)];
        [catergoryLabel setText:_catergory];
        [catergoryLabel setFont:[UIFont systemFontOfSize:12]];
        [self addSubview:catergoryLabel];

        UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(81, 20, 72, 30)];
        [titleLabel setText:_title];
        [titleLabel setFont:[UIFont systemFontOfSize:18]];
        [self addSubview:titleLabel];

        UISwitch* reminderSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(200, 20, 32, 32)];
        [reminderSwitch setOn:_reminder];
        [self addSubview:reminderSwitch];

        UISwitch* statusSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(265, 20, 32, 32)];
        [statusSwitch setOn:_status];
        [self addSubview:statusSwitch];
    }
    return self;
}

- (void)setCatergory:(NSString*)catergory
               title:(NSString*)title
            reminder:(BOOL)reminder
              status:(BOOL)status
                date:(NSDate*)date
{
    _catergory = catergory;
    _title = title;
    _reminder = reminder;
    _status = status;
    _date = date;
}
@end
