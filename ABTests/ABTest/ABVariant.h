//
//  ABVariant.h
//  ABTests
//
//  Created by Michał Zygar on 13.02.2013.
//  Copyright (c) 2013 Michal Zygar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ABVariant : NSObject

@property (nonatomic, copy) void(^executionBlock)(void);
@property (nonatomic, retain) NSString* name;
@end
