//
//  MissionListTableViewController.m
//  Rountine
//
//  Created by lifei on 15/8/2.
//  Copyright (c) 2015年 fan. All rights reserved.
//

#import "MissionListTableViewController.h"
#import "CoreDataManager.h"
#import "MissionListTableViewCell.h"
#import "Mission.h"

@interface MissionListTableViewController () {
  CoreDataManager *_coreDataManager;
  NSArray *_dataArray;
}
@end

@implementation MissionListTableViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  _coreDataManager = [CoreDataManager sharedCoreDataManager];
  _dataArray = [_coreDataManager dataFetchMissions];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
  _dataArray = [_coreDataManager dataFetchMissions];
  [self.tableView reloadData];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {

  return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  MissionListTableViewCell *cell =
      [tableView dequeueReusableCellWithIdentifier:@"reuseCell"
                                      forIndexPath:indexPath];

  if (cell == nil) {
    cell = [[MissionListTableViewCell alloc] initWithParams:nil
                                            reuseIdentifier:@"reuseCell"];
  }
  Mission *mission = [_dataArray objectAtIndex:indexPath.row];
  [cell setCatergory:nil
               title:[mission title]
            reminder:[mission reminder]
              status:[mission status]
                date:[mission time]];

  return cell;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath
 *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView
 commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
 forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath]
 withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array,
 and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath
 *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath
 *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation

 // In a storyboard-based application, you will often want to do a little
 preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
