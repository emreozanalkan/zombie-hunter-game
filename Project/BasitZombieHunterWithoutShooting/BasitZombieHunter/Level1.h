//
//  Level1.h
//  BasitZombieHunter
//
//  Created by Emre Ozan Alkan on 11/8/11.
//  Copyright 2011 Emre Ozan Alkan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Hero.h"
#import "GameHud.h"
#import "InputLayer.h"


#import "Enumerations.h"


@interface Level1 : CCLayer {
    Hero *hero;
    NSMutableArray *zombieArray;
    float _maxCollisionDistance;
    GameHud* _gameHudLayer;
}


//+(CCScene *) scene;
+(id) scene;
-(Hero*) defaultHero;
-(void) maxCollusionDistance;
-(void) gameEnds;

@end
