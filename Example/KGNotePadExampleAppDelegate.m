//
//  KGNotePadExampleAppDelegate.m
//  KGNotePadExample
//
//  Created by David Keegan on 2/23/13.
//  Copyright (c) 2013 David Keegan. All rights reserved.
//

#import "KGNotePadExampleAppDelegate.h"
#import "KGNotePadExampleViewController.h"

@implementation KGNotePadExampleAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = [[KGNotePadExampleViewController alloc] initWithNibName:nil bundle:nil];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
