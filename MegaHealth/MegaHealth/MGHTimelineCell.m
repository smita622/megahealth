//
//  MGHTimelineCell.m
//  MegaHealth
//
//  Created by Zac Altman on 11/01/2014.
//  Copyright (c) 2014 MegaHealth. All rights reserved.
//

#import "MGHTimelineCell.h"
#import "MGHDateFormatter.h"

@interface MGHTimelineCell()

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UIView *dotView;
@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UIView *detailView;

@end

#define CELL_PADDING 9.0f
#define DOT_SIZE 24.0f

@implementation MGHTimelineCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        [self setup];
    }
    return self;
}

#define COLOR_CELL_GREEN [UIColor colorWithRed:0.686 green:0.855 blue:0.337 alpha:1.0]
#define COLOR_CELL_RED [UIColor colorWithRed:0.996 green:0.353 blue:0.251 alpha:1.0]
#define COLOR_CELL_BLUE [UIColor colorWithRed:0.353 green:0.655 blue:0.843 alpha:1.0]
#define COLOR_CELL_YELLOW [UIColor colorWithRed:0.98 green:0.757 blue:0.141 alpha:1.0]

- (void) setup {

    _detailView = [UIView new];
    [_detailView setFrame:CGRectMake(86.0f, CELL_PADDING, self.contentView.frame.size.width - 86.0f - CELL_PADDING*2, self.contentView.frame.size.height - CELL_PADDING * 2)];
    [_detailView setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
    [_detailView setBackgroundColor:[[UIColor whiteColor] colorWithAlphaComponent:0.1f]];
    [self.contentView addSubview:_detailView];

    _timeLabel = [UILabel new];
    [_timeLabel setBackgroundColor:[UIColor clearColor]];
    [_timeLabel setTextColor:[UIColor whiteColor]];
    [_timeLabel setTextAlignment:NSTextAlignmentRight];
    [_timeLabel setFont:[UIFont fontWithName:FONT_PRIMARY size:12.0f]];
    [_timeLabel setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
    [self.contentView addSubview:_timeLabel];

    _dotView = [UIView new];
    _dotView.layer.cornerRadius = (DOT_SIZE / 2);
    [_dotView setAutoresizingMask:(UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin)];
    [self.contentView addSubview:_dotView];
    
    _lineView = [UIView new];
    [_lineView setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
    [self.contentView addSubview:_lineView];
    
    [_lineView setFrame:CGRectMake(84.0f, CELL_PADDING, 2.0f, self.contentView.frame.size.height - CELL_PADDING * 2)];
    [_dotView setFrame:CGRectMake(85.0f - (DOT_SIZE / 2), (self.contentView.frame.size.height - DOT_SIZE) / 2, DOT_SIZE, DOT_SIZE)];
    [_timeLabel setFrame:CGRectMake(0, 0, 64.0f, self.contentView.frame.size.height)];

}

- (void) setWorkout:(MGHWorkout *)workout {
    _workout = workout;
    
    NSString *timeText = [[MGHDateFormatter hourFormat] stringFromDate:workout.date_time];
    [_timeLabel setText:timeText];
    
    // Red = calendar
    // Yello = easy
    // Blue = medium
    // Green = hard
    if ([[workout type] isEqualToString:@"calendar"]) {
        [_dotView setBackgroundColor:COLOR_CELL_RED];
        [_lineView setBackgroundColor:COLOR_CELL_RED];
    } else {
        switch ([[workout content] difficulty]) {
            case 1:
            case 2:
            case 3:
                [_dotView setBackgroundColor:COLOR_CELL_YELLOW];
                [_lineView setBackgroundColor:COLOR_CELL_YELLOW];
                break;

            case 4:
            case 5:
            case 6:
                [_dotView setBackgroundColor:COLOR_CELL_BLUE];
                [_lineView setBackgroundColor:COLOR_CELL_BLUE];
                break;

            case 7:
            case 8:
            case 9:
                [_dotView setBackgroundColor:COLOR_CELL_GREEN];
                [_lineView setBackgroundColor:COLOR_CELL_GREEN];
                break;

                
            default:
                [_dotView setBackgroundColor:[UIColor lightGrayColor]];
                [_lineView setBackgroundColor:[UIColor lightGrayColor]];
                break;
        }
    }
    
    
    [self layout];
}

- (void) layout {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
