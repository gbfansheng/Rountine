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

- (NSString*)insertPackageWithPackage:(NSString *)package
                      currentSequence:(NSNumber *)currentSequence
                           totalTimes:(NSNumber *)totalTimes
                               status:(NSNumber *)status;
- (NSString*)deletePackage:(NSManagedObject*)packageObj;
- (NSString*)updatePackageWithOldObject:(NSManagedObject*)object
                         withNewPackage:(NSString *)package
                        currentSequence:(NSNumber *)currentSequence
                             totalTimes:(NSNumber *)totalTimes
                                 status:(NSNumber *)status;

- (NSString*)insertMissionWithDetail:(NSString *)detail
                             package:(NSString *)package
                               bonus:(NSString *)bonus
                             mission:(NSString *)mission
                            sequence:(NSNumber *)sequence
                             repeats:(NSNumber *)repeats;
- (NSString*)deleteMission:(NSManagedObject*)missionObj;
- (NSString*)updateMissionWithOldObject:(NSManagedObject*)object
                                 detail:(NSString *)detail
                                package:(NSString *)package
                                  bonus:(NSString *)bonus
                                mission:(NSString *)mission
                               sequence:(NSNumber *)sequence;

- (NSString*)insertMissionRecordWith:(NSString *)mission
                                date:(NSDate *)time
                             package:(NSString *)package
                               bonus:(NSString *)bonus;
- (NSString*)deleteMissionRecord:(NSManagedObject*)missionRecord;
- (NSString*)updateMissionRecordWithOldObject:(NSManagedObject*)object
                                      mission:(NSString *)mission
                                         time:(NSDate *)time
                                      package:(NSString *)package
                                        bonus:(NSString *)bonus;

@end
