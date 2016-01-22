//
//  Zombie2.m
//  walkAnimation
//
//  Created by baris atamer on 11/11/11.
//  Copyright 2011 ieu. All rights reserved.
//

#import "Zombie2.h"
#import "CCAnimationHelper.h"

@interface Zombie2 (PrivateMethods) 
-(id)   initWithZombieImage;
@end

@implementation Zombie2

@synthesize walkAction = _walkAction;

+(id) zombie
{
    return [[[self alloc] initWithZombieImage] autorelease];
}

-(id) initWithZombieImage
{
	// Load the Texture Atlas sprite frames, this also loads the Texture with the same name.
	CCSpriteFrameCache* frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
	[frameCache addSpriteFramesWithFile:@"zombie2Texture.plist"];
    
	if ((self = [super initWithSpriteFrameName:@"zombie2walk0.png"]))
	{
        // Initialize the walking animation. 
        CCAnimation* walkAnim = [CCAnimation animationWithFrame:@"zombie2walk" frameCount:3 delay:0.2f];
        self.walkAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:walkAnim restoreOriginalFrame:NO]];
        
        [self runAction:_walkAction];
	}
    
	return self;
}

-(void) dealloc
{
    self.walkAction      = nil;
    [super dealloc];
}

@end
