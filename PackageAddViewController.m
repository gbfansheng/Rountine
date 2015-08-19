//
//  PackageAddViewController.m
//  Rountine
//
//  Created by lifei on 15/8/16.
//  Copyright (c) 2015年 fan. All rights reserved.
//

#import "PackageAddViewController.h"
#import "CoreDataManager.h"
#import "Package.h"

@interface PackageAddViewController ()
{
    CoreDataManager* _coreDataManager;
}
@end

@implementation PackageAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _coreDataManager = [CoreDataManager sharedCoreDataManager];
    CGFloat offsetHeight = [UIApplication sharedApplication].statusBarFrame.size.height + self.navigationController.navigationBar.frame.size.height;
    
    _packageTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, offsetHeight, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:_packageTextView];
    
    _barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(barButtonItemClick)];
    self.navigationItem.rightBarButtonItem = _barButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)barButtonItemClick
{
    Package* package = [[Package alloc] init];
    package.package = _packageTextView.text;
    package.currentsequence = 0;
    package.totaltimes = [[NSNumber alloc] initWithInt:-1];
    package.status = 0;
    
    [_coreDataManager insertPackage:package];
    [self.navigationController popViewControllerAnimated:YES];
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
