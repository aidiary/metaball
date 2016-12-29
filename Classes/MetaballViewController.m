//
//  MetaballViewController.m
//  Metaball
//
//  Created by mori on 09/02/19.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "MetaballViewController.h"
#import "BitmapView.h"

@implementation MetaballViewController

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
    BitmapView *contentView = [[BitmapView alloc]
                               initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    contentView.backgroundColor = [UIColor blueColor];
    self.view = contentView;
    [contentView release];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
    [super dealloc];
}

@end
