//
//  Zombie.h
//  BasitZombieHunter
//
//  Created by Emre Ozan Alkan on 11/8/11.
//  Copyright 2011 Emre Ozan Alkan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Zombie : NSObject
{
    CCSprite* zombieSprite;
    CGPoint velocity;
    int health;
}

+(id) zombieWithParentNode:(CCNode*)parentNode;
-(id) initWithParentNode:(CCNode*)parentNode;
-(void) stopZombieSchedule;

@end
