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
    CCSprite* _zombieSprite;
    CGPoint velocity;
    int health;
    float _collusionRadius;
}

@property (nonatomic, retain) CCSprite *zombieSprite;

+(id) zombieWithParentNode:(CCNode*)parentNode;
-(id) initWithParentNode:(CCNode*)parentNode;
-(void) stopZombieSchedule;
+(float) collusionRadius;

-(CGPoint) zombiePosition;
-(void) touchedHero;
-(void) reachedEnd;


@end
