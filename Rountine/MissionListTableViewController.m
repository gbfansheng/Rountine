//
//  MissionListTableViewController.m
//  Rountine
//
//  Created by Shenglin Fan on 15/8/20.
//  Copyright (c) 2015年 fan. All rights reserved.
//

#import "MissionListTableViewController.h"
#import "CoreDataManager.h"
#import "MissionListTableViewController.h"
#import "MissionCreateViewController.h"
#import "MissionViewController.h"

@interface MissionListTableViewController () {
    CoreDataManager* _coreDataManager;
    NSArray* _missionArray;
    UIBarButtonItem* _addItem;
}
@end

@implementation MissionListTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _coreDataManager = [CoreDataManager sharedCoreDataManager];
    _addItem = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(addItemClick)];
    self.navigationItem.rightBarButtonItem = _addItem;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"package:%@",_package.package);
    _missionArray = [_coreDataManager fetchWithEntityName:@"Mission" predicate:[NSPredicate predicateWithFormat:@"package == %@", _package.package]];
    NSLog(@"missionArray.count = %ld",_missionArray.count);
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
    return 1;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return _missionArray.count;
}

- (void)addItemClick
{
    MissionCreateViewController* controller = [[MissionCreateViewController alloc]initWithNibName:@"MissionCreateViewController" bundle:nil];
    [controller setPackage:_package];
//    MissionViewController* controller = [[MissionViewController alloc]initWithNibName:@"MissionViewController" bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"missionListCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"missionListCell"];
        cell.textLabel.font = [UIFont systemFontOfSize:17];
    }
    Mission* mission = [_missionArray objectAtIndex:indexPath.row];
    cell.textLabel.text = mission.mission;
    return cell;
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
