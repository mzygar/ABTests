//
//  ABAppDelegate.h
//  ABTests
//
//  Created by Michał Zygar on 13.02.2013.
//  Copyright (c) 2013 Michal Zygar. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ABViewController;

@interface ABAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ABViewController *viewController;

@end