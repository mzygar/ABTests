//
//  ABTestsTests.m
//  ABTestsTests
//
//  Created by Michał Zygar on 13.02.2013.
//  Copyright (c) 2013 Michal Zygar. All rights reserved.
//

#import "ABTestsTests.h"
#import "OCMock/OCMock.h"

//Declarations added for testing purposes
@interface ABTests ()
+ (NSNumber *)chooseTestVariantForTest:(NSString *)testName fromVariants:(NSArray *)variants;
+ (NSNumber *)chosenTestVariantForTest:(NSString *)testName;
+ (void)performAdditionalCode:( void ( ^)(void) )executionBlock forTestWithName:(NSString *)testName usingVariant:(NSString *)variantName;
@end


@implementation ABTestsTests

- (void)setUp
{
    [super setUp];
    delegate = [OCMockObject mockForProtocol:@protocol(ABTestsDelegate)];
    [ABTests setDelegate:delegate];
}

- (void)tearDown
{
    // Tear-down code here.

    [super tearDown];
}

- (void)testIfNotifyingDelegateOfDisplayedVariantWorks
{
    [[delegate expect] abtest:[OCMArg any] didDisplayVariant:[OCMArg any]];

    [ABTests testWithName:@"test" A: ^{
     }
     B: ^{
     }
    ];
    [delegate verify];
}

- (void)testIfNotifyingDelegateOfChosenVariantWorks
{
    [[delegate expect] abtest:[OCMArg any] didSelectVariant:[OCMArg any]];
    NSArray *variants = [NSArray arrayWithObjects:[ABVariant variantWithName:nil andBlock:NULL], [ABVariant variantWithName:nil andBlock:NULL], nil];
    [ABTests chooseTestVariantForTest:@"aa" fromVariants:variants];
    [delegate verify];
}

- (void)testIfNotifyingDelegateOfReachingGoalWorks
{
    [[delegate expect] abtest:[OCMArg any] didDisplayVariant:[OCMArg any]];

    [[delegate expect] abtest:[OCMArg any] didReachGoalUsingVariant:[OCMArg any]];
    [ABTests testWithName:@"test" A: ^{
     }
     B: ^{
     }
    ];
    [ABTests goalReachedForTest:@"test"];

    [delegate verify];
}

- (void)testIfNotifyingDelegateOfReachingIntermediateGoalWorks
{
    [[delegate expect] abtest:[OCMArg any] didDisplayVariant:[OCMArg any]];
    [[delegate expect] abtest:[OCMArg any] didReachIntermediateGoal:[OCMArg any] usingVariant:[OCMArg any]];
    [ABTests testWithName:@"test" A: ^{
     }
     B: ^{
     }
    ];
    [ABTests intermediateGoalReached:@"" forTest:@"test"];

    [delegate verify];
}

@end