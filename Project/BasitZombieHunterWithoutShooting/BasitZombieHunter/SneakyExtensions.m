//
//  SneakyExtensions.m
//  mokokoJoyPad
//
//  Created by baris atamer on 6/29/11.
//  Copyright 2011 ieu. All rights reserved.
//

#import "SneakyExtensions.h"


@implementation SneakyButton (Extension)
+(id) button
{
	return [[[SneakyButton alloc] initWithRect:CGRectZero] autorelease];
}

+(id) buttonWithRect:(CGRect)rect
{
	return [[[SneakyButton alloc] initWithRect:rect] autorelease];
}
@end


@implementation SneakyButtonSkinnedBase (Extension)
+(id) skinnedButton
{
	return [[[SneakyButtonSkinnedBase alloc] init] autorelease];
}
@end

@implementation SneakyJoystick (Extension)
+(id) joystickWithRect:(CGRect)rect
{
	return [[[SneakyJoystick alloc] initWithRect:rect] autorelease];
}
@end

@implementation SneakyJoystickSkinnedBase (Extension)
+(id) skinnedJoystick
{
	return [[[SneakyJoystickSkinnedBase alloc] init] autorelease];
}
@end
