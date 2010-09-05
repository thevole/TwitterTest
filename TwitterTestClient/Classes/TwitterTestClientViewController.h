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
}

@property (nonatomic, retain) MGTwitterEngine *twitterEngine;

- (IBAction)startTwitter:(id)sender;

@end

