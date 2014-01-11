//
//  MGHWorkout.m
//  MegaHealth
//
//  Created by Zac Altman on 10/01/2014.
//  Copyright (c) 2014 MegaHealth. All rights reserved.
//

#import "MGHWorkout.h"
#import <Parse/PFObject+Subclass.h>
#import "MGHDateFormatter.h"

@implementation MGHWorkout

@dynamic date_time;
@dynamic user;
@dynamic content;
@dynamic complete;

+ (NSString *)parseClassName {
    return @"workout";
}

- (NSString *)dayString {
    return [[MGHDateFormatter dayFormat] stringFromDate:self.date_time];
}

@end
