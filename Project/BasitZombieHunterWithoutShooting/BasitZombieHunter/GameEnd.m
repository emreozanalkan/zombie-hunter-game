//
//  GameEnd.m
//  BasitZombieHunter
//
//  Created by EMRE OZAN ALKAN on 1/19/12.
//  Copyright 2012 Emre Ozan Alkan. All rights reserved.
//

#import "GameEnd.h"

#import "MainMenu.h"
#import "Level1.h"


@implementation GameEnd

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	GameEnd *layer = [GameEnd node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
        CCLOG(@"init %@", self);
        
        // enable touch input
        self.isTouchEnabled = YES;
        
        CGSize size = [[CCDirector sharedDirector] winSize];
        
//        CCLabelTTF* developers = [CCLabelTTF labelWithString:@"Developers:" fontName:@"Helvetica-BoldOblique" fontSize:40];
//        developers.anchorPoint = CGPointMake(.5, 1);
//        developers.position = CGPointMake((size.width / 2), (size.height));
//        [self addChild:developers];
        
        
        [self schedule:@selector(createGameEnd:) interval:1];
    }
    return self;
}

-(void) registerWithTouchDispatcher
{
	// make sure either of the two following lines are used
	// if you use both you'll receive both standard and targeted touch events, at the very least wasting performance
	// if you leave this method blank then you'll receive no touch events at all, despite self.isTouchEnabled being set!
	
	// call the base implementation (default touch handler)
	[super registerWithTouchDispatcher];
	
	// or use the targeted touch handler instead
	//[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:INT_MIN+1 swallowsTouches:YES];
}

// Touch Input Events
-(CGPoint) locationFromTouches:(NSSet *)touches
{
	UITouch *touch = [touches anyObject];
	CGPoint touchLocation = [touch locationInView: [touch view]];
	return [[CCDirector sharedDirector] convertToGL:touchLocation];
}

-(void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
}

-(void) ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	CGPoint location = [self locationFromTouches:touches];
	CCLOG(@"touch moved to: %.0f, %.0f", location.x, location.y);
}

-(void) ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	// the scene we want to see next
	//CCScene* scene = [MenuScene scene];
	
	//CCFadeTransition* transitionScene = [CCFadeTransition transitionWithDuration:3 scene:scene withColor:ccRED];
	//CCFadeTRTransition* transitionScene = [CCFadeTRTransition transitionWithDuration:3 scene:scene];
	//CCRotoZoomTransition* transitionScene = [CCRotoZoomTransition transitionWithDuration:3 scene:scene];
	//CCShrinkGrowTransition* transitionScene = [CCShrinkGrowTransition transitionWithDuration:3 scene:scene];
	//CCTurnOffTilesTransition* transitionScene = [CCTurnOffTilesTransition transitionWithDuration:3 scene:scene];
	//[[CCDirector sharedDirector] replaceScene:transitionScene];
    
	
	// Alternatives:
	
	// not using any transition scene at all:
	//[[CCDirector sharedDirector] replaceScene:scene];
	
	// note: you can also reload the current scene
	// just don't use "self", you have to create a new scene!
	//[[CCDirector sharedDirector] replaceScene:[HelloWorld scene]];
    //[[CCDirector sharedDirector] popScene];
}

-(void) ccTouchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
	
}


-(void) createGameEnd:(ccTime)delta
{
    [self unschedule:_cmd];
    
    CGSize size = [[CCDirector sharedDirector] winSize];
    
    
    
    [CCMenuItemFont setFontName:@"Helvetica-BoldOblique"];
	[CCMenuItemFont setFontSize:50];
    
    
    
	CCMenuItemFont* playAgain = [CCMenuItemFont itemFromString:@"Play Again" target:self selector:@selector(menu1ItemTouched:)];
    playAgain.color = ccRED;
    CCMenuItemFont* back = [CCMenuItemFont itemFromString:@"Menu!" target:self selector:@selector(menu2ItemTouched:)];
    back.color = ccGREEN;
    CCMenu* menu = [CCMenu menuWithItems:playAgain, back, nil];
    menu.position = CGPointMake(-(size.width / 2), size.height / 2);
	//menu.tag = 3;
	[self addChild:menu z:-1 tag:1];
    
    [menu alignItemsVerticallyWithPadding:50];
    
    
    
    
	CCMoveTo* move = [CCMoveTo actionWithDuration:5 position:CGPointMake(size.width / 2, size.height / 2)];
	CCEaseElasticOut* ease = [CCEaseElasticOut actionWithAction:move period:.4f];
	[menu runAction:ease];
    
}


-(void) menu1ItemTouched:(id)sender
{
	CCLOG(@"Menu 1 touched: %@", sender);
    //    CCMenuItemFont* menuItem = (CCMenuItemFont*)sender;
    //    menuItem.color = ccRED;
    //NSURL * url = [[NSURL alloc] initWithString:@"http://www.emreozanalkan.com.tr"];
	//[[UIApplication sharedApplication] openURL:url];
    [[CCDirector sharedDirector] replaceScene:[Level1 scene]];
}

-(void) menu2ItemTouched:(id)sender
{
	CCLOG(@"Menu 2 Button touched: %@", sender);
    //    CCMenuItemFont* menuItem = (CCMenuItemFont*)sender;
    //    menuItem.color = ccRED;
    //NSURL * url = [[NSURL alloc] initWithString:@"https://www.facebook.com/yakup.guneyli"];
	//[[UIApplication sharedApplication] openURL:url];
    [[CCDirector sharedDirector] replaceScene:[MainMenu scene]];
}

@end
