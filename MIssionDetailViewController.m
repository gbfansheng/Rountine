//
//  MIssionDetailViewController.m
//  Rountine
//
//  Created by lifei on 15/8/6.
//  Copyright (c) 2015年 fan. All rights reserved.
//

#import "MIssionDetailViewController.h"
#import "EventView.h"
#import "CircleView.h"

@interface MIssionDetailViewController ()
@property (weak, nonatomic) IBOutlet UIControl *reminderView;
@property (weak, nonatomic) IBOutlet UIControl *bonusView;
@property (weak, nonatomic) IBOutlet UIControl *detailView;
@property (weak, nonatomic) IBOutlet UIControl *titleVIew;

@property (weak, nonatomic) IBOutlet UILabel* bonusTagLabel;
@property (weak, nonatomic) IBOutlet UILabel* bonusLabel;
@property (weak, nonatomic) IBOutlet UILabel* titleLabel;
@property (weak, nonatomic) IBOutlet UITextView* detailTextView;
@property (weak, nonatomic) IBOutlet UILabel* detailTagLabel;
@property (weak, nonatomic) IBOutlet UILabel* titleTagLabel;
@end

@implementation MIssionDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)testSelector
{
    NSLog(@"eventView touch");
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
