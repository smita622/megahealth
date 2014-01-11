//
//  MGHTimelineViewController.m
//  MegaHealth
//
//  Created by Zac Altman on 10/01/2014.
//  Copyright (c) 2014 MegaHealth. All rights reserved.
//

#import "MGHTimelineViewController.h"
#import "MGHWorkout.h"

@interface MGHTimelineViewController ()

@property (nonatomic, strong) NSMutableOrderedSet *orderedDates;
@property (nonatomic, strong) NSMutableDictionary *dayDictionary;

@end

@implementation MGHTimelineViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
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
        }

        NSLog(@"timeline: %@", _dayDictionary);
        [self.tableView reloadData];
    }];
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
//TODO: Is this reallllly the most efficient thing?
    [self fetchData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    static NSString *CellIdentifier = @"Cell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    NSArray *array = [_dayDictionary objectForKey:[_orderedDates objectAtIndex:indexPath.section]];
    MGHWorkout *workout = [array objectAtIndex:indexPath.row];
    [[cell textLabel] setText:[NSString stringWithFormat:@"%@", [workout date_time]]];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [_orderedDates objectAtIndex:section];
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
