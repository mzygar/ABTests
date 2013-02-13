//
//  ABTestsDelegate.h
//  ABTests
//
//  Created by Michał Zygar on 13.02.2013.
//  Copyright (c) 2013 Michal Zygar. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ABTestsDelegate <NSObject>

@optional
- (void)abtest:(NSString *)testName didDisplayVariant:(NSString *)variantName;
- (void)abtest:(NSString *)testName didSelectVariant:(NSString *)variantName;

- (void)abtestDidReachGoal:(NSString *)testName;
- (void)abtest:(NSString *)testName didReachIntermediateGoal:(NSString *)goalName;

@end