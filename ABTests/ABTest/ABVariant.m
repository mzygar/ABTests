//
//  ABVariant.m
//  ABTests
//
//  Created by Michał Zygar on 13.02.2013.
//  Copyright (c) 2013 Michal Zygar. All rights reserved.
//

#import "ABVariant.h"


@implementation ABVariant

/**
 * Create autoreleased variant
 *
 * @param variantName
 * @param block
 * @returns autoreleased variant with given name and execution block
 */
+ (id)variantWithName:(NSString *)variantName andBlock:( void ( ^)(void) )block
{
    NSAssert(variantName != nil, @"Variant name must be defined");
    ABVariant *variant = [[ABVariant alloc] init];
    variant.executionBlock = block;
    variant.name = variantName;
    return [variant autorelease];
}

@end