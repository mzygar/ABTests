//
//  ABViewController.h
//  ABTests
//
//  Created by Michał Zygar on 13.02.2013.
//  Copyright (c) 2013 Michal Zygar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ABTests.h"
@interface ABViewController : UIViewController <ABTestsDelegate>

@property (retain, nonatomic) IBOutlet UILabel *statusLbl;
@property (retain, nonatomic) IBOutlet UIButton *mainActionBtn;
- (IBAction)mainActionTouched:(id)sender;
- (IBAction)secondaryActionTouched:(id)sender;
@end