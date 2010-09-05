//
//  TwitterTestClientAppDelegate.h
//  TwitterTestClient
//
//  Created by Martin Volerich on 9/5/10.
//  Copyright 2010 Bill Bear Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TwitterTestClientViewController;

@interface TwitterTestClientAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    TwitterTestClientViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet TwitterTestClientViewController *viewController;

@end

