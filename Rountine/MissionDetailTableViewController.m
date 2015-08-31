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
#import "MissionListTableViewController.h"
#import "PickerTableViewCell.h"

@interface MissionDetailTableViewController () {
    CoreDataManager* _coreDataManager;
    NSMutableArray* _tagArray;
    NSMutableArray* _tagSection0;
    NSMutableArray* _tagSection1;
    NSMutableArray* _tagSection2;
    NSMutableArray* _tagSection3;
    NSArray* _contentArray;
    UIBarButtonItem* _editItem;
    Mission* _currentMission;
    UILocalNotification* _currentNotification;
    NSDate* _pickerDate;
    BOOL _pickerViewFlag;
}
@end

@implementation MissionDetailTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _tagSection0 = [[NSMutableArray alloc]initWithObjects:@"标题", nil];
    _tagSection1 = [[NSMutableArray alloc] initWithObjects:@"本次完成奖励",@"累计奖励",@"完成情况",@"详细内容", nil];
    _tagSection2 = [[NSMutableArray alloc] initWithObjects:@"开启提醒", nil];
    _tagSection3 = [[NSMutableArray alloc] initWithObjects:@"编辑任务包", nil];
    _tagArray = [[NSMutableArray alloc] initWithObjects:_tagSection0,_tagSection1,_tagSection2,_tagSection3, nil];
    _coreDataManager = [CoreDataManager sharedCoreDataManager];
    _editItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(editItemClick)];
    self.navigationItem.rightBarButtonItem = _editItem;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSArray* array = [_coreDataManager fetchWithEntityName:@"Mission" predicate:[NSPredicate predicateWithFormat:@"package == %@ AND sequence == %@", _package.package, _package.currentsequence]];
    if (array.count > 0) {
        _currentMission = [array objectAtIndex:0];
        _contentArray = @[ @[ _currentMission.mission ], @[ _currentMission.bonus, @"", @"", _currentMission.detail ], @[ @"", @"", @"", @"" ], @[ @"" ] ];
    }
    NSArray* notifications = [[UIApplication sharedApplication] scheduledLocalNotifications];
    for (UILocalNotification* notification in notifications) {
        NSDictionary *dict = notification.userInfo;
        if ([[dict objectForKey:@"package"] isEqualToString:_currentMission.package]) {
            _currentNotification = notification;
        }
    }
    _pickerViewFlag = NO;
    _pickerDate = [NSDate date];
    [self.tableView reloadData];
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
    return _tagArray.count;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{ // Return the number of rows in the section.
    NSArray* rowInSectionArray = [_tagArray objectAtIndex:section];
    return rowInSectionArray.count;
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    if ((indexPath.section == 1) && (indexPath.row == 3)) {
        return 150;
    } else if (_pickerViewFlag && indexPath.section == 2 && indexPath.row == 2) {
        return 162;
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
        cell = [tableView dequeueReusableCellWithIdentifier:@"detailContent"];
        cell.tagLabel.text = @"任务内容";
        cell.contentTextView.text = _currentMission.detail;
        return cell;
    }
    else if (indexPath.section == 2 && indexPath.row == 0) {
        MissionAlertTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"alert"];
        if (cell == nil) {
            UINib* nib = [UINib nibWithNibName:@"MissionAlertTableViewCell" bundle:nil];
            [tableView registerNib:nib forCellReuseIdentifier:@"alert"];
        }
        cell = [tableView dequeueReusableCellWithIdentifier:@"alert"];
        cell.tagLabel.text = @"开启提醒";
        if (_currentNotification) {
            cell.contentSwitch.on = YES;
            [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:2]] withRowAnimation:UITableViewRowAnimationBottom];
        } else {
            cell.contentSwitch.on = NO;
        }
        [cell.contentSwitch addTarget:self action:@selector(switchClicked:) forControlEvents:UIControlEventValueChanged];
        return cell;
    }
    else if (_pickerViewFlag && indexPath.section == 2 && indexPath.row == 2) {
        PickerTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"picker"];
        if (cell == nil) {
            UINib* nib = [UINib nibWithNibName:@"PickerTableViewCell" bundle:nil];
            [tableView registerNib:nib forCellReuseIdentifier:@"picker"];
        }
        cell = [tableView dequeueReusableCellWithIdentifier:@"picker"];
        [cell.datePicker setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
        cell.datePicker.timeZone = [NSTimeZone timeZoneWithName:@"GMT+8"];
        [cell.datePicker addTarget:self action:@selector(pickDate:) forControlEvents:UIControlEventValueChanged];
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
        NSArray* array = [_tagArray objectAtIndex:indexPath.section];
        cell.tagLabel.text = [array objectAtIndex:indexPath.row];
        array = [_contentArray objectAtIndex:indexPath.section];
        cell.contentLabel.text = [array objectAtIndex:indexPath.row];
        if (indexPath.section == 2 && indexPath.row == 1) {
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
            [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
            NSString *formattedDateString = [dateFormatter stringFromDate:_pickerDate];
            cell.contentLabel.text = formattedDateString;
        }
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    NSLog(@"indexpath.section:%ld row:%ld",indexPath.section,indexPath.row);
    if ((indexPath.section == 1) && (indexPath.row == 1)) {
        AccumulatedBonusTableViewController* accumulatedBonusTableViewController = [[AccumulatedBonusTableViewController alloc] init];
        [self.navigationController pushViewController:accumulatedBonusTableViewController animated:YES];
    }
    else if (indexPath.section == 1 && indexPath.row == 2) {
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"This is alertView" delegate:self cancelButtonTitle:@"Delete" otherButtonTitles:@"Add", nil];
        [alertView show];
    }
    else if (indexPath.section == 3 && indexPath.row == 0) {
        MissionListTableViewController* controller = [[MissionListTableViewController alloc] init];
        [controller setPackage:_package];
        [self.navigationController pushViewController:controller animated:YES];
    }
    else if (indexPath.section == 2 && indexPath.row == 1) {
        if (!_pickerViewFlag) {
            _pickerViewFlag = YES;
            [_tagSection2 addObject:@"picker"];
            [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 inSection:2]] withRowAnimation:UITableViewRowAnimationTop];
        } else {
            [_tagSection2 removeObjectAtIndex:2];
            [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 inSection:2]] withRowAnimation:UITableViewRowAnimationTop];
            _pickerViewFlag = NO;
        }
    }
}

