//
//  MissionCreateViewController.m
//  Rountine
//
//  Created by lifei on 15/8/22.
//  Copyright (c) 2015年 fan. All rights reserved.
//

#import "MissionCreateViewController.h"
#import "CoreDataManager.h"

@interface MissionCreateViewController (){
    CoreDataManager* _coreDataManager;
}
@property (strong,nonatomic) UIBarButtonItem* barButtonItem;
@end

@implementation MissionCreateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _coreDataManager = [CoreDataManager sharedCoreDataManager];
    _barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(finishButtonItemClick)];
    self.navigationItem.rightBarButtonItem = _barButtonItem;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)finishButtonItemClick
{
    NSLog(@"create package:%@",_package.package);
    [_coreDataManager insertMissionWithDetail:_detailTextView.text package:_package.package bonus:_bonusTextField.text mission:_missionTextField.text sequence:0 repeats:[NSNumber numberWithInt:-1]];
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
