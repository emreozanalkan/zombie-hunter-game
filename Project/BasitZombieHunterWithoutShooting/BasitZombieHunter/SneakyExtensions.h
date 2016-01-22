//
//  SneakyExtensions.h
//  mokokoJoyPad
//
//  Created by baris atamer on 6/29/11.
//  Copyright 2011 ieu. All rights reserved.
//

#import <Foundation/Foundation.h>

// SneakyInput headers
#import "ColoredCircleSprite.h"
#import "SneakyButton.h"
#import "SneakyButtonSkinnedBase.h"
#import "SneakyJoystick.h"
#import "SneakyJoystickSkinnedBase.h"


@interface SneakyButton (Extension)
+(id) button;
+(id) buttonWithRect:(CGRect)rect;
@end

@interface SneakyButtonSkinnedBase (Extension)
+(id) skinnedButton;
@end

@interface SneakyJoystick (Extension)
+(id) joystickWithRect:(CGRect)rect;
@end

@interface SneakyJoystickSkinnedBase (Extension)
+(id) skinnedJoystick;
@end



