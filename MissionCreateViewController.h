//
//  MissionCreateViewController.h
//  Rountine
//
//  Created by lifei on 15/8/22.
//  Copyright (c) 2015年 fan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Package.h"
@interface MissionCreateViewController : UIViewController
@property (strong,nonatomic) Package* package;
@property (weak, nonatomic) IBOutlet UITextView *detailTextView;
@property (weak, nonatomic) IBOutlet UITextField *bonusTextField;
@property (weak, nonatomic) IBOutlet UITextField *missionTextField;
@property (weak, nonatomic) IBOutlet UITextField *repeatTextField;

@end
