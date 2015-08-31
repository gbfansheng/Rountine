//
//  MissionListTableViewController.m
//  Rountine
//
//  Created by lifei on 15/8/2.
//  Copyright (c) 2015年 fan. All rights reserved.
//

#import "PackageListTableViewController.h"
#import "CoreDataManager.h"
#import "PackageTableViewCell.h"
#import "PackageAddViewController.h"
#import "MissionDetailTableViewController.h"

@interface PackageListTableViewController () {
    CoreDataManager* _coreDataManager;
    NSArray* _dataArray;
}
@end

@implementation PackageListTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _coreDataManager = [CoreDataManager sharedCoreDataManager];
    _barbuttonItem = [[UIBarButtonItem alloc]initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(barButtonItemClick)];
    self.navigationItem.rightBarButtonItem = _barbuttonItem;
    NSLog(@"%@",NSStringFromCGSize(self.view.frame.size));
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    _dataArray = [_coreDataManager fetchWithEntityName:@"Package" predicate:nil];
    NSLog(@"dataArray.count :%ld",_dataArray.count);
    [self.tableView reloadData];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView*)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UITableViewCell*)tableView:(UITableView*)tableView
        cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    PackageTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"PackageCell"];
    if (cell == nil) {
        UINib* nib = [UINib nibWithNibName:@"PackageTableViewCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:@"PackageCell"];
    }
    cell = [tableView dequeueReusableCellWithIdentifier:@"PackageCell"];
    Package* package = [_dataArray objectAtIndex:indexPath.row];
    cell.packageImageView.image = [UIImage imageNamed:@"Testimage"];
    cell.packageLabel.text = package.package;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Package* package = [_dataArray objectAtIndex:indexPath.row];
    MissionDetailTableViewController* controller = [[MissionDetailTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    [controller setPackage:package];
    [self.navigationController pushViewController:controller animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (void)barButtonItemClick
{
    PackageAddViewController* packageAddViewController = [[PackageAddViewController alloc]init];
    [self.navigationController pushViewController:packageAddViewController animated:YES];
}
@end
