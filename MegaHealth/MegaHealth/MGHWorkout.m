//
//  MGHWorkout.m
//  MegaHealth
//
//  Created by Zac Altman on 10/01/2014.
//  Copyright (c) 2014 MegaHealth. All rights reserved.
//

#import "MGHWorkout.h"
#import <Parse/PFObject+Subclass.h>

@implementation MGHWorkout

@dynamic date_time;
@dynamic user;
@dynamic content;
@dynamic complete;

+ (NSString *)parseClassName {
    return @"workout";
}

@end
