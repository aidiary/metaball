//
//  MetaballAppDelegate.h
//  Metaball
//
//  Created by mori on 09/02/19.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MetaballViewController;

@interface MetaballAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    MetaballViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet MetaballViewController *viewController;

@end

