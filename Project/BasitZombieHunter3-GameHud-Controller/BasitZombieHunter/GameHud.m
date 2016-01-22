//
//  GameHud.m
//  mokokoJoyPad
//
//  Created by baris atamer on 7/16/11.
//  Copyright 2011 ieu. All rights reserved.
//

#import "GameHud.h"
//#import "GameLayer.h"

#define MAXIMUM_LIVES 5

@interface GameHud (PrivateMethods)
-(void) setupLives;
@end

@implementation GameHud

@synthesize label = _label;
-(id) init
{
	if ((self = [super init]))
	{
        
        [self setupLives];
        
		[self scheduleUpdate];
        
        // A time counter 
        //[self schedule:@selector(updateTime:) interval:1.0f];
	}
	
	return self;
}


-(void) setupLives
{
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    livesArray = [[CCArray alloc] initWithCapacity:MAXIMUM_LIVES];
    
    for (int i = 0; i < MAXIMUM_LIVES ; i++) {
        
        //CCSprite* live = [CCSprite spriteWithSpriteFrameName:@"health.png"];
        CCSprite* live = [CCSprite spriteWithFile:@"heartSprite.png"];
        live.scale = 0.5;
        CGSize spriteSize = [live textureRect].size ;
        
        
        live.position = ccp(spriteSize.width / 2 + (i * spriteSize.width  ), winSize.height - spriteSize.height / 2);
        [livesArray addObject:live];
        [self addChild:live];
        
    }
    
    numberOfLives = MAXIMUM_LIVES;
    
    score   = 0;
    minutes = 0;
    seconds = 0;
    
    NSString* string1 = [NSString stringWithFormat:@"%i", score];
    
    _label = [CCLabelBMFont labelWithString:string1 fntFile:@"scoreFont.fnt"];
    _label.position= ccp(winSize.width - 50 ,winSize.height - 10);
    _label.color = ccYELLOW;
    [self addChild:_label z:10];
    
    
}

-(void) updateLives:(int) _numberOfLives
{
    numberOfLives = _numberOfLives;
    
    for (int i = 0; i < MAXIMUM_LIVES; i++) {
        CCSprite* tempLive = [livesArray objectAtIndex:i];
        if (i < numberOfLives) {
            tempLive.visible = YES;
        }
        else{
            tempLive.visible = NO;
        }
        
    }
}

-(void) dealloc
{
    [livesArray release];
    livesArray = nil;
    
    [_label release];
    _label = nil;
	[super dealloc];
}


-(void) update:(ccTime) delta
{
    
}

-(void) updateTime:(ccTime) delta
{
    seconds++;
    
    
    [_label setString:[NSString stringWithFormat:@"%i", seconds]];
}

@end