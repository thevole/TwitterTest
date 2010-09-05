//
//  TwitterTestClientViewController.m
//  TwitterTestClient
//
//  Created by Martin Volerich on 9/5/10.
//  Copyright 2010 Bill Bear Technologies. All rights reserved.
//

#import "TwitterTestClientViewController.h"

@implementation TwitterTestClientViewController

@synthesize twitterEngine = twitterEngine_;


- (IBAction)startTwitter:(id)sender {
    
}


/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    twitterEngine_ = [[MGTwitterEngine alloc] initWithDelegate:self];
    BBAssert(twitterEngine_, @"No Twitter Engine");
    
}



/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [twitterEngine_ release], twitterEngine_ = nil;
    [super dealloc];
}

@end
