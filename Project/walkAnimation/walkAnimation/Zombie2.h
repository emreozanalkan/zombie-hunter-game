//
//  Zombie2.h
//  walkAnimation
//
//  Created by baris atamer on 11/11/11.
//  Copyright 2011 ieu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Zombie2 : CCSprite {
    CCAction* _walkAction;
}

+(id) zombie;

@property (nonatomic, retain) CCAction *walkAction;

@end
