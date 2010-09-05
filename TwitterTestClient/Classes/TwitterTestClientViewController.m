//
//  TwitterTestClientViewController.m
//  TwitterTestClient
//
//  Created by Martin Volerich on 9/5/10.
//  Copyright 2010 Bill Bear Technologies. All rights reserved.
//

#import "TwitterTestClientViewController.h"
#import "AuthorizeViewController.h"
#import <OAuthConsumer.h>

#define kConsumerKey        @"PRHtBdH4IAw2wqeS9PgEg"
#define kConsumerSecret     @"d78HSniXbqQzSKweFi3CKFmxy9MSpo2LEkbB5aUY0"

@implementation TwitterTestClientViewController

@synthesize twitterEngine = twitterEngine_;
@synthesize requestToken = requestToken_;
@synthesize authorizationToken = authorizationToken_;
@synthesize accessToken = accessToken_;
@synthesize authorizeButton;
@synthesize testButton;
@synthesize statusLabel;


- (void)requestAccessToken {
    OAConsumer *consumer = [[OAConsumer alloc]
                            initWithKey:kConsumerKey secret:kConsumerSecret];
    NSURL *requestURL = [NSURL URLWithString:@"https://api.twitter.com/oauth/access_token"];
    
    OAMutableURLRequest *request = [[OAMutableURLRequest alloc]
                                    initWithURL:requestURL
                                    consumer:consumer
                                    token:self.authorizationToken
                                    realm:nil
                                    signatureProvider:nil];
    
    [consumer release];
    [request setHTTPMethod:@"POST"];
    
    OADataFetcher *fetcher = [[OADataFetcher alloc] init];
    [fetcher fetchDataWithRequest:request
                         delegate:self didFinishSelector:@selector(accessTokenTicket:didFinishWithData:)
                  didFailSelector:@selector(accessTokenTicket:didFailWithError:)];
    [request release];
    [fetcher release];
}

- (void)setAuthorizationToken:(OAToken *)token {
    if (token == authorizationToken_) {
        return;
    }
    [authorizationToken_ release];
    authorizationToken_ = [token retain];
    if (authorizing) {
        [self dismissModalViewControllerAnimated:YES];
        [self requestAccessToken];
    }
}

- (IBAction)testTweet:(id)sender {
    NSString *returnedString = [self.twitterEngine sendUpdate:@"@adamvole Just testing this code."];
    DLog(@"Returned string: %@", returnedString);
}

- (IBAction)authorizeToken:(id)sender {
    NSURL *authorizeURL = [NSURL URLWithString: 
                            [NSString stringWithFormat:@"https://api.twitter.com/oauth/authorize?oauth_token=%@", self.requestToken.key]];
    AuthorizeViewController *authorizeView = [[AuthorizeViewController alloc] initWithURL:authorizeURL];

    authorizing = YES;
    [self presentModalViewController:authorizeView animated:YES];
    
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
    
    [request setOAuthParameterName:@"oauth_callback" withValue:@"x-mvs://tokencallback"];
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

- (void)accessTokenTicket:(OAServiceTicket *)ticket didFinishWithData:(NSData *)data {
    if (ticket.didSucceed) {
        NSString *responseBody = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        accessToken_ = [[OAToken alloc] initWithHTTPResponseBody:responseBody];
        [responseBody release];
        DLog(@"AccessToken key: %@ secret: %@", self.accessToken.key, self.accessToken.secret);
        self.statusLabel.text = @"Access Granted!";
        [self.twitterEngine setAccessToken:self.accessToken];
        self.testButton.enabled = YES;
    }
}

- (void)accessTokenTicket:(OAServiceTicket *)ticket didFailWithError:(NSError *)error {
    DLog(@"Approved token error: %@", [error localizedDescription]);
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
    self.testButton = nil;
    self.statusLabel = nil;
}


- (void)dealloc {
    [twitterEngine_ release], twitterEngine_ = nil;    
    [requestToken_ release], requestToken_ = nil;    
    [authorizeButton release], authorizeButton = nil;
    [testButton release], testButton = nil;
    [authorizationToken_ release], authorizationToken_ = nil;
    [accessToken_ release], accessToken_ = nil;
    [statusLabel release], statusLabel = nil;    
    
    [super dealloc];
}

#pragma mark -
#pragma mark MGTwitterEngineDelegate methods

- (void)requestSucceeded:(NSString *)connectionIdentifier {
    DLog(@"Success for id: %@", connectionIdentifier);
}

- (void)requestFailed:(NSString *)connectionIdentifier withError:(NSError *)error {
    DLog(@"Failure for id: %@\n%@", connectionIdentifier, [error localizedDescription]);
}

@end
