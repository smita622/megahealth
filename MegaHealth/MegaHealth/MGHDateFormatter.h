//
//  MGHDateFormatter.h
//  MegaHealth
//
//  Created by Zac Altman on 11/01/2014.
//  Copyright (c) 2014 MegaHealth. All rights reserved.
//

#import <Parse/Parse.h>

@interface MGHDateFormatter : PFObject

+ (NSDateFormatter *)dayFormat;
+ (NSDateFormatter *)readableDayFormat;

@end
