//
//  TTBoard.h
//  TicTacToe
//
//  Created by Bharath Booshan on 6/3/15.
//  Copyright (c) 2015 Personagraph. All rights reserved.
//

#import <Foundation/Foundation.h>

//Represents the Board State
typedef enum _BoardState{
    TTBoardStateWin,
    TTBoardStateComplete,
    TTBoardStateInComplete
}TTBoardState;

//Represent a Tic Tac Toe Board
@interface TTBoard : NSObject<NSCopying>
@property(readonly)NSString *boardID;//A unique id to identify the board

//Return 1 Player Wins
//Return 0 if game does not end
//Return -1 if there are no more positions
- (TTBoardState)markPosition:(int)position playerCode:(int)playerCode;

//get the list of indexes of available spots
- (NSMutableArray *)getEmptySpotList;

//reset the position and marks as empty slot
- (void)resetPosition:(int)position;

//0 - if no win
//any other num, its the player code
- (int)winner;

//returns TRUE, if Board is empty
- (BOOL)isBoardEmpty;

//check if two boards are same. Returns TRUE if two boards has same boardID, else returns FALSE
- (BOOL)isEqualToBoard:(TTBoard *)otherBoard;

@end
