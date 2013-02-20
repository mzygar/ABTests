//
//  ABTests.h
//  ABTests
//
//  Created by Michał Zygar on 13.02.2013.
//  Copyright (c) 2013 Michal Zygar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ABVariant.h"
#import "ABTestsDelegate.h"
@interface ABTests : NSObject

// Delegate object to report actions to. Not mandatory
+ (void)setDelegate:(id <ABTestsDelegate>)delegate;

/**
 * Conducts AB test of given name. It takes two ABVariant objects as parameters. User can name the
 * variants with custom labels
 *
 * @param testName - name(or id) of the test performed
 * @param variantA - variant A, containing id and execution block
 * @param variantB - variant B, containing id and execution block
 */
+ (void)testWithName:(NSString *)testName variantA:(ABVariant *)variantA variantB:(ABVariant *)variantB;


/**
 *  Convienence method for conducting tests.
 * It will call testWithName:variantA:variantB: method with variants named "A" and "B"
 *
 * @param testName - name(or id) of the test performed
 * @param blockA - block to execute if variant A is selected
 * @param blockB - block to execute if variant B is selected
 */
+ (void)testWithName:(NSString *)testName A:( void ( ^)(void) )blockA B:( void ( ^)(void) )blockB;


/**
 * Executes given block provided that ABTest is using given variant
 *
 * @param executionBlock - block to execute
 * @param testName - name of the test performed
 * @param variantName - requested variant name
 */
+ (void)performAdditionalCode:( void ( ^)(void) )executionBlock forTestWithName:(NSString *)testName usingVariant:(NSString *)variantName;


/**
 * Notifies the delegate that the main goal of the test has been reached
 *
 * @param testName - name (or id) of the test
 */
+ (void)goalReachedForTest:(NSString *)testName;

/**
 * Notifies the delegate that minor/additional goal for given test has been reached
 *
 * @param goalName - name of the goal reached
 * @param testName - name (or id) of the test
 */
+ (void)intermediateGoalReached:(NSString *)goalName forTest:(NSString *)testName;
@end