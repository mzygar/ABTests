//
//  ABTests.m
//  ABTests
//
//  Created by Michał Zygar on 13.02.2013.
//  Copyright (c) 2013 Michal Zygar. All rights reserved.
//

#import "ABTests.h"


#define CHOSEN_VARIANT_INDEX_SUFFIX @"_chosenVariant"
#define CHOSEN_VARIANT_NAME_SUFFIX @"_chosenVariantName"

@interface ABTests ()

@property (nonatomic, assign) id <ABTestsDelegate> delegate;

// picks random test variant out given array and returns its index
+ (NSNumber *)chooseTestVariantForTest:(NSString *)testName fromVariants:(NSArray *)variants;
// returns chosen test variant index
+ (NSNumber *)chosenTestVariantForTest:(NSString *)testName;

@end

@implementation ABTests

#pragma mark -
#pragma mark Testing
+ (void)testWithName:(NSString *)testName A:( void ( ^)(void) )blockA B:( void ( ^)(void) )blockB
{
    [ABTests testWithName:testName variantA:[ABVariant variantWithName:@"A" andBlock:blockA] variantB:[ABVariant variantWithName:@"B" andBlock:blockB]];
}

+ (void)testWithName:(NSString *)testName variantA:(ABVariant *)variantA variantB:(ABVariant *)variantB
{
    [ABTests testWithName:testName variants:[NSArray arrayWithObjects:
                                             variantA,
                                             variantB,
                                             nil]];
}

+ (void)testWithName:(NSString *)testName variants:(NSArray *)variants
{
    NSNumber *chosenVariantIndex = [ABTests chosenTestVariantForTest:testName];
    if (!chosenVariantIndex)
    {
        chosenVariantIndex = [ABTests chooseTestVariantForTest:testName fromVariants:variants];
    }
    ABVariant *variant = [variants objectAtIndex:[chosenVariantIndex intValue]];

    void ( ^performVariantCode)(void) = variant.executionBlock;
    performVariantCode();

    id <ABTestsDelegate> aDelegate = [[ABTests sharedInstance] delegate];
    if (aDelegate)
    {
        if ([aDelegate respondsToSelector:@selector(abtest:didDisplayVariant:)])
        {
            [aDelegate performSelector:@selector(abtest:didDisplayVariant:)withObject:testName withObject:variant.name];
        }
    }
}

+ (void)performAdditionalCode:( void ( ^)(void) )executionBlock forTestWithName:(NSString *)testName usingVariant:(NSString *)variantName
{
    NSString *chosenVariantName = [[NSUserDefaults standardUserDefaults] objectForKey:[testName stringByAppendingFormat:CHOSEN_VARIANT_NAME_SUFFIX]];

    if ([variantName isEqualToString:chosenVariantName])
    {
        executionBlock();
    }
}

#pragma mark -
#pragma mark Reaching test goals
+ (void)goalReachedForTest:(NSString *)testName
{
    id <ABTestsDelegate> aDelegate = [[ABTests sharedInstance] delegate];
    if (aDelegate)
    {
        if ([aDelegate respondsToSelector:@selector(abtest:didReachGoalUsingVariant:)])
        {
            NSString *variantName = [[NSUserDefaults standardUserDefaults] objectForKey:[testName stringByAppendingFormat:CHOSEN_VARIANT_NAME_SUFFIX]];
            [aDelegate performSelector:@selector(abtest:didReachGoalUsingVariant:)withObject:testName withObject:variantName];
        }
    }
}

+ (void)intermediateGoalReached:(NSString *)goalName forTest:(NSString *)testName
{
    id <ABTestsDelegate> aDelegate = [[ABTests sharedInstance] delegate];
    if (aDelegate)
    {
        if ([aDelegate respondsToSelector:@selector(abtest:didReachIntermediateGoal:usingVariant:)])
        {
            NSString *variantName = [[NSUserDefaults standardUserDefaults] objectForKey:[testName stringByAppendingFormat:CHOSEN_VARIANT_NAME_SUFFIX]];
            [aDelegate abtest:testName didReachIntermediateGoal:goalName usingVariant:variantName];
        }
    }
}

#pragma mark -
#pragma mark Choosing test variants
+ (NSNumber *)chooseTestVariantForTest:(NSString *)testName fromVariants:(NSArray *)variants
{
    NSInteger option = arc4random() % [variants count];
    NSNumber *testVariantIndex = [NSNumber numberWithInt:option];
    ABVariant *variant = [variants objectAtIndex:[testVariantIndex intValue]];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:testVariantIndex forKey:[testName stringByAppendingFormat:CHOSEN_VARIANT_INDEX_SUFFIX]];
    [defaults setObject:variant.name forKey:[testName stringByAppendingFormat:CHOSEN_VARIANT_NAME_SUFFIX]];
    [defaults synchronize];

    id <ABTestsDelegate> aDelegate = [[ABTests sharedInstance] delegate];
    if (aDelegate)
    {
        if ([aDelegate respondsToSelector:@selector(abtest:didSelectVariant:)])
        {
            [aDelegate performSelector:@selector(abtest:didSelectVariant:)withObject:testName withObject:variant.name];
        }
    }

    return testVariantIndex;
}

+ (NSNumber *)chosenTestVariantForTest:(NSString *)testName
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSNumber *chosenTestVariantIndex = [defaults objectForKey:[testName stringByAppendingFormat:CHOSEN_VARIANT_INDEX_SUFFIX]];
    return chosenTestVariantIndex;
}

#pragma mark -
#pragma mark Singleton stuff to keep delegate
+ (void)setDelegate:(id <ABTestsDelegate>)delegate
{
    [[ABTests sharedInstance] setDelegate:delegate];
}

+ (id)sharedInstance
{
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
                      sharedInstance = [[self alloc] init];
                  }
                  );
    return sharedInstance;
}

@end