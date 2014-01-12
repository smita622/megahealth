//
//  MGHNextWorkoutCell.m
//  MegaHealth
//
//  Created by Zac Altman on 11/01/2014.
//  Copyright (c) 2014 MegaHealth. All rights reserved.
//

#import "MGHNextWorkoutCell.h"
#import "SORelativeDateTransformer.h"

@interface MGHNextWorkoutCell()

@property (nonatomic, strong) UILabel *preTimeLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *postTimeLabel;

@end

@implementation MGHNextWorkoutCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setup];
    }
    return self;
}

- (void) setup {
    self.contentView.backgroundColor = [UIColor colorWithRed:0.067 green:0.067 blue:0.067 alpha:1.0];
    
    _preTimeLabel = [UILabel new];
    [_preTimeLabel setTextAlignment:NSTextAlignmentCenter];
    [_preTimeLabel setText:@"next recharge in"];
    [_preTimeLabel setFont:[UIFont fontWithName:FONT_PRIMARY size:36.0f]];
    [_preTimeLabel setFrame:CGRectMake(0, 20.0f, self.contentView.frame.size.width, 80.0f)];
    [_preTimeLabel setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [_preTimeLabel setTextColor:COLOR_CELL_YELLOW];
//    [_preTimeLabel setTextColor:[UIColor colorWithRed:0.067 green:0.067 blue:0.067 alpha:1.0]];
    [self.contentView addSubview:_preTimeLabel];
    
    _timeLabel = [UILabel new];
    [_timeLabel setTextAlignment:NSTextAlignmentCenter];
    [_timeLabel setFont:[UIFont fontWithName:FONT_SPECIAL size:120.0f]];
    [_timeLabel setFrame:CGRectMake(0, 80.0f, self.contentView.frame.size.width, 160.0f)];
    [_timeLabel setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [_timeLabel setTextColor:COLOR_CELL_YELLOW];
//    [_timeLabel setTextColor:[UIColor colorWithRed:0.067 green:0.067 blue:0.067 alpha:1.0]];
    [self.contentView addSubview:_timeLabel];
    
    _postTimeLabel = [UILabel new];
    [_postTimeLabel setTextAlignment:NSTextAlignmentCenter];
    [_postTimeLabel setText:@"minutes"];
    [_postTimeLabel setFont:[UIFont fontWithName:FONT_PRIMARY size:36.0f]];
    [_postTimeLabel setFrame:CGRectMake(0, 200.0f, self.contentView.frame.size.width, 80.0f)];
    [_postTimeLabel setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [_postTimeLabel setTextColor:COLOR_CELL_YELLOW];
//    [_postTimeLabel setTextColor:[UIColor colorWithRed:0.067 green:0.067 blue:0.067 alpha:1.0]];
    [self.contentView addSubview:_postTimeLabel];
}

- (void) setWorkout:(MGHWorkout *)workout {
    _workout = workout;
    
    int minutes = [[workout date_time] timeIntervalSinceNow] / 60.0f;
    [_timeLabel setText:[NSString stringWithFormat:@"%i", minutes]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
