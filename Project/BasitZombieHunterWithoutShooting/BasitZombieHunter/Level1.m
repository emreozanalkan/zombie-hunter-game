//
//  Level1.m
//  BasitZombieHunter
//
//  Created by Emre Ozan Alkan on 11/8/11.
//  Copyright 2011 Emre Ozan Alkan. All rights reserved.
//

#import "Enumerations.h"


#import "Level1.h"
#import "Zombie.h"
#import "MainMenu.h"
#import "Hero.h"

#import "GameHud.h"
#import "InputLayer.h"

#import "GameEnd.h"

#import "SimpleAudioEngine.h"

@implementation Level1

+(id) scene
{
    CCScene*    scene = [CCScene node];
    Level1*     layer = [Level1 node];
    [scene addChild:layer z:0 tag:GameLayerTagGame];
    
    InputLayer* inputLayer = [InputLayer node];
	[scene addChild:inputLayer z:1 tag:GameLayerTagInput];
    

    
    return scene;
}

- (id)init
{
    self = [super init];
    if (self) {
	CCLOG(@"%@ ----------------- %@", self, NSStringFromSelector(_cmd));
        CCLOG(@"init %@", self);
        
        _gameHudLayer = [GameHud node];
        [self addChild:_gameHudLayer z:2 tag:GameHudLayer];
		
		self.isTouchEnabled = YES;
        
        //gameLayerPosition = self.position;
        
        zombieArray = [[NSMutableArray alloc] init];
        
        CGSize size = [[CCDirector sharedDirector] winSize];
        
        //glClearColor(1, 0, 0, 1);
        
        CCSprite* background = [CCSprite spriteWithFile:@"Street2.png"];
		background.position = CGPointMake(size.width / 2, size.height / 2);
        background.tag = 1;
        // scaling the image beyond recognition here
		//background.scaleX = 30;
		//background.scaleY = 3;
        [self addChild:background];
        
        CCLabelTTF* developers = [CCLabelTTF labelWithString:@"Level - 1" fontName:@"Helvetica-BoldOblique" fontSize:14];
        developers.anchorPoint = CGPointMake(.5, 1);
        developers.position = CGPointMake((size.width / 2), (size.height));
        [self addChild:developers];
        
        
        hero = [Hero heroWithParentNode:self];
        
        
        //Zombie* zombie1 = [Zombie spiderWithParentNode:self];
        //Zombie* zombie2 = [Zombie spiderWithParentNode:self];
        
        
        //[self schedule:@selector(createCredits:) interval:1];
        [self scheduleUpdate];
        [self schedule:@selector(createZombie:) interval:4.0f];
        
        
        [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
        
        [self maxCollusionDistance];
        
        
      
    }
    return self;
}

-(void) update:(ccTime)delta
{
	//CCLOG(@"%@ ----------------- %@", self, _cmd);
	// Shooting is relayed to the game scene
	//[[GameScene sharedGameScene] shootBulletFromShip:self];
    
    int zombieCount = [zombieArray count];
    NSMutableArray* zmbs = [NSMutableArray array];
    
    
    for(int i = 0; i < zombieCount; i++)
    {
        Zombie* zombie = (Zombie*) [zombieArray objectAtIndex:i];
        if(zombie != nil)
        {
            //[zombie stopZombieSchedule];
            
            
            float actualDistance = ccpDistance([hero heroPosition], [zombie zombiePosition]);
            // Are the two objects closer than allowed?
            if (actualDistance < _maxCollisionDistance)
            {
                [zombie touchedHero];
                [_gameHudLayer zombieHit];
                [[SimpleAudioEngine sharedEngine] playEffect:@"ZombieHit.mp3"];
                [[SimpleAudioEngine sharedEngine] playEffect:@"ZombieHitHero.mp3"];
                [zmbs addObject:zombie];
            }
            else if([zombie zombiePosition].x <= 0)
            {
                [zombie reachedEnd];
                [_gameHudLayer zombieReachEnd];
                [[SimpleAudioEngine sharedEngine] playEffect:@"ZombieEat.mp3"];
                [zmbs addObject:zombie];
            }
            else
            {
                
            }
            
            if([_gameHudLayer remainingHealth] <= 0)
            {
                [self gameEnds];
                [[CCDirector sharedDirector] replaceScene:[GameEnd scene]];
            }
        }
        
        
    }
    
    
    int removeZombieCount = [zmbs count];
    
    
    for(int i = 0; i < removeZombieCount; i++)
    {
        [zombieArray removeObject:[zmbs objectAtIndex:i]];
    }
}

-(void) maxCollusionDistance
{
    _maxCollisionDistance = [hero collusionRadius] + [Zombie collusionRadius];
}

-(void) gameEnds
{
    [self unscheduleAllSelectors];
    //int zombieCount = [zombieArray count];
}

-(void) createZombie:(ccTime)delta
{
	CCLOG(@"%@ ----------------- %@", self, NSStringFromSelector(_cmd));
	// Shooting is relayed to the game scene
	//[[GameScene sharedGameScene] shootBulletFromShip:self];
    Zombie* tmp = [Zombie zombieWithParentNode:self];
    [zombieArray addObject:tmp];
}


-(void) registerWithTouchDispatcher
{
    [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

// Touch Input Events
-(CGPoint) locationFromTouches:(NSSet *)touches
{
	CCLOG(@"%@ ----------------- %@", self, NSStringFromSelector(_cmd));
	UITouch *touch = [touches anyObject];
	CGPoint touchLocation = [touch locationInView: [touch view]];
	return [[CCDirector sharedDirector] convertToGL:touchLocation];
}
-(BOOL) ccTouchBegan:(UITouch*)touch withEvent:(UIEvent *)event
{
    
	// Always swallow touches, GameLayer is the last layer to receive touches.
	return NO;
}


-(Hero*) defaultHero
{
    return hero;
}

-(void) dealloc
{
	CCLOG(@"%@ OYUN SONUUU ----------------- %@", self, NSStringFromSelector(_cmd));
    
    int zombieCount = [zombieArray count];
    for(int i = 0; i < zombieCount; i++)
    {
        Zombie* tempZombie = (Zombie*) [zombieArray objectAtIndex:i];
                if(tempZombie != nil)
                {
                    [tempZombie stopZombieSchedule];
                    //[tempZombie dealloc];
                }
    }
    
    CCLOG(@"zombiler stopschedule ve dealloc cagrildi................touchedHero: %@", self);

    
    [self unscheduleAllSelectors];
    CCLOG(@"level1 in unschedule................touchedHero: %@", self);

    
    //[hero dealloc];
    
    //[self removeAllChildrenWithCleanup:YES];
    //[zombieArray removeAllObjects];
    [zombieArray dealloc];
    CCLOG(@"zombiearray removeallobjects ve dealloc oldu bitti................touchedHero: %@", self);

    [hero dealloc];
    CCLOG(@"hero dealloc oldu ve level1[super dealloc geliyor]................touchedHero: %@", self);

    //[_gameHudLayer dealloc];
    
	[super dealloc];
}

@end
