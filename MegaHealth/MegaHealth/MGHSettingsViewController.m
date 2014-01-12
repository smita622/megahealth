//
//  MGHSettingsViewController.m
//  MegaHealth
//
//  Created by Zac Altman on 10/01/2014.
//  Copyright (c) 2014 MegaHealth. All rights reserved.
//

#import "MGHSettingsViewController.h"

@interface MGHSettingsViewController ()

@end

@implementation MGHSettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)doneAction:(id)sender {
    
    // Completed the initial setup:
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:D_FIRST_USE_COMPLETE];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    // And dismiss!
    if (self.navigationController) {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
