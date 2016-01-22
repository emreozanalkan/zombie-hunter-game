//
//  GameHud.h
//  mokokoJoyPad
//
//  Created by baris atamer on 7/16/11.
//  Copyright 2011 ieu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface GameHud : CCLayer {
    int     numberOfLives;
    int     score;
    int     minutes;
    int     seconds;
    
    CCArray* livesArray;
    CCLabelBMFont* _label;
}

-(void) updateLives:(int) _numberOfLives;
@property (nonatomic, retain) CCLabelBMFont *label;
@end
