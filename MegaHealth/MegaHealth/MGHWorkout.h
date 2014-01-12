//
//  MGHWorkout.h
//  MegaHealth
//
//  Created by Zac Altman on 10/01/2014.
//  Copyright (c) 2014 MegaHealth. All rights reserved.
//

#import <Parse/Parse.h>
#import "MGHContent.h"

@interface MGHWorkout : PFObject <PFSubclassing>

@property (retain) MGHContent *content;
@property (retain) PFUser *user;
@property BOOL complete;
@property (retain) NSDate *date_time;
@property (retain) NSDate *end_date_time;
@property (retain) NSString *type;
@property (retain) NSString *title;

+ (NSString *)parseClassName;
- (NSString *)dayString;

@end
