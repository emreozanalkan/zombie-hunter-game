//
//  HelloWorldLayer.m
//  BasitZombieHunter
//
//  Created by Emre Ozan Alkan on 11/2/11.
//  Copyright Emre Ozan Alkan 2011. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"

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
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
		
		// create and initialize a Label
		CCLabelTTF *label = [CCLabelTTF labelWithString:@"here is menu showing" fontName:@"Marker Felt" fontSize:32];
        label.tag = 1;

		// ask director the the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
	
		// position the label on the center of the screen
		label.position =  ccp( size.width /2 , size.height/2 );
		
		// add the label as a child to this Layer
		[self addChild: label];
        
        self.isTouchEnabled = YES;
	}
	return self;
}

-(void) registerWithTouchDispatcher
{
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

-(BOOL) ccTouchBegan:(UITouch*)touch withEvent:(UIEvent *)event
{
    CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
	// Always swallow touches, GameLayer is the last layer to receive touches.
    CCLabelTTF *label = (CCLabelTTF*) [self getChildByTag:1];
    [label setString:@"here touch"];
    
	return YES;
}

-(void) ccTouchMoved:(UITouch*)touch withEvent:(UIEvent *)event
{
    CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
}

-(void) ccTouchEnded:(UITouch*)touch withEvent:(UIEvent *)event
{
    CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
    
    CCLabelTTF *label = (CCLabelTTF*) [self getChildByTag:1];
    [label setString:@"touch ends"];
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end
