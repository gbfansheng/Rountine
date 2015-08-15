//
//  MissionListTableViewCell.h
//  Trying
//
//  Created by lifei on 15-7-19.
//  Copyright (c) 2015年 fan.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MissionListTableViewCell : UITableViewCell

- (id)initWithParams:(NSURL*)imageUrl reuseIdentifier:(NSString*)reuseIdentifier;

- (void)setCatergory:(NSString*)catergory
               title:(NSString*)title
            reminder:(BOOL)reminder
              status:(BOOL)status
                date:(NSDate*)date;
@end
