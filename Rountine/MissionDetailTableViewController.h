//
//  MissionDetailTableViewController.h
//  Rountine
//
//  Created by lifei on 15/8/9.
//  Copyright (c) 2015年 fan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Package.h"
@interface MissionDetailTableViewController : UITableViewController <UIAlertViewDelegate>
@property (strong,nonatomic) Package* package;
@end
