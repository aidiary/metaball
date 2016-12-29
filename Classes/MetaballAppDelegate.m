//
//  MetaballAppDelegate.m
//  Metaball
//
//  Created by mori on 09/02/19.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "MetaballAppDelegate.h"
#import "MetaballViewController.h"

@implementation MetaballAppDelegate

@synthesize window;
@synthesize viewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch    
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
