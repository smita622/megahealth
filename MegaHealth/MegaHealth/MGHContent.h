//
//  MGHContent.h
//  MegaHealth
//
//  Created by Zac Altman on 10/01/2014.
//  Copyright (c) 2014 MegaHealth. All rights reserved.
//

#import <Parse/Parse.h>

@interface MGHContent : PFObject <PFSubclassing>

@property int difficulty;
@property (retain) NSString *url;
@property (retain) NSString *content_length;

+ (NSString *)parseClassName;

@end
