//
//  Settings.m
//  BasitZombieHunter
//
//  Created by Emre Ozan Alkan on 11/7/11.
//  Copyright 2011 Emre Ozan Alkan. All rights reserved.
//

#import "Settings.h"
#import "SimpleAudioEngine.h"

@implementation Settings

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	Settings *layer = [Settings node];
	[scene addChild: layer];
	return scene;
}

- (id)init
{
    self = [super init];
    if (self) {
        CCLOG(@"init %@", self);
        
        self.isTouchEnabled = YES;
        
        CGSize size = [[CCDirector sharedDirector] winSize];
        
        CCLabelTTF* settings = [CCLabelTTF labelWithString:@"Settings:" fontName:@"Helvetica-BoldOblique" fontSize:40];
        settings.anchorPoint = CGPointMake(.5, 1);
        settings.position = CGPointMake((size.width / 2), (size.height));
        [self addChild:settings];
        
        
        [self schedule:@selector(createSettings:) interval:1];
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


-(void) createSettings:(ccTime)delta
{
    [self unschedule:_cmd];
    
    CGSize size = [[CCDirector sharedDirector] winSize];
    
    [CCMenuItemFont setFontName:@"Helvetica-BoldOblique"];
	[CCMenuItemFont setFontSize:30];
    
    
    // create a toggle item using two other menu items (toggle works with images, too)
	CCMenuItemFont* easy = [CCMenuItemFont itemFromString:@"Difficulty: Easy"];
    easy.color = ccGREEN;
	CCMenuItemFont* normal = [CCMenuItemFont itemFromString:@"Difficulty: Normal"];
    normal.color = ccYELLOW;
	CCMenuItemFont* hard = [CCMenuItemFont itemFromString:@"Difficulty: Hard"];
    hard.color = ccRED;
	CCMenuItemToggle* difficulty = [CCMenuItemToggle itemWithTarget:self selector:@selector(difficultyTouched:) items:easy, normal, hard, nil];
    difficulty.selectedIndex = 1;
    
    
	CCMenuItemFont* soundOn = [CCMenuItemFont itemFromString:@"Sound: ON"];
    soundOn.color = ccGREEN;
	CCMenuItemFont* soundOff = [CCMenuItemFont itemFromString:@"Sound: OFF"];
    soundOff.color = ccRED;
    CCMenuItemToggle* sound = [CCMenuItemToggle itemWithTarget:self selector:@selector(soundTouched:) items:soundOn, soundOff, nil];
    
	CCMenuItemFont* effectsOn = [CCMenuItemFont itemFromString:@"Effects: ON"];
    effectsOn.color = ccGREEN;
	CCMenuItemFont* effectsOff = [CCMenuItemFont itemFromString:@"Effects: OFF"];
    effectsOff.color = ccRED;
    CCMenuItemToggle* effects = [CCMenuItemToggle itemWithTarget:self selector:@selector(effectsTouched:) items:effectsOn, effectsOff, nil];
    
    
    CCMenuItemFont* back = [CCMenuItemFont itemFromString:@"Back!" target:self selector:@selector(backTouched:)];
    
    
    
    CCMenu* menu = [CCMenu menuWithItems:difficulty, sound, effects, back, nil];
    //[menu setColor:ccRED];
    menu.position = CGPointMake(-(size.width / 2), size.height / 2);
	//menu.tag = 3;
	[self addChild:menu z:-1 tag:1];
    
    [menu alignItemsVerticallyWithPadding:20];
    
    
    
    // use an action for a neat initial effect - moving the whole menu at once!
	CCMoveTo* move = [CCMoveTo actionWithDuration:5 position:CGPointMake(size.width / 2, size.height / 2)];
	CCEaseElasticOut* ease = [CCEaseElasticOut actionWithAction:move period:.4f];
	[menu runAction:ease];
    
    SimpleAudioEngine *sae = [SimpleAudioEngine sharedEngine];
    if (sae != nil) {
        [sae playEffect:@"ThreeThunderStrikes.mp3" pitch:1.0f pan:0.0f gain:1.0f];
    }
}



-(void) difficultyTouched:(id)sender
{
	CCLOG(@"Difficulty touched: %@", sender);
    CCMenuItemToggle* toggleItem = (CCMenuItemToggle*)sender;
	int index = [toggleItem selectedIndex];
}

-(void) soundTouched:(id)sender
{
	CCLOG(@"Sound Button touched: %@", sender);
	CCMenuItemToggle* toggleItem = (CCMenuItemToggle*)sender;
	int index = [toggleItem selectedIndex];
}

-(void) effectsTouched:(id)sender
{
	CCLOG(@"Effects Button touched: %@", sender);
	CCMenuItemToggle* toggleItem = (CCMenuItemToggle*)sender;
	int index = [toggleItem selectedIndex];
}

-(void) backTouched:(id)sender
{
	CCLOG(@"Play Button touched: %@", sender);
    
    SimpleAudioEngine *sae = [SimpleAudioEngine sharedEngine];
    if (sae != nil) {
        [sae resumeBackgroundMusic];
    }
    
    [[CCDirector sharedDirector] popScene];
}









@end
