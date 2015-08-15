//
//  CoreDataManager.h
//  Trying
//
//  Created by lifei on 15-7-13.
//  Copyright (c) 2015年 fan.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "MissionRecord.h"
#import "Package.h"
#import "Mission.h"

@interface CoreDataManager : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext* managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel* managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator* persistentStoreCoordinator;

+ (id)sharedCoreDataManager;
/* 保存数据 */
- (void)saveContext;

- (NSArray*)fetchWithEntityName:(NSString*)entityName
                      predicate:(NSPredicate*)predicate;

- (NSString*)insertPackage:(Package*)package;
- (NSString*)deletePackage:(NSManagedObject*)packageObj;
- (NSString*)updatePackageWithOldObject:(NSManagedObject*)object package:(Package*)package;

- (NSString*)insertMission:(Mission*)mission;
- (NSString*)deleteMission:(NSManagedObject*)missionObj;
- (NSString*)updateMissionWithOldObject:(NSManagedObject*)object newMission:(Mission*)mission;

- (NSString*)insertMissionRecord:(MissionRecord*)record;
- (NSString*)deleteMissionRecord:(NSManagedObject*)missionRecord;
- (NSString*)updateMissionRecordWithOldObject:(NSManagedObject*)object newRecord:(MissionRecord*)record;

@end
