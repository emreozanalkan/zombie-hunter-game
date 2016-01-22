//
//  MainMenu.m
//  BasitZombieHunter
//
//  Created by Emre Ozan Alkan on 11/3/11.
//  Copyright 2011 Emre Ozan Alkan. All rights reserved.
//

#import "MainMenu.h"
#import "SimpleAudioEngine.h"
#import "Credits.h"
#import "Settings.h"
#import "Level1.h"

@implementation MainMenu

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	MainMenu *layer = [MainMenu node];
	[scene addChild: layer];
	return scene;
}

- (id)init
{
    self = [super init];
    if (self) {
        CCLOG(@"init %@", self);
		
		self.isTouchEnabled = YES;
        
        gameLayerPosition = self.position;
        
        CGSize size = [[CCDirector sharedDirector] winSize];
        
        //glClearColor(1, 0, 0, 1);
        
        CCSprite* background = [CCSprite spriteWithFile:@"Street2Bloody.png"];
		background.position = CGPointMake(size.width / 2, size.height / 2);
        background.tag = 1;
        // scaling the image beyond recognition here
		//background.scaleX = 30;
		//background.scaleY = 3;
		[self addChild:background];
        
        
        CCSprite* banner = [CCSprite spriteWithFile:@"ZombieHunterRedBanner.png"];
		banner.position = CGPointMake(size.width / 2, size.height);
		// scaling the image beyond recognition here
		banner.scaleX = 2;
		//banner.scaleY = 1;
        banner.anchorPoint = CGPointMake(0.5, 1);
        banner.tag = 2;
		[self addChild:banner];
        
        
        //[self schedule:@selector(update:) interval:0.1f];
        [self schedule:@selector(createMenu:) interval:1];
        //[self schedule:@selector(startBackgroundMusic:) interval:5];
        
        SimpleAudioEngine *sae = [SimpleAudioEngine sharedEngine];
        if (sae != nil) {
            [sae playBackgroundMusic:@"ZombieIntro.mp3" loop:YES];
            [sae playEffect:@"ZombieNews.mp3"];
        }
    }
    
    return self;
}

-(void) registerWithTouchDispatcher
{
	// make sure either of the two following lines are used
	// if you use both you'll receive both standard and targeted touch events, at the very least wasting performance
	// if you leave this method blank then you'll receive no touch events at all, despite self.isTouchEnabled being set!
	
	// call the base implementation (default touch handler)
	//[super registerWithTouchDispatcher];
	
	// or use the targeted touch handler instead
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:INT_MIN+10 swallowsTouches:NO];
}

//-(void) update:(ccTime)delta
//{
	// called every frame thanks to [self scheduleUpdate]
	
	// unschedule this method (_cmd is a shortcut and stands for the current method) so it won't be called anymore
	//[self unschedule:_cmd];
	
	//CCLOG(@"update with delta time: %f", delta);
	
	// re-schedule update randomly within the next 10 seconds
	//float nextUpdate = CCRANDOM_0_1() * 10;
	//[self schedule:_cmd interval:nextUpdate];
//}

// Touch Input Events
-(CGPoint) locationFromTouch:(UITouch*)touch
{
	CGPoint touchLocation = [touch locationInView: [touch view]];
	return [[CCDirector sharedDirector] convertToGL:touchLocation];
}

-(BOOL) ccTouchBegan:(UITouch*)touch withEvent:(UIEvent *)event
{
	lastTouchLocation = [self locationFromTouch:touch];
	
	
	[self stopActionByTag:5];
	
	return YES;
}

-(void) ccTouchMoved:(UITouch*)touch withEvent:(UIEvent *)event
{
	CGPoint currentTouchLocation = [self locationFromTouch:touch];
	
	CGPoint moveTo = ccpSub(lastTouchLocation, currentTouchLocation);

	moveTo = ccpMult(moveTo, -1);
	
	lastTouchLocation = currentTouchLocation;
	
	self.position = ccpAdd(self.position, moveTo);
}

-(void) ccTouchEnded:(UITouch*)touch withEvent:(UIEvent *)event
{
	CCMoveTo* move = [CCMoveTo actionWithDuration:1 position:gameLayerPosition];
	CCEaseIn* ease = [CCEaseIn actionWithAction:move rate:0.5f];
	ease.tag = 5;
	[self runAction:ease];
}

