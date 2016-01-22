//
//  Credits.m
//  BasitZombieHunter
//
//  Created by Emre Ozan Alkan on 11/7/11.
//  Copyright 2011 Emre Ozan Alkan. All rights reserved.
//

#import "Credits.h"
#import "SimpleAudioEngine.h"



@implementation Credits

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	Credits *layer = [Credits node];
	
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
        
        CCLabelTTF* developers = [CCLabelTTF labelWithString:@"Developers:" fontName:@"Helvetica-BoldOblique" fontSize:40];
        developers.anchorPoint = CGPointMake(.5, 1);
        developers.position = CGPointMake((size.width / 2), (size.height));
        [self addChild:developers];
        
        
        [self schedule:@selector(createCredits:) interval:1];
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

-(void) createCredits:(ccTime)delta
{
    [self unschedule:_cmd];
    
    CGSize size = [[CCDirector sharedDirector] winSize];

    
    
    [CCMenuItemFont setFontName:@"Helvetica-BoldOblique"];
	[CCMenuItemFont setFontSize:30];
    
    

	CCMenuItemFont* emreozanalkan = [CCMenuItemFont itemFromString:@"Emre Ozan Alkan" target:self selector:@selector(menu1ItemTouched:)];
    emreozanalkan.color = ccRED;
    CCMenuItemFont* yakupguneyli = [CCMenuItemFont itemFromString:@"Yakup Guneyli" target:self selector:@selector(menu2ItemTouched:)];
    yakupguneyli.color = ccRED;
    CCMenuItemFont* hakanerdogan = [CCMenuItemFont itemFromString:@"Hakan Erdogan" target:self selector:@selector(menu3ItemTouched:)];
    hakanerdogan.color = ccRED;
    CCMenuItemFont* ozgunkara = [CCMenuItemFont itemFromString:@"Ozgun Kara" target:self selector:@selector(menu4ItemTouched:)];
    ozgunkara.color = ccRED;
    CCMenuItemFont* back = [CCMenuItemFont itemFromString:@"Back!" target:self selector:@selector(menu5ItemTouched:)];
    
    CCMenu* menu = [CCMenu menuWithItems:emreozanalkan, yakupguneyli, hakanerdogan, ozgunkara, back, nil];
    //[menu setColor:ccRED];
    menu.position = CGPointMake(-(size.width / 2), size.height / 2);
	//menu.tag = 3;
	[self addChild:menu z:-1 tag:1];
    
    [menu alignItemsVerticallyWithPadding:10];
    
    
    

	CCMoveTo* move = [CCMoveTo actionWithDuration:5 position:CGPointMake(size.width / 2, size.height / 2)];
	CCEaseElasticOut* ease = [CCEaseElasticOut actionWithAction:move period:.4f];
	[menu runAction:ease];
    
}


-(void) menu1ItemTouched:(id)sender
{
	CCLOG(@"Menu 1 touched: %@", sender);
    //    CCMenuItemFont* menuItem = (CCMenuItemFont*)sender;
    //    menuItem.color = ccRED;
    NSURL * url = [[NSURL alloc] initWithString:@"http://www.emreozanalkan.com.tr"];
	[[UIApplication sharedApplication] openURL:url];
}

-(void) menu2ItemTouched:(id)sender
{
	CCLOG(@"Menu 2 Button touched: %@", sender);
    //    CCMenuItemFont* menuItem = (CCMenuItemFont*)sender;
    //    menuItem.color = ccRED;
    NSURL * url = [[NSURL alloc] initWithString:@"https://www.facebook.com/yakup.guneyli"];
	[[UIApplication sharedApplication] openURL:url];
}

-(void) menu3ItemTouched:(id)sender
{
	CCLOG(@"Menu 3 Button touched: %@", sender);
    //    CCMenuItemFont* menuItem = (CCMenuItemFont*)sender;
    //    menuItem.color = ccRED;
    NSURL * url = [[NSURL alloc] initWithString:@"https://www.facebook.com/hakanerdogn"];
	[[UIApplication sharedApplication] openURL:url];
}

-(void) menu4ItemTouched:(id)sender
{
	CCLOG(@"Menu 4 Button touched: %@", sender);
    //    CCMenuItemFont* menuItem = (CCMenuItemFont*)sender;
    //    menuItem.color = ccRED;
    NSURL * url = [[NSURL alloc] initWithString:@"https://www.facebook.com/ZGNKR"];
	[[UIApplication sharedApplication] openURL:url];
}

-(void) menu5ItemTouched:(id)sender
{
	CCLOG(@"Play Button touched: %@", sender);
    //    CCMenuItemFont* menuItem = (CCMenuItemFont*)sender;
    //    menuItem.color = ccRED;
    SimpleAudioEngine *sae = [SimpleAudioEngine sharedEngine];
    if (sae != nil) {
        [sae resumeBackgroundMusic];
    }
    
    [[CCDirector sharedDirector] popScene];
}








@end
