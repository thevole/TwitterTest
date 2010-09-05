//
//  TwitterTestClientViewController.h
//  TwitterTestClient
//
//  Created by Martin Volerich on 9/5/10.
//  Copyright 2010 Bill Bear Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <MGTwitterEngine.h>

@interface TwitterTestClientViewController : UIViewController <MGTwitterEngineDelegate> {
    MGTwitterEngine *twitterEngine_;
    OAToken *requestToken_;
    
    UIButton *authorizeButton;
}

@property (nonatomic, retain) MGTwitterEngine *twitterEngine;
@property (nonatomic, retain) OAToken *requestToken;
@property (nonatomic, retain) IBOutlet UIButton *authorizeButton;



- (IBAction)requestToken:(id)sender;
- (IBAction)authorizeToken:(id)sender;

@end

