//
//  MGHDateFormatter.m
//  MegaHealth
//
//  Created by Zac Altman on 11/01/2014.
//  Copyright (c) 2014 MegaHealth. All rights reserved.
//

#import "MGHDateFormatter.h"

@implementation MGHDateFormatter

+ (NSDateFormatter *) dayFormat {
    static NSDateFormatter *dayFormat = nil;
    if (!dayFormat) {
        dayFormat = [[NSDateFormatter alloc] init];
        [dayFormat setDateFormat:@"yyyy-MM-dd"];
    }
    return dayFormat;
}

+ (NSDateFormatter *) hourFormat {
    static NSDateFormatter *hourFormat = nil;
    if (!hourFormat) {
        hourFormat = [[NSDateFormatter alloc] init];
        [hourFormat setDateFormat:@"H:mm a"];
    }
    return hourFormat;
}

@end
