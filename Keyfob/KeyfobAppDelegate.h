//
//  KeyfobAppDelegate.h
//  Keyfob
//
//  Created by Mike Foley on 12/2/11.
//  Copyright (c) 2011 Bluetooth SIG, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KeyfobViewController;

@interface KeyfobAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) KeyfobViewController *viewController;

@end
