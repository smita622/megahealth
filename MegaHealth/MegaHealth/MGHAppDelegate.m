//
//  MGHAppDelegate.m
//  MegaHealth
//
//  Created by Zac Altman on 10/01/2014.
//  Copyright (c) 2014 MegaHealth. All rights reserved.
//

#import "MGHAppDelegate.h"

#import "MGHContent.h"
#import "MGHWorkout.h"

#import "MGHTimelineViewController.h"
#import "MGHIntroViewController.h"
#import "MGHSettingsViewController.h"

@implementation MGHAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];

    // Parse subclasses
    [MGHContent registerSubclass];
    [MGHWorkout registerSubclass];

    // Basic Parse Setup:
    [Parse setApplicationId:@"g9bHtEJNj4FoGlAIL5K9JvSXjvtw0DaAqS3zqLZt"
                  clientKey:@"73SmTxMF72wRBYaflkcNhP1SCyQq6CHPdaxW0qOg"];
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    [PFUser enableAutomaticUser];
    [[PFUser currentUser] saveInBackground];
    
    // Always load this underneath - it's our 'main' section
    MGHTimelineViewController *timelineViewController = [MGHTimelineViewController new];
    [self.window setRootViewController:timelineViewController];
    
    // Check if 'first use' complete:
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (![defaults objectForKey:D_FIRST_USE_COMPLETE]) {
        MGHIntroViewController *introViewController = [MGHIntroViewController new];

        UINavigationController *navigationController = [UINavigationController new];
        [navigationController setNavigationBarHidden:YES];
        
        // Remove the swipe option:
        if ([navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
            navigationController.interactivePopGestureRecognizer.enabled = NO;
        }
        [navigationController setViewControllers:@[introViewController]];
        
        [timelineViewController presentViewController:navigationController animated:NO completion:nil];
    }
    
    UILocalNotification *localNotification = [UILocalNotification new];
    [localNotification setFireDate:[NSDate dateWithTimeIntervalSinceNow:15]];
    [localNotification setAlertBody:@"Time to Recharge!"];
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    
    // Check if workout time:
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
