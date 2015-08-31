//
//  Mission.h
//  Rountine
//
//  Created by lifei on 15/8/22.
//  Copyright (c) 2015年 fan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Mission : NSManagedObject

@property (nonatomic, retain) NSString * bonus;
@property (nonatomic, retain) NSString * detail;
@property (nonatomic, retain) NSString * mission;
@property (nonatomic, retain) NSString * package;
@property (nonatomic, retain) NSNumber * sequence;
@property (nonatomic, retain) NSNumber * repeats;

@end
