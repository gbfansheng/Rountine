//
//  MissionRecord.h
//  Rountine
//
//  Created by lifei on 15/8/15.
//  Copyright (c) 2015年 fan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface MissionRecord : NSManagedObject

@property (nonatomic, retain) NSString * mission;
@property (nonatomic, retain) NSDate * time;
@property (nonatomic, retain) NSString * package;
@property (nonatomic, retain) NSString * bonus;

@end
