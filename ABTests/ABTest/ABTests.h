//
//  ABTests.h
//  ABTests
//
//  Created by Michał Zygar on 13.02.2013.
//  Copyright (c) 2013 Michal Zygar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ABVariant.h"
@interface ABTests : NSObject
+ (void)testWithName:(NSString *)testName A:( void ( ^)(void) )blockA B:( void ( ^)(void) )blockB;
+ (void)testWithName:(NSString *)testName variantA:(ABVariant *)variantA variantB:(ABVariant *)variantB;

+ (void)goalReachedForTest:(NSString *)testName;
+ (void)intermediateGoalReached:(NSString *)goalName forTest:(NSString *)testName;
@end