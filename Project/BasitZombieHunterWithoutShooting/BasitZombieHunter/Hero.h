//
//  Hero.h
//  BasitZombieHunter
//
//  Created by Emre Ozan Alkan on 11/8/11.
//  Copyright 2011 Emre Ozan Alkan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Hero : NSObject
{
    CCSprite* heroSprite;
    CGPoint velocity;
    int health;
    float _angle;
    CGSize _screenSize;
    float _collusionRadius;
}

+(id) heroWithParentNode:(CCNode*)parentNode;
-(id) initWithParentNode:(CCNode*)parentNode;

-(void) rotateHero:(float) angle;
-(void) setPos:(float) x  yPos:(float) y;
-(void) attack;

-(float) collusionRadius;
-(CGPoint) heroPosition;


@property (nonatomic,assign) float angle;
@end
