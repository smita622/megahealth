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
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *locationLabel;

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

    _titleLabel = [UILabel new];
    [_titleLabel setBackgroundColor:[UIColor clearColor]];
    [_titleLabel setTextAlignment:NSTextAlignmentLeft];
    [_titleLabel setNumberOfLines:0];
    [_titleLabel setFont:[UIFont fontWithName:FONT_PRIMARY_MINI size:18.0f]];
    [_titleLabel setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
    [_titleLabel setFrame:CGRectMake(20.0f, 0.0f, _detailView.frame.size.width - 32.0f, _detailView.frame.size.height)];
    [_detailView addSubview:_titleLabel];

    _dotView = [UIView new];
    _dotView.layer.cornerRadius = (DOT_SIZE / 2);
    _dotView.layer.borderColor = [UIColor whiteColor].CGColor;
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
    
    UIColor *primaryColor = [UIColor lightGrayColor];
    
    if ([[workout type] isEqualToString:@"calendar"]) {
        primaryColor = COLOR_CELL_RED;
        [_titleLabel setText:workout.title];
    } else {
        
        if ([[workout date_time] timeIntervalSinceNow] > 0) {
            _dotView.layer.borderWidth = 1.0f;
        } else {
            _dotView.layer.borderWidth = 0.0f;
        }
        
        // If content, then content.
        if ([workout content]) {
            [_titleLabel setText:workout.title];
        } else {
            [_titleLabel setText:@"RECHARGE"];
        }

        switch ([[workout content] difficulty]) {
            case 1:
            case 2:
            case 3:
                primaryColor = COLOR_CELL_YELLOW;
                break;

            case 4:
            case 5:
            case 6:
                primaryColor = COLOR_CELL_BLUE;
                break;

            case 7:
            case 8:
            case 9:
                primaryColor = COLOR_CELL_GREEN;
                break;
                
            default:
                break;
        }
    }
    
    [_dotView setBackgroundColor:primaryColor];
    [_lineView setBackgroundColor:primaryColor];
    [_titleLabel setTextColor:primaryColor];
    
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
