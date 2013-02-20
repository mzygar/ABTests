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
// Called everytime when test was displayed on the screen
- (void)abtest:(NSString *)testName didDisplayVariant:(NSString *)variantName;
// Called when a specific variant has been picked for the test (called only once - on first test launch)
- (void)abtest:(NSString *)testName didSelectVariant:(NSString *)variantName;

// Called when main goal of a specific test has been reached
- (void)abtest:(NSString *)testName didReachGoalUsingVariant:(NSString *)variantName;
// Called when minor/intermediate goal of a specific test has been reached
- (void)abtest:(NSString *)testName didReachIntermediateGoal:(NSString *)goalName usingVariant:(NSString *)variantName;

@end