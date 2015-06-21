//
//  TTSmartPlayer.h
//  TicTacToe
//
//  Created by Bharath Booshan on 6/4/15.
//  Copyright (c) 2015 Personagraph. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTPlayer.h"

@class TTBoard;

//Notifies when the smart player has predicted the next position
extern NSString * TTSmartPlayerPredictedNextPositionKey;
extern NSString * TTSmartPlayerPosition; // Use this key from userInfo to retrieve the predicted postion

//Represents Smart player who can predict his next move
// Internally uses  AI to predict his next move, when his turn ( by invoking method yourTurn ) arrives

@interface TTSmartPlayer : TTPlayer

@property(nonatomic)TTBoard *board; //assign the board he is playing

//Tell him his opponent while creating him
- (instancetype)initWithOpponent:(TTPlayer *)player;


@end
