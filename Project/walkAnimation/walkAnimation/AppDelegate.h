//
//  AppDelegate.h
//  walkAnimation
//
//  Created by baris atamer on 11/11/11.
//  Copyright ieu 2011. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
}

@property (nonatomic, retain) UIWindow *window;

@end
