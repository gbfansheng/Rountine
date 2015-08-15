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

@interface MissionDetailTableViewController ()
@property (strong, nonatomic) NSArray* contentArray;
@end

@implementation MissionDetailTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.contentArray = @[ @[ @"标题" ], @[ @"本次完成奖励", @"累计奖励", @"完成情况", @"详细内容" ], @[ @"开启提醒", @"提醒时间" ] ];
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
        MissionDetailContentTableViewCell* missionDetailContentTableViewCell = [[[NSBundle mainBundle] loadNibNamed:@"MissionDetailContentTableViewCell" owner:self options:nil] lastObject];
        missionDetailContentTableViewCell.tagLabel.text = @"任务内容";
        missionDetailContentTableViewCell.contentTextView.text = @"这里是内容";
        return missionDetailContentTableViewCell;
    }
    else {
        DetailTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"detailXib"];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"DetailTableViewCell" owner:self options:nil] lastObject];
        }
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
    }
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
