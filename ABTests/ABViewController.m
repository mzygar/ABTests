//
//  ABViewController.m
//  ABTests
//
//  Created by Michał Zygar on 13.02.2013.
//  Copyright (c) 2013 Michal Zygar. All rights reserved.
//

#import "ABViewController.h"


@interface ABViewController ()

@end

@implementation ABViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [ABTests setDelegate:self];
    [ABTests testWithName:@"main action name" A: ^{
         [self.mainActionBtn setTitle:@"This is A" forState:UIControlStateNormal];
     }
     B: ^{
         [self.mainActionBtn setTitle:@"This is B" forState:UIControlStateNormal];
     }
    ];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [_mainActionBtn release];
    [_statusLbl release];
    [super dealloc];
}

#pragma mark -
#pragma mark ABTests delegate

- (void)abtest:(NSString *)testName didDisplayVariant:(NSString *)variantName
{
    NSLog(@"displaying %@ in current variant: %@", testName, variantName);
}

- (void)abtest:(NSString *)testName didReachGoalUsingVariant:(NSString *)variantName
{
    NSLog(@"%@ reached main goal in current variant: %@", testName, variantName);
}

- (void)abtest:(NSString *)testName didReachIntermediateGoal:(NSString *)goalName usingVariant:(NSString *)variantName
{
    NSLog(@"%@ reached intermediate goal- %@. while in variant named: %@", testName, goalName, variantName);
}

- (void)abtest:(NSString *)testName didSelectVariant:(NSString *)variantName
{
    NSLog(@"%@ got variant named %@", testName, variantName);
}

#pragma mark -
#pragma mark Actions
- (IBAction)mainActionTouched:(id)sender
{
    [ABTests goalReachedForTest:@"main action name"];
    [ABTests performAdditionalCode: ^{
         [self.statusLbl setText:@"This will only work in A"];
     }
     forTestWithName:@"main action name" usingVariant:@"A"];
}

- (IBAction)secondaryActionTouched:(id)sender
{
    [ABTests intermediateGoalReached:@"secondary action" forTest:@"main action name"];
    [ABTests performAdditionalCode: ^{
         [self.statusLbl setText:@"This will only work in B"];
     }
     forTestWithName:@"main action name" usingVariant:@"B"];
}

@end