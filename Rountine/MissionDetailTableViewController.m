//
//  MissionDetailTableViewController.m
//  Rountine
//
//  Created by lifei on 15/8/9.
//  Copyright (c) 2015年 fan. All rights reserved.
//

#import "MissionDetailTableViewController.h"
#import "AccumulatedBonusTableViewController.h"
#import "DetailTableViewCell.h"
#import "MissionDetailContentTableViewCell.h"
#import "MissionAlertTableViewCell.h"
#import "CoreDataManager.h"
@interface MissionDetailTableViewController ()
{
    CoreDataManager* _coreDataManager;
}
@property (strong, nonatomic) NSArray* contentArray;
@end

@implementation MissionDetailTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.contentArray = @[ @[ @"标题" ], @[ @"本次完成奖励", @"累计奖励", @"完成情况", @"详细内容" ], @[ @"开启提醒", @"提醒时间", @"重复", @"结束重复"] ];
    _coreDataManager = [CoreDataManager sharedCoreDataManager];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    // Return the number of sections.
    return _contentArray.count;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{ // Return the number of rows in the section.
    NSArray* rowInSectionArray = [_contentArray objectAtIndex:section];
    return rowInSectionArray.count;
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    if ((indexPath.section == 1) && (indexPath.row == 3)) {
        return 150;
    }
    return 44;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    if ((indexPath.section == 1) && (indexPath.row == 3)) {
        MissionDetailContentTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"detailContent"];
        if (cell == nil) {
            UINib* nib = [UINib nibWithNibName:@"MissionDetailContentTableViewCell" bundle:nil];
            [tableView registerNib:nib forCellReuseIdentifier:@"detailContent"];
        }
        cell= [tableView dequeueReusableCellWithIdentifier:@"detailContent"];
        cell.tagLabel.text = @"任务内容";
        cell.contentTextView.text = @"这里是内容";
        return cell;
    } else if (indexPath.section == 2 && indexPath.row == 0) {
        MissionAlertTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"alert"];
        if (cell == nil) {
            UINib* nib = [UINib nibWithNibName:@"MissionAlertTableViewCell" bundle:nil];
            [tableView registerNib:nib forCellReuseIdentifier:@"alert"];
        }
        cell = [tableView dequeueReusableCellWithIdentifier:@"alert"];
        cell.tagLabel.text = @"开启提醒";
        cell.contentSwitch.on = NO;
        return cell;
    }
    else {
        DetailTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"detail"];
        if (cell == nil) {
            UINib* nib = [UINib nibWithNibName:@"DetailTableViewCell" bundle:nil];
            [tableView registerNib:nib forCellReuseIdentifier:@"detail"];
        }
        cell = [tableView dequeueReusableCellWithIdentifier:@"detail"];
        if ((indexPath.section == 0) && (indexPath.row == 0)) {
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        else {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        NSArray* array = [_contentArray objectAtIndex:indexPath.section];
        cell.tagLabel.text = [array objectAtIndex:indexPath.row];
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    if ((indexPath.section == 1) && (indexPath.row == 1)) {
        AccumulatedBonusTableViewController* accumulatedBonusTableViewController = [[AccumulatedBonusTableViewController alloc] init];
        [self.navigationController pushViewController:accumulatedBonusTableViewController animated:YES];
    } else if (indexPath.section == 1 && indexPath.row == 2) {
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"This is alertView" delegate:self cancelButtonTitle:@"Delete" otherButtonTitles:@"Add", nil];
        [alertView show];
        
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
//    NSArray* array = [_coreDataManager dataFetchMissions];
//    if (buttonIndex == 0) {
//        
//    } else if (buttonIndex == 1){
//        [_coreDataManager insertMissionWithTitle:@"m" detail:@"detail" reminder:1 time:[NSDate date] status:YES];
//    }
//    NSLog(@"Array count :%ld",array.count);
}

@end
