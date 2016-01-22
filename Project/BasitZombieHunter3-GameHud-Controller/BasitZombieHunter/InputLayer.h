//
//  InputLayer.h
//  BasitZombieHunter
//
//  Created by baris atamer on 12/18/11.
//  Copyright 2011 Emre Ozan Alkan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

// SneakyInput headers
#import "ColoredCircleSprite.h"
#import "SneakyButton.h"
#import "SneakyButtonSkinnedBase.h"
#import "SneakyJoystick.h"
#import "SneakyJoystickSkinnedBase.h"

#import "SneakyExtensions.h"

#import "Hero.h"
#import "Enumerations.h"
#import "Level1.h"

@interface InputLayer : CCLayer {
    SneakyButton    *fireButton;
    SneakyJoystick  *joystick;
}

@end
