//
//  TTGame.m
//  TicTacToe
//
//  Created by Bharath Booshan on 6/3/15.
//  Copyright (c) 2015 Personagraph. All rights reserved.
//

#import "TTGame.h"
#import "TTBoard.h"

 NSString *TTGameStartedNotificationKey = @"TTGameStartedNotificationKey";// Notification when the game starts
 NSString *TTGameEndedNotificationKey = @"TTGameEndedNotificationKey"; // Notification when the game is completed
 NSString *TTGameIsTieKey = @"TTGameIsTieKey";//BOOL value will be returned, to know if the game ended in tie
 NSString *TTGamePositionUpdatedKey=@"TTGamePositionUpdatedKey";
 NSString *TTGamePlayerKey=@"TTGamePlayerKey";
 NSString *TTGamePositionKey=@"TTGamePositionKey";

@interface TTGame()
{
    TTBoard *currentBoard;
    TTPlayer *currentPlayer;
    
    TTPlayer *player1;
    TTPlayer *player2;
}
- (void)gameEnded:(BOOL)isTie;

@end

@implementation TTGame
@synthesize currentPlayer,currentBoard,player2,player1;

#pragma mark Private Method
- (void)gameEnded:(BOOL)isTie
{
    [[NSNotificationCenter defaultCenter] postNotificationName:TTGameEndedNotificationKey object:self userInfo:@{TTGameIsTieKey : @(isTie),TTGamePlayerKey:currentPlayer}];
}

#pragma mark Public Method
//Start the game afresh, with two players, and mark the current player who starts the turn
- (void)startGameWithPlayer1:(TTPlayer *)plr2 player2:(TTPlayer *)plr1 currentPlayer:(TTPlayer *)curPlayer
{
    currentPlayer = curPlayer;
    player1 = plr1;
    player2 = plr2;
    
    player1.playerCode = 1;
    player2.playerCode = 2;
    currentBoard = [[TTBoard alloc] init];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:TTGameStartedNotificationKey object:self];
    
    [currentPlayer performSelector:@selector(yourTurn) withObject:nil afterDelay:0.1];
}


//Make the next move at position. This Game tracks the current player
//After end of the function, if the game has not ended, it switches the current player
//Returns TRUE, if the result of marking this postion ends the game
//Returns FALSE, otherwise
- (BOOL)markPosition:(int)position
{
    BOOL returnState = FALSE;
    
    TTBoardState boardState = [currentBoard markPosition:position playerCode:currentPlayer.playerCode];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:TTGamePositionUpdatedKey object:self userInfo:@{TTGamePlayerKey:currentPlayer,TTGamePositionKey:@(position)}];

   
    if( boardState == TTBoardStateInComplete ){
        //rotate current player
        currentPlayer = (currentPlayer == player1) ? player2 : player1;
        [currentPlayer yourTurn];
        
    }
    else if( boardState == TTBoardStateComplete ){
        [player1 youAreTied];
        [player2 youAreTied];
        [self gameEnded:TRUE];
        returnState = TRUE;
    }
    else{
        [currentPlayer youWin];
        [self gameEnded:FALSE];
        returnState = TRUE;
    }
    return returnState;
}


//Returns the winning player. If there is no winner, then returns Nil
- (TTPlayer *)winner
{
    int state = [currentBoard winner];
    if( state == player1.playerCode){
        return player1;
    }
    else if (state == player2.playerCode ){
        return player2;
    }
    return nil;
}

@end
