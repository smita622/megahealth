//
//  MGHTimelineViewController.m
//  MegaHealth
//
//  Created by Zac Altman on 10/01/2014.
//  Copyright (c) 2014 MegaHealth. All rights reserved.
//

#import "MGHTimelineViewController.h"
#import "MGHWorkout.h"
#import "SORelativeDateTransformer/SORelativeDateTransformer.h"

#import "MGHTimelineCell.h"
#import "MGHNextWorkoutCell.h"

#import "MGHSettingsViewController.h"

@interface MGHTimelineViewController ()

@property (nonatomic, strong) UIImageView *backgroundImage;
@property (nonatomic, strong) UIView *backgroundView;

@property (nonatomic, strong) NSMutableOrderedSet *orderedDates;
@property (nonatomic, strong) NSMutableDictionary *dayDictionary;
@property NSIndexPath *nextIndexPath;

@property (nonatomic, strong) UIView *baseBar;

@end

@implementation MGHTimelineViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _orderedDates = [NSMutableOrderedSet new];
        _dayDictionary = [NSMutableDictionary new];
    }
    return self;
}

- (void) fetchData {
    PFQuery *workoutQuery = [MGHWorkout query];
    [workoutQuery setCachePolicy:kPFCachePolicyCacheThenNetwork];
    [workoutQuery whereKey:@"user" equalTo:[PFUser currentUser]];
    [workoutQuery addAscendingOrder:@"date_time"];
    [workoutQuery includeKey:@"content"];
    [workoutQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        // Reset
        _orderedDates = [NSMutableOrderedSet new];
        _dayDictionary = [NSMutableDictionary new];

        for (MGHWorkout *workout in objects) {
            
            NSString *dayString = [workout dayString];
            NSMutableArray *array = [_dayDictionary objectForKey:dayString];
            if (!array) array = [NSMutableArray new];
            [array addObject:workout];
            [_dayDictionary setObject:array forKey:dayString];
            
            [_orderedDates addObject:dayString];
            
            if (!_nextIndexPath && [workout.type isEqualToString:@"workout"] && [workout.date_time timeIntervalSinceNow] > 0) {
                _nextIndexPath = [NSIndexPath indexPathForRow:[array indexOfObject:workout] inSection:[_orderedDates indexOfObject:dayString]];
            }

        }

        NSLog(@"timeline: %@", _dayDictionary);
        [self.tableView reloadData];
        [self.tableView scrollToRowAtIndexPath:_nextIndexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
    }];
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
//TODO: Is this reallllly the most efficient thing?
    [self fetchData];
}

- (void) scrollViewDidScroll:(UIScrollView *)scrollView {
    
    float tableViewHeight = [self.tableView sizeThatFits:CGSizeMake(self.view.frame.size.width, FLT_MAX)].height - self.tableView.frame.size.height;
    float percentage = self.tableView.contentOffset.y / tableViewHeight;
    if (percentage < 0.0f) percentage = 0.0f;
    if (percentage > 1.0f) percentage = 1.0f;
    
    CGRect backgroundImageFrame = _backgroundImage.frame;
    float additionalPixels = self.view.frame.size.height - backgroundImageFrame.size.height;
    float offset = (percentage * additionalPixels);
    backgroundImageFrame.origin.y = offset;
    [_backgroundImage setFrame:backgroundImageFrame];
    
    
    [_baseBar setFrame:CGRectMake(0, self.view.frame.size.height - 64.0f + self.tableView.contentOffset.y, self.view.frame.size.width, 64.0f)];

    
//    NSLog(@"offset: %f", off)
//    NSLog(@"DID SCROLL = %@", NSStringFromCGPoint(scrollView.contentOffset));
//    [scrollView layoutIfNeeded];
//    NSLog(@"DID SIZE = %@", NSStringFromCGSize([self.tableView sizeThatFits:CGSizeMake(self.view.frame.size.width, FLT_MAX)]));

}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"indexpath.1 = %@", indexPath);
    NSLog(@"indexpath.2 = %@", _nextIndexPath);
    if (indexPath.section == _nextIndexPath.section && indexPath.row == _nextIndexPath.row) {
        return 300.0f;
    };
    
    NSArray *array = [_dayDictionary objectForKey:[_orderedDates objectAtIndex:indexPath.section]];
    MGHWorkout *workout = [array objectAtIndex:indexPath.row];
    return ([workout.type isEqualToString:@"workout"] ? 80.0f : 110.0f);
}

