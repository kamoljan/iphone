//
//  navBasedAppDelegate.m
//  navBased
//
//  Created by yuriy on 6/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "navBasedAppDelegate.h"
#import "RootViewController.h"
#import "changeFilter.h"
#import	 "AdPostingForm.h"
#import "JSON.h"


@implementation navBasedAppDelegate

@synthesize window;
@synthesize navigationController;
@synthesize adId, searchResults,searchFilter, needToRefresh;


-(void)someFunction
{
	NSLog(@"The app delegate method is called");
}

-(IBAction) changeFilter
{
	/*
	 if (self.changeFilterController == nil) {
	 changeFilter *changeFilterCont = [[changeFilter alloc] 
	 initWithNibName:nil bundle:[NSBundle mainBundle]];
	 self.changeFilterController = changeFilterCont;
	 [changeFilterCont release];		
	 }
	 [self.navigationController pushViewController:self.changeFilterController animated:YES];
	 
	 */
	
		changeFilter *changFilterController = [[changeFilter alloc] initWithNibName:nil
																				  bundle:nil];
		[self.navigationController pushViewController:changFilterController animated:YES];
		[changFilterController release];	
}

-(IBAction) iyoAdForm
{
	AdPostingForm *adPostController = [[AdPostingForm alloc] initWithNibName:nil 
																	  bundle:nil];
	[self.navigationController pushViewController:adPostController animated:YES];
	[adPostController release];
}

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after application launch.
    // Add the navigation controller's view to the window and display.
    [self.window addSubview:navigationController.view];
    [self.window makeKeyAndVisible];
	adId = [[NSString alloc] init];
	searchResults = [[NSMutableArray alloc] init];
	needToRefresh = YES;
	
	// Initilaising filter with default values
	searchFilter = [[NSMutableDictionary alloc] init];
	[searchFilter setObject:@"" forKey:@"query"];
	[searchFilter setObject:@"0" forKey:@"category_id"];
	[searchFilter setObject:@"0" forKey:@"region_id"];
	[searchFilter setObject:@"0" forKey:@"start"];
	[searchFilter setObject:@"11" forKey:@"limit"];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
//	[ release];
	[searchResults release];
	[navigationController release];
	[searchFilter release];
	[adId autorelease];
	[window release];
	[super dealloc];
}


@end

