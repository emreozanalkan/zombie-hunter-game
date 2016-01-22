//
//  MainMenu.h
//  BasitZombieHunter
//
//  Created by Emre Ozan Alkan on 11/3/11.
//  Copyright 2011 Emre Ozan Alkan. All rights reserved.
//

#import "cocos2d.h"
#import "CCLayer.h"

@interface MainMenu : CCLayer
{
	CGPoint gameLayerPosition;
	CGPoint lastTouchLocation;
}

+(CCScene *) scene;
@end
