//
//  TwitterTestClientViewController.m
//  TwitterTestClient
//
//  Created by Martin Volerich on 9/5/10.
//  Copyright 2010 Bill Bear Technologies. All rights reserved.
//

#import "TwitterTestClientViewController.h"
#import <OAuthConsumer.h>

#define kConsumerKey        @"PRHtBdH4IAw2wqeS9PgEg"
#define kConsumerSecret     @"d78HSniXbqQzSKweFi3CKFmxy9MSpo2LEkbB5aUY0"

@implementation TwitterTestClientViewController

@synthesize twitterEngine = twitterEngine_;
@synthesize requestToken = requestToken_;
@synthesize authorizeButton;


- (IBAction)authorizeToken:(id)sender {
    
}

- (IBAction)requestToken:(id)sender {
    OAConsumer *consumer = [[OAConsumer alloc]
                            initWithKey:kConsumerKey secret:kConsumerSecret];
    NSURL *requestURL = [NSURL URLWithString:@"https://api.twitter.com/oauth/request_token"];
    
    OAMutableURLRequest *request = [[OAMutableURLRequest alloc]
                                    initWithURL:requestURL
                                        consumer:consumer
                                        token:nil
                                        realm:nil
                                        signatureProvider:nil];
    [consumer release];
    [request setHTTPMethod:@"POST"];
    
    OADataFetcher *fetcher = [[OADataFetcher alloc] init];
    [fetcher fetchDataWithRequest:request
                         delegate:self didFinishSelector:@selector(requestTokenTicket:didFinishWithData:)
                  didFailSelector:@selector(requestTokenTicket:didFailWithError:)];
    [request release];
    [fetcher release];
}

- (void)requestTokenTicket:(OAServiceTicket *)ticket didFinishWithData:(NSData *)data {
    if (ticket.didSucceed) {
        NSString *responseBody = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        requestToken_ = [[OAToken alloc] initWithHTTPResponseBody:responseBody];
        [responseBody release];
        DLog(@"RequestToken: %@ secret: %@", self.requestToken.key, self.requestToken.secret);
        self.authorizeButton.enabled = YES;
    }
}

- (void)requestTokenTicket:(OAServiceTicket *)ticket didFailWithError:(NSError *)error {
    DLog(@"Request token error: %@", [error localizedDescription]);
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
    self.authorizeButton = nil;
}


- (void)dealloc {
    [twitterEngine_ release], twitterEngine_ = nil;    
    [requestToken_ release], requestToken_ = nil;    
    [authorizeButton release], authorizeButton = nil;
    
    [super dealloc];
}

#pragma mark -
#pragma mark MGTwitterEngineDelegate methods

- (void)requestSucceeded:(NSString *)connectionIdentifier {
    
}

- (void)requestFailed:(NSString *)connectionIdentifier withError:(NSError *)error {
    
}

@end
