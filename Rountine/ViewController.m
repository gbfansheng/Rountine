//
//  ViewController.m
//  Rountine
//
//  Created by lifei on 15/8/2.
//  Copyright (c) 2015年 fan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

- (IBAction)clickAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton* click;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clickAction:(id)sender
{
    UILocalNotification* localNotification = [[UILocalNotification alloc] init];
    [localNotification
        setFireDate:[[NSDate alloc] initWithTimeIntervalSinceNow:100]];
    [localNotification setTimeZone:NSTimeZoneNameStyleStandard];
    [localNotification setAlertBody:@"This is alert body"];
    [localNotification setAlertTitle:@"This is alert title"];

    [[UIApplication sharedApplication]
        scheduleLocalNotification:localNotification];
}
@end
