//
//  InputLayer.m
//  BasitZombieHunter
//
//  Created by baris atamer on 12/18/11.
//  Copyright 2011 Emre Ozan Alkan. All rights reserved.
//

#import "InputLayer.h"

@interface InputLayer (PrivateMethods)
-(void) addFireButton;
-(void) addJoystick;
@end

@implementation InputLayer


-(id) init
{
	if ((self = [super init]))
	{
		[self addFireButton];
		[self addJoystick];
		[self scheduleUpdate];
        
        
        
        
	}
	
	return self;
}

-(void) dealloc
{
	[super dealloc];
}

-(void) addFireButton
{
    
    float buttonRadius = 50;
	CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    
	fireButton = [SneakyButton button];
	fireButton.isHoldable = NO;
	
	SneakyButtonSkinnedBase* skinFireButton = [SneakyButtonSkinnedBase skinnedButton];
	skinFireButton.position = CGPointMake(screenSize.width - buttonRadius * 1.5f, buttonRadius * 1.5f);
    skinFireButton.defaultSprite   = [CCSprite spriteWithFile:@"FireButton-default.png"];
    skinFireButton.pressSprite     = [CCSprite spriteWithFile:@"FireButton-active.png"];
	skinFireButton.button = fireButton;
    
	[self addChild:skinFireButton];
}

-(void) addJoystick
{
	float stickRadius = 50;
    
	joystick = [SneakyJoystick joystickWithRect:CGRectMake(0, 0, stickRadius, stickRadius)];
	joystick.autoCenter = YES;
	
	// Now with fewer directions
	joystick.isDPad = YES;
	joystick.numberOfDirections = 8;
	
	SneakyJoystickSkinnedBase* skinStick = [SneakyJoystickSkinnedBase skinnedJoystick];
	skinStick.position = CGPointMake(stickRadius * 1.5f, stickRadius * 1.5f);
	//skinStick.backgroundSprite = [CCSprite spriteWithSpriteFrameName:@"button-disabled.png"];
    skinStick.backgroundSprite = [CCSprite spriteWithFile:@"button-disabled.png"];
	skinStick.backgroundSprite.color = ccMAGENTA;
    skinStick.backgroundSprite.opacity = 120;
    
	//skinStick.thumbSprite = [CCSprite spriteWithSpriteFrameName:@"button-disabled.png"];
    skinStick.thumbSprite = [CCSprite spriteWithFile:@"button-disabled.png"];
	skinStick.thumbSprite.scale = 0.5f;
	skinStick.joystick = joystick;
    
	[self addChild:skinStick];
}

-(void) update:(ccTime)delta
{
    CCNode *currentLevelScene = [(Level1*) [[CCDirector sharedDirector] runningScene] getChildByTag:GameLayerTagGame];
    Hero *hero  =  [currentLevelScene defaultHero];
    
    if(fireButton.active)
    {
        [hero attack];    
    }
    
    
    if(joystick.velocity.x !=0 && joystick.velocity.y != 0  ){
        
        CGPoint velocity = ccpMult(joystick.velocity, 150);
        
        
        if(joystick.velocity.x < 0)
        {
            [hero rotateHero:180.0];
        }
        else if( joystick.velocity.x >= 0.0)
        {
            [hero rotateHero:0.0];
        }
        
        
        [hero setPos:velocity.x * delta yPos:velocity.y * delta ];
        
    }
}


@end
