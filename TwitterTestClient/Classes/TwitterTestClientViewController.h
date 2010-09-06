//
//  TwitterTestClientViewController.h
//  TwitterTestClient
//
//  Created by Martin Volerich on 9/5/10.
//  Copyright 2010 Bill Bear Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <MGTwitterEngine.h>
#import <OAuthConsumer.h>

@interface TwitterTestClientViewController : UIViewController <MGTwitterEngineDelegate> {
    MGTwitterEngine *twitterEngine_;
    OAConsumer *consumer_;
    OAToken *requestToken_;
    OAToken *authorizationToken_;
    OAToken *accessToken_;
    
    UIButton *authorizeButton;
    UIButton *testButton;
    UILabel *statusLabel;
    
    BOOL authorizing;
}

@property (nonatomic, retain) MGTwitterEngine *twitterEngine;
@property (nonatomic, retain) OAConsumer *consumer;
@property (nonatomic, retain) OAToken *requestToken;
@property (nonatomic, retain) OAToken *authorizationToken;
@property (nonatomic, retain) OAToken *accessToken;

@property (nonatomic, retain) IBOutlet UIButton *authorizeButton;
@property (nonatomic, retain) IBOutlet UIButton *testButton;
@property (nonatomic, retain) IBOutlet UILabel *statusLabel;


- (IBAction)requestToken:(id)sender;
- (IBAction)authorizeToken:(id)sender;
- (IBAction)testTweet:(id)sender;

@end

