//
//  Package.h
//  Rountine
//
//  Created by lifei on 15/8/15.
//  Copyright (c) 2015年 fan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Package : NSManagedObject

@property (nonatomic, retain) NSString * package;
@property (nonatomic, retain) NSNumber * currentsequence;
@property (nonatomic, retain) NSNumber * totaltimes;
@property (nonatomic, retain) NSNumber * status;

@end
