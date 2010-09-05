//
//  AuthorizeViewController.h
//  TwitterTestClient
//
//  Created by Martin Volerich on 9/5/10.
//  Copyright 2010 Bill Bear Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AuthorizeViewController : UIViewController {
    UIWebView *webView;
    @private
    NSURL *url_;
}

@property (nonatomic, retain) IBOutlet UIWebView *webView;

- (id)initWithURL:(NSURL *)url;

@end
