//
//  TTGame.h
//  TicTacToe
//
//  Created by Bharath Booshan on 6/3/15.
//  Copyright (c) 2015 Personagraph. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTPlayer.h"

@class TTBoard;

//Notifies the Game Events like START, END, ADVANCE NEXT STEP
extern NSString *TTGameStartedNotificationKey;// Notification when the game starts
extern NSString *TTGameEndedNotificationKey; // Notification when the game is completed
extern NSString *TTGameIsTieKey;//BOOL value will be returned, to know if the game ended in tie

extern NSString *TTGamePositionUpdatedKey; // Notifies when a player make a move
extern NSString *TTGamePlayerKey; // Use this key in userInfo to know which player made a move
extern NSString *TTGamePositionKey; // Use this key in userInfo to know where the player placed his move

@interface TTGame : NSObject
@property(nonatomic,readonly)TTPlayer *player1;
@property(nonatomic,readonly)TTPlayer *player2;
@property(nonatomic,readonly)TTPlayer *currentPlayer;
@property(nonatomic,readonly)TTBoard *currentBoard;


//Start the game afresh, with two players, and mark the current player who starts the turn
- (void)startGameWithPlayer1:(TTPlayer *)player1 player2:(TTPlayer *)player2 currentPlayer:(TTPlayer *)currentPlayer;

//Make the next move at position. This Game tracks the current player
//After end of the function, if the game has not ended, it switches the current player
//Returns TRUE, if the result of marking this postion ends the game
//Returns FALSE, otherwise
- (BOOL)markPosition:(int)position;

//Returns the winning player. If there is no winner, then returns Nil
- (TTPlayer *)winner;

@end
