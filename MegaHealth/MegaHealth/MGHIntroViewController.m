//
//  MGHIntroViewController.m
//  MegaHealth
//
//  Created by Zac Altman on 10/01/2014.
//  Copyright (c) 2014 MegaHealth. All rights reserved.
//

#import "MGHIntroViewController.h"
#import "MGHSettingsViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface MGHIntroViewController ()

@property (weak, nonatomic) IBOutlet UIView *logoView;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UILabel *logoLabel;
@end

@implementation MGHIntroViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Styling:
    
    _logoView.layer.cornerRadius = _logoView.frame.size.height / 2;
    _logoView.layer.borderWidth = 0.5f;
    _logoView.layer.borderColor = [[UIColor whiteColor] colorWithAlphaComponent:0.4f].CGColor;
    [[_startButton titleLabel] setFont:[UIFont fontWithName:FONT_PRIMARY size:_startButton.titleLabel.font.pointSize]];
    [_logoLabel setFont:[UIFont fontWithName:FONT_PRIMARY size:_logoLabel.font.pointSize]];
    [_startButton setTitleColor:COLOR_PRIMARY forState:UIControlStateNormal];
    _logoLabel.layer.shadowRadius = 2.0f;
    _logoLabel.layer.shadowOffset = CGSizeMake(0.0f, 2.0f);
    _logoLabel.layer.shadowColor = [[UIColor blackColor] colorWithAlphaComponent:0.6f].CGColor;
_logoLabel.layer.shadowOpacity = 1.0;
    //    [_startButton setShowsTouchWhenHighlighted:NO];
}

- (IBAction)joinAction:(id)sender {
    MGHSettingsViewController *settingsViewController = [MGHSettingsViewController new];
    // Something to set the value.
    [self.navigationController pushViewController:settingsViewController animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
