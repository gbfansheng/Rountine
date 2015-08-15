//
//  Mission.h
//  
//
//  Created by lifei on 15/8/2.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Mission : NSManagedObject

@property (nonatomic, retain) NSString * detail;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSDate * time;
@property (nonatomic, retain) NSNumber * reminder;
@property (nonatomic, retain) NSNumber * status;

@end