- (void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //    NSArray* array = [_coreDataManager dataFetchMissions];
    //    if (buttonIndex == 0) {
    //
    //    } else if (buttonIndex == 1){
    //        [_coreDataManager insertMissionWithTitle:@"m" detail:@"detail" reminder:1 time:[NSDate date] status:YES];
    //    }
    //    NSLog(@"Array count :%ld",array.count);
}

- (void)editItemClick
{
    
}

- (void)switchClicked:(UISwitch*)switcher
{
    NSLog(@"bool:%i",switcher.on);
    if (switcher.on) {
        [_tagSection2 addObject:@"提醒"];
        [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:2]] withRowAnimation:UITableViewRowAnimationTop];
    } else {
        if (_pickerViewFlag) {
            [_tagSection2 removeObjectAtIndex:2];
            [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 inSection:2]] withRowAnimation:UITableViewRowAnimationFade];
            _pickerViewFlag = NO;
        }
        [_tagSection2 removeObjectAtIndex:1];
        [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:2]] withRowAnimation:UITableViewRowAnimationTop];
    }
}

- (void)pickDate:(UIDatePicker *)picker
{
    _pickerDate = picker.date;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
    NSString *formattedDateString = [dateFormatter stringFromDate:_pickerDate];
    NSLog(@"%@",formattedDateString);
}
@end