-(void) createMenu:(ccTime)delta
{
    [self unschedule:_cmd];
    
    CGSize size = [[CCDirector sharedDirector] winSize];
    
    [CCMenuItemFont setFontName:@"Helvetica-BoldOblique"];
	[CCMenuItemFont setFontSize:40];
    
    
    // create a few labels with text and selector
	CCMenuItemFont* playMenuItem = [CCMenuItemFont itemFromString:@"Play!" target:self selector:@selector(playMenuItemTouched:)];
    CCMenuItemFont* storyMenuItem = [CCMenuItemFont itemFromString:@"Story" target:self selector:@selector(storyMenuItemTouched:)];
    CCMenuItemFont* settingsMenuItem = [CCMenuItemFont itemFromString:@"Settings" target:self selector:@selector(settingsMenuItemTouched:)];
    CCMenuItemFont* creditsMenuItem = [CCMenuItemFont itemFromString:@"Credits" target:self selector:@selector(creditsMenuItemTouched:)];
    
    CCSprite* banner = (CCSprite*)[self getChildByTag:2];
    CGFloat h = size.height - banner.boundingBox.size.height / 2;
    
    CCMenu* menu = [CCMenu menuWithItems:playMenuItem, storyMenuItem, settingsMenuItem, creditsMenuItem, nil];
	//menu.position = CGPointMake(-(size.width / 2), (h) / 2);
    menu.position = CGPointMake(-(size.width / 2), (h) / 2);
	menu.tag = 3;
	[self addChild:menu];
    
    [menu alignItemsVerticallyWithPadding:20];
    
    
    
	CCMoveTo* move = [CCMoveTo actionWithDuration:5 position:CGPointMake(size.width / 2, h / 2)];
	CCEaseElasticOut* ease = [CCEaseElasticOut actionWithAction:move period:.4f];
	[menu runAction:ease];
}

-(void) startBackgroundMusic:(ccTime)delta
{
    [self unschedule:_cmd];
    
    //[[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"blues.mp3" loop:YES];
    
    SimpleAudioEngine *sae = [SimpleAudioEngine sharedEngine];
    if (sae != nil) {
        [sae playBackgroundMusic:@"ZombieNews.mp3" loop:NO];
        if (sae.willPlayBackgroundMusic) {
            sae.backgroundMusicVolume = 1.0f;
        }
    }
}

//-(void) changeScene:(id)sender
//{
	//[[CCDirector sharedDirector] replaceScene:[HelloWorld scene]];
//}

-(void) playMenuItemTouched:(id)sender
{
	CCLOG(@"Play Button touched: %@", sender);
//    CCMenuItemFont* menuItem = (CCMenuItemFont*)sender;
//    menuItem.color = ccRED;
    
    [[CCDirector sharedDirector] replaceScene:[Level1 scene]];
}

-(void) storyMenuItemTouched:(id)sender
{
	CCLOG(@"Story Button touched: %@", sender);
//    CCMenuItemFont* menuItem = (CCMenuItemFont*)sender;
//    menuItem.color = ccRED;
}

-(void) settingsMenuItemTouched:(id)sender
{
	CCLOG(@"Settings Button touched: %@", sender);
//    CCMenuItemFont* menuItem = (CCMenuItemFont*)sender;
//    menuItem.color = ccRED;
    
    SimpleAudioEngine *sae = [SimpleAudioEngine sharedEngine];
    if (sae != nil) {
        //[sae preloadBackgroundMusic:@"ZombieIntro.mp3"];
        //[sae preloadEffect:@"ZombieNews.mp3"];
        //if (sae.willPlayBackgroundMusic) {
        //sae.backgroundMusicVolume = 0.0f;
        //}
        //[sae playBackgroundMusic:@"ZombieIntro.mp3" loop:YES];
        [sae pauseBackgroundMusic];
        //[sae stopBackgroundMusic];
        [sae playEffect:@"MenuClickEffect.mp3"];
        //[sae stopEffect:0];
    }
    
    [[CCDirector sharedDirector] pushScene:[Settings scene]];
}

-(void) creditsMenuItemTouched:(id)sender
{	
	CCLOG(@"Credits Button touched: %@", sender);
//    CCMenuItemFont* menuItem = (CCMenuItemFont*)sender;
//    menuItem.color = ccRED;
    
    SimpleAudioEngine *sae = [SimpleAudioEngine sharedEngine];
    if (sae != nil) {
        //[sae preloadBackgroundMusic:@"ZombieIntro.mp3"];
        //[sae preloadEffect:@"ZombieNews.mp3"];
        //if (sae.willPlayBackgroundMusic) {
            //sae.backgroundMusicVolume = 0.0f;
        //}
        //[sae playBackgroundMusic:@"ZombieIntro.mp3" loop:YES];
        [sae pauseBackgroundMusic];
        //[sae stopBackgroundMusic];
        [sae playEffect:@"MenuClickEffect.mp3"];
        //[sae stopEffect:0];
    }
    
    [[CCDirector sharedDirector] pushScene:[Credits scene]];
}

-(void) dealloc
{
	CCLOG(@"dealloc: %@", self);
    
	[super dealloc];
}




































@end
