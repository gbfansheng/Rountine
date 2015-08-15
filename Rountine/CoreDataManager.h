//
//  CoreDataManager.h
//  Trying
//
//  Created by lifei on 15-7-13.
//  Copyright (c) 2015年 fan.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CoreDataManager : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+(id) sharedCoreDataManager;
/* 保存数据 */
-(void) saveContext;
/* 获取任务的数据*/
-(NSArray *) dataFetchMissions;
/* 插入任务数据 */
- (void)insertMissionWithName:(NSString *)name
                  withExplain:(NSString *) explain
                 withReminder:(int) reminder
                     withTime:(NSDate *) time;
@end
