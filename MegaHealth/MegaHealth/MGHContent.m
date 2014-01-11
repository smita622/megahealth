//
//  MGHContent.m
//  MegaHealth
//
//  Created by Zac Altman on 10/01/2014.
//  Copyright (c) 2014 MegaHealth. All rights reserved.
//

#import "MGHContent.h"
#import <Parse/PFObject+Subclass.h>

@implementation MGHContent

@dynamic url;
@dynamic content_length;
@dynamic difficulty;

+ (NSString *)parseClassName {
    return @"content";
}

@end
