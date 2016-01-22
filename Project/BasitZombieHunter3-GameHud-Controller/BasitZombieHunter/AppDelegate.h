//
//  AppDelegate.h
//  BasitZombieHunter
//
//  Created by Emre Ozan Alkan on 11/2/11.
//  Copyright Emre Ozan Alkan 2011. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
}

@property (nonatomic, retain) UIWindow *window;

@end
