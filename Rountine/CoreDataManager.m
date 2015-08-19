//
//  CoreDataManager.m
//  Trying
//
//  Created by lifei on 15-7-13.
//  Copyright (c) 2015年 fan.com. All rights reserved.
//

#import "CoreDataManager.h"
@implementation CoreDataManager

static CoreDataManager* _instance;

@synthesize managedObjectContext = __managedObjectContext;
@synthesize managedObjectModel = __managedObjectModel;
@synthesize persistentStoreCoordinator = __persistentStoreCoordinator;

#pragma mark - CoreDataManager 单例
//保证分配内存相同
+ (id)allocWithZone:(struct _NSZone*)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

+ (instancetype)sharedCoreDataManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[CoreDataManager alloc] init];
    });
    return _instance;
}

- (id)copyWithZone:(NSZone*)zone
{
    return _instance;
}

#pragma mark - CoreData 处理

- (void)saveContext
{
    NSError* error = nil;
    NSManagedObjectContext* managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

- (NSURL*)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory
                                                   inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectContext*)managedObjectContext
{
    if (__managedObjectContext != nil) {
        return __managedObjectContext;
    }
    NSPersistentStoreCoordinator* coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        __managedObjectContext = [[NSManagedObjectContext alloc] init];
        [__managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return __managedObjectContext;
}

- (NSManagedObjectModel*)managedObjectModel
{
    if (__managedObjectModel != nil) {
        return __managedObjectModel;
    }
    NSURL* modelURL = [[NSBundle mainBundle] URLForResource:@"Mission" withExtension:@"momd"];
    __managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return __managedObjectModel;
}

- (NSPersistentStoreCoordinator*)persistentStoreCoordinator
{
    if (__persistentStoreCoordinator != nil) {
        return __persistentStoreCoordinator;
    }
    NSURL* storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Mission.sqlite"];

    NSError* error = nil;
    __persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];

    if (![__persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    return __persistentStoreCoordinator;
}

#pragma mark - 对任务包、任务、任务记录的增删查改操作函数
/**
 *  查询函数合并为一个
 *
 *  @param entityName 实体的名称
 *  @param predicate  条件
 *
 *  @return 返回的信息
 */
- (NSArray*)fetchWithEntityName:(NSString*)entityName
                      predicate:(NSPredicate*)predicate
{
    NSLog(@"fetch WithEntityName:");
    NSManagedObjectContext* context = [self managedObjectContext];
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.predicate = predicate;
    NSEntityDescription* entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:context];
    [fetchRequest setEntity:entity];

    NSError* error;
    NSArray* fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    if (![context save:&error]) {
        NSLog(@"获取任务错误：%@", [error localizedDescription]);
    }
    return fetchedObjects;
}

- (NSString*)insertPackage:(Package*)package
{
    NSLog(@"insert package");
    NSString* resultString;
    NSArray* result = [self fetchWithEntityName:@"Package" predicate:nil];
    if (result.count == 0 || result == nil) {
        NSManagedObjectContext* context = [self managedObjectContext];
        NSManagedObject* packageObj = [NSEntityDescription insertNewObjectForEntityForName:@"Package"
                                                                    inManagedObjectContext:context];
        [packageObj setValue:package.package forKey:@"package"];
        [packageObj setValue:package.currentsequence forKey:@"currentsequence"];
        [packageObj setValue:package.totaltimes forKey:@"totaltimes"];

        NSError* error;
        if (![context save:&error]) {
            NSLog(@"添加任务包错误：%@", [error localizedDescription]);
            resultString = @"添加任务包错误";
        }
        else {
            resultString = @"添加任务包成功";
        }
    }
    else {
        resultString = @"已经存在同名任务包";
    }
    return resultString;
}

- (NSString*)deletePackage:(Package*)packageObj
{
    NSString* package = [packageObj valueForKey:@"package"];
    [self deleteNSManagedObject:packageObj];
    NSArray* missionArray = [self fetchWithEntityName:@"Mission" predicate:[NSPredicate predicateWithFormat:@"package == %@", package]];
    for (NSManagedObject* object in missionArray) {
        [self deleteMission:object];
    }
    return @"删除任务包成功";
}

- (NSString*)updatePackageWithOldObject:(NSManagedObject*)object package:(Package*)package
{
    [self deletePackage:object];
    [self insertPackage:package];
    return @"更新任务包成功";
}

- (NSString*)insertMission:(Mission*)mission
{
    NSLog(@"insert mission");
    NSString* resultString;
    NSArray* array = [self fetchWithEntityName:@"Mission" predicate:[NSPredicate predicateWithFormat:@"mission == %@", mission.mission]];
    if (array == nil || array.count == 0) {
        NSManagedObjectContext* context = [self managedObjectContext];
        NSManagedObject* missionObj = [NSEntityDescription insertNewObjectForEntityForName:@"Mission"
                                                                    inManagedObjectContext:context];
        [missionObj setValue:mission.package forKey:@"package"];
        [missionObj setValue:mission.mission forKey:@"mission"];
        [missionObj setValue:mission.detail forKey:@"detail"];
        [missionObj setValue:mission.bonus forKey:@"bonus"];
        [missionObj setValue:mission.sequence forKey:@"sequence"];

        NSError* error;
        if (![context save:&error]) {
            NSLog(@"添加任务错误：%@", [error localizedDescription]);
            resultString = @"添加任务错误";
        }
        else {
            resultString = @"添加任务成功";
        }
    }
    else {
        resultString = @"已存在同名任务";
    }
    return resultString;
}

- (NSString*)deleteMission:(Mission*)missionObj
{
    NSString* mission = [missionObj valueForKey:@"mission"];
    [self deleteNSManagedObject:missionObj];
    NSArray* missionRecordArray = [self fetchWithEntityName:@"Mission" predicate:[NSPredicate predicateWithFormat:@"mission == %@", mission]];
    for (NSManagedObject* object in missionRecordArray) {
        [self deleteMissionRecord:object];
    }
    return @"删除任务成功";
}

- (NSString*)updateMissionWithOldObject:(NSManagedObject*)object newMission:(Mission*)mission
{
    [self deleteMission:object];
    [self insertMission:mission];
    return @"修改任务成功";
}

- (NSString*)insertMissionRecord:(MissionRecord*)record
{
    NSLog(@"insert missionRecord");
    NSString* resultString;
    NSManagedObjectContext* context = [self managedObjectContext];
    NSManagedObject* recordObj = [NSEntityDescription insertNewObjectForEntityForName:@"MissionRecord"
                                                               inManagedObjectContext:context];
    [recordObj setValue:record.package forKey:@"package"];
    [recordObj setValue:record.mission forKey:@"mission"];
    [recordObj setValue:record.time forKey:@"time"];
    [recordObj setValue:record.bonus forKey:@"bonus"];

    NSError* error;
    if (![context save:&error]) {
        NSLog(@"添加任务记录错误：%@", [error localizedDescription]);
        resultString = @"添加任务记录错误";
    }
    else {
        resultString = @"添加任务记录成功";
    }
    return resultString;
}

- (NSString*)deleteMissionRecord:(MissionRecord*)missionRecord
{
    [self deleteNSManagedObject:missionRecord];
    return @"删除任务记录成功";
}

- (NSString*)updateMissionRecordWithOldObject:(NSManagedObject*)object newRecord:(MissionRecord*)record
{
    [self deleteMissionRecord:object];
    [self insertMissionRecord:record];
    return @"更新记录成功";
}

/**
 *  NSManageObject删除函数，不对外公开
 *
 *  @param object 删除的Object
 *
 *  @return 返回信息
 */
- (NSString*)deleteNSManagedObject:(NSManagedObject*)object
{
    NSManagedObjectContext* context = [self managedObjectContext];
    [context deleteObject:object];
    NSError* error;
    if (![context save:&error]) {
        NSLog(@"删除错误：%@", [error localizedDescription]);
        return @"删除错误";
    }
    return @"删除成功";
}

@end