- (void) settingsAction {
    MGHSettingsViewController *settingsViewController = [MGHSettingsViewController new];
    [self presentViewController:settingsViewController animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _baseBar = [UIView new];
    [_baseBar setFrame:CGRectMake(0, self.view.frame.size.height - 64.0f, self.view.frame.size.width, 64.0f)];
    [_baseBar setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleTopMargin];
    [_baseBar setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.5f]];
    [self.view addSubview:_baseBar];
    
    UIButton *settingsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [settingsButton setFrame:CGRectMake(_baseBar.frame.size.width - 24.0f - 24.0f, 20.0f, 24.0f, 24.0f)];
    [settingsButton addTarget:self action:@selector(settingsAction) forControlEvents:UIControlEventTouchUpInside];
    [settingsButton setImage:[UIImage imageNamed:@"settingsIcon"] forState:UIControlStateNormal];
    [_baseBar addSubview:settingsButton];
    
    UIImage *rechargeLogo = [UIImage imageNamed:@"rechargeLogo"];
    UIImageView *rechargeImageView = [[UIImageView alloc] initWithImage:rechargeLogo];
    [rechargeImageView setFrame:CGRectMake(21.0f, 23.0f, 11.0f, 22.0f)];
    [_baseBar addSubview:rechargeImageView];
    
    UILabel *rechargeLabel = [[UILabel alloc] initWithFrame:CGRectMake(44.0f, 1.0f, _baseBar.frame.size.width - 90.0f, _baseBar.frame.size.height)];
    [rechargeLabel setFont:[UIFont fontWithName:FONT_PRIMARY_MINI size:16.0f]];
    [rechargeLabel setTextColor:[UIColor whiteColor]];
    [rechargeLabel setText:@"200"];
    [_baseBar addSubview:rechargeLabel];
    
    _backgroundView = [UIView new];
    [_backgroundView setBackgroundColor:[UIColor blueColor]];
    self.tableView.backgroundView = _backgroundView;

    UIImage *bgImage = [UIImage imageNamed:@"mainBackground.jpg"];
    _backgroundImage = [[UIImageView alloc] initWithImage:bgImage];
    CGSize imageSize = bgImage.size;
    [_backgroundImage setFrame:CGRectMake(0, 0, self.view.frame.size.width, imageSize.height*2)];
    [_backgroundImage setContentMode:UIViewContentModeScaleAspectFill];
    [_backgroundImage setBackgroundColor:[UIColor colorWithPatternImage:bgImage]];
    
    [_backgroundView addSubview:_backgroundImage];
    
    UIView *lineView = [UIView new];
    [lineView setBackgroundColor:[[UIColor whiteColor] colorWithAlphaComponent:0.15f]];
    [lineView setFrame:CGRectMake(84.0f, 0.0f, 2.0f, _backgroundView.frame.size.height)];
    [lineView setAutoresizingMask:(UIViewAutoresizingFlexibleHeight)];
    [_backgroundView addSubview:lineView];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [_orderedDates count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *array = [_dayDictionary objectForKey:[_orderedDates objectAtIndex:section]];
    return array.count;
}

/*
 
 Section out by day:
 
 
 Cell Types:
 1. Workouts
 2. Calendar Type
 3.
 
 */

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *WorkoutCellIdentifier = @"WorkoutCell";
    static NSString *NextWorkoutCellIdentifier = @"NextWorkoutCell";

    NSArray *array = [_dayDictionary objectForKey:[_orderedDates objectAtIndex:indexPath.section]];
    MGHWorkout *workout = [array objectAtIndex:indexPath.row];

    if (indexPath.section == _nextIndexPath.section && indexPath.row == _nextIndexPath.row) {
        MGHNextWorkoutCell *cell = [tableView dequeueReusableCellWithIdentifier:NextWorkoutCellIdentifier];
        
        if (!cell) {
            cell = [[MGHNextWorkoutCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NextWorkoutCellIdentifier];
        }
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell setWorkout:workout];
        
        return cell;
    }
    
    MGHTimelineCell *cell = [tableView dequeueReusableCellWithIdentifier:WorkoutCellIdentifier];
    
    if (!cell) {
        cell = [[MGHTimelineCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:WorkoutCellIdentifier];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell setWorkout:workout];
//    [cell setNeedsLayout];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSArray *array = [_dayDictionary objectForKey:[_orderedDates objectAtIndex:section]];
    MGHWorkout *workout = [array objectAtIndex:0];
    return [[SORelativeDateTransformer registeredTransformer] transformedValue:workout.date_time];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50.0f;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [UIView new];
    [headerView setFrame:CGRectMake(0, 0, self.view.frame.size.width, 60.0f)];
    [headerView setBackgroundColor:[UIColor clearColor]];
    
    UILabel *headerLabel = [UILabel new];
    [headerLabel setFrame:CGRectMake(96.0f, 0.0f, headerView.frame.size.width - 96.0f, headerView.frame.size.height)];
    [headerLabel setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
    [headerLabel setBackgroundColor:[UIColor clearColor]];
    [headerLabel setText:[[self tableView:tableView titleForHeaderInSection:section] uppercaseString]];
    [headerLabel setFont:[UIFont fontWithName:FONT_PRIMARY size:14.0f]];
    [headerLabel setTextColor:[UIColor whiteColor]];
    [headerView addSubview:headerLabel];
    
    return headerView;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
