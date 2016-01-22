//
//  Zombie.m
//  BasitZombieHunter
//
//  Created by Emre Ozan Alkan on 11/8/11.
//  Copyright 2011 Emre Ozan Alkan. All rights reserved.
//

#import "Zombie.h"
#import "cocos2d.h"
#import "CCAnimationHelper.h"

@implementation Zombie

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
        velocity = CGPointMake(1, 0);
        health = 100;
    }
    
    return self;
}

// Static autorelease initializer, mimics cocos2d's memory allocation scheme.
+(id) zombieWithParentNode:(CCNode*)parentNode
{
    return [[[self alloc] initWithParentNode:parentNode] autorelease];
}

-(id) initWithParentNode:(CCNode*)parentNode
{
    if ((self = [super init]))
    {
        velocity = CGPointMake(0.3, 0);
        health = 100;
        
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        //zombieSprite = [CCSprite spriteWithFile:@"Zombie.png"];
        
        zombieSprite = [CCSprite spriteWithSpriteFrameName:@"ZombieAnimate1.png"];
        zombieSprite.position = CGPointMake(screenSize.width + (zombieSprite.contentSize.width * 0.5), CCRANDOM_0_1() * screenSize.height);
        CCAnimation* anim = [CCAnimation animationWithFrame:@"ZombieAnimate" frameCount:4 delay:0.16f];
        //CCAnimation* walkAnim = [CCAnimation animationWithFrame:@"zombie2walk" frameCount:3 delay:0.2f];
        
        CCAnimate* animate = [CCAnimate actionWithAnimation:anim];
		CCRepeatForever* repeat = [CCRepeatForever actionWithAction:animate];
		[zombieSprite runAction:repeat];
        zombieSprite.tag = 2;
        [parentNode addChild:zombieSprite];
        // Manually schedule update via the undocumented CCScheduler class.
        [[CCScheduler sharedScheduler] scheduleUpdateForTarget:self priority:0 paused:NO];
        //[zombieSprite scheduleUpdate];
    }
    //return self;
    

    
    
//	// Loading the Ship's sprite using a sprite frame name (eg the filename)
//	if ((self = [super initWithSpriteFrameName:@"ship.png"]))
//	{
//		// create an animation object from all the sprite animation frames
//		CCAnimation* anim = [CCAnimation animationWithFrame:@"ship-anim" frameCount:5 delay:0.08f];
//		
//		// add the animation to the sprite (optional)
//		//[self addAnimation:anim];
//		
//		// run the animation by using the CCAnimate action
//		CCAnimate* animate = [CCAnimate actionWithAnimation:anim];
//		CCRepeatForever* repeat = [CCRepeatForever actionWithAction:animate];
//		[self runAction:repeat];
//		
//		
//		[self scheduleUpdate];
//	}
    return self;
}

-(void) update:(ccTime)delta
{
    //CCLOG(@"Hehe");
    zombieSprite.position = ccpSub(zombieSprite.position, velocity);
}

-(void) stopZombieSchedule
{
    [[CCScheduler sharedScheduler] unscheduleAllSelectorsForTarget:self];
}

-(void) dealloc
{
	CCLOG(@"burasi cagriliyor................dealloc: %@", self);
    
    [[CCScheduler sharedScheduler] unscheduleAllSelectorsForTarget:self];
     
     
	[super dealloc];
}

@end














