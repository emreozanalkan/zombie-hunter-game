//
//  HelloWorldLayer.m
//  walkAnimation
//
//  Created by baris atamer on 11/11/11.
//  Copyright ieu 2011. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"
#import "Zombie2.h"

// HelloWorldLayer implementation
@implementation HelloWorldLayer

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	if( (self=[super init])) {
        
        CCLayerColor* colorLayer = [CCLayerColor layerWithColor:ccc4(143, 50, 70, 255)];
        [self addChild:colorLayer z:-1];

		// ask director the the window size
		CGSize size = [[CCDirector sharedDirector] winSize];

        
        
        Zombie2 *zombie2 = [Zombie2 zombie];
        zombie2.scale = 0.5f;
        zombie2.position = ccp(size.width + 20  , size.height / 2 );
        [self addChild:zombie2];
        
        CCMoveTo *move = [CCMoveTo actionWithDuration:10.0f position:ccp(size.width / 2, size.height / 2 )] ;
        [zombie2 runAction:move];
        
	}
	return self;
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	[super dealloc];
}
@end
