//
//  Hero.m
//  BasitZombieHunter
//
//  Created by Emre Ozan Alkan on 11/8/11.
//  Copyright 2011 Emre Ozan Alkan. All rights reserved.
//

#import "Hero.h"
#import "cocos2d.h"
#import "SimpleAudioEngine.h"
@implementation Hero
@synthesize angle = _angle;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
	CCLOG(@"%@ ----------------- %@", self, NSStringFromSelector(_cmd));
        velocity = CGPointMake(1, 0);
        health = 100;
        
        heroSprite = [CCSprite spriteWithSpriteFrameName:@"Hero.png"];
        
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        
        heroSprite.position = CGPointMake(heroSprite.contentSize.width, screenSize.height/2);
        
        self.angle = 31;
    }
    
    return self;
}

// Static autorelease initializer, mimics cocos2d's memory allocation scheme.
+(id) heroWithParentNode:(CCNode*)parentNode
{
	CCLOG(@"%@ ----------------- %@", self, NSStringFromSelector(_cmd));
    return [[[self alloc] initWithParentNode:parentNode] autorelease];
}

-(id) initWithParentNode:(CCNode*)parentNode
{
	CCLOG(@"%@ ----------------- %@", self, NSStringFromSelector(_cmd));
    if ((self = [super init]))
    {
        velocity = CGPointMake(0.1, 0);
        health = 100;
        
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        
        heroSprite = [CCSprite spriteWithSpriteFrameName:@"Hero.png"];
        heroSprite.position = CGPointMake(heroSprite.contentSize.width / 2, screenSize.height/2);
        
        heroSprite.tag = 2;
        [parentNode addChild:heroSprite];
        
        
        // Manually schedule update via the undocumented CCScheduler class.
        // ****** THIS IS IMPORTANT !! 
        //        NEVER COMMENT IT  !!
        [[CCScheduler sharedScheduler] scheduleUpdateForTarget:self priority:0 paused:NO];
        
        
        // **** PRELOADING CHARACTER'S SOUND EFFECTS *******
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"sword.wav"];

        
    }
    return self;
}



-(void) rotateHero:(float) angle
{
    //CCLOG(@"Rotated to %f" , angle);
    //heroSprite.rotation = angle;
    heroSprite.flipX = angle;
}

-(void) setPos:(float) x  yPos:(float) y
{
    heroSprite.position = ccp(heroSprite.position.x + x, heroSprite.position.y + y);
}

-(void) attack
{
    CCLOG(@"Hero attack function worked !");
    [[SimpleAudioEngine sharedEngine] playEffect:@"shotgun.caf"];
    
    // **************** ATTENTION *************************
    // I COULD NOT MANAGED TO PLAY sword.caf              *
    // I GUESS ITS FORMAT IS INCOMPATIBLE                 *
    // PLEASE RE-CONVERT IT WITH  SoundConverter SOFTWARE *
    // ****************************************************
    
    //[[SimpleAudioEngine sharedEngine] playEffect:@"sword.caf"];

}
-(void) update:(ccTime)delta
{
    //CCLOG(@"Hehe");
    //heroSprite.position = ccpSub(heroSprite.position, velocity);
    //heroSprite.rotation = angle;
}

-(void) dealloc
{
	CCLOG(@"%@ ----------------- %@", self, NSStringFromSelector(_cmd));
    
    //[[CCScheduler sharedScheduler] unscheduleAllSelectorsForTarget:self];
    
    [super dealloc];
}

@end
