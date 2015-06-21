//
//  TTGameAI.m
//  TicTacToe
//
//  Created by Bharath Booshan on 6/4/15.
//  Copyright (c) 2015 Personagraph. All rights reserved.
//

#import "TTGameAI.h"
#import "TTBoard.h"
#import "TTPlayer.h"

#define RAND_FROM_TO(min, max) (min + arc4random_uniform(max - min + 1))

const int MAX_LEVELS = 10;

@interface TTGameAI()
@property(nonatomic)TTPlayer *hostPlayer;
@property(nonatomic)TTPlayer *opponent;
-(int)getBestScore:(TTPlayer*)currentPlayer  inBoard:(TTBoard *)board depth:(int)depth;
@end

int host_max_win = 0;

@implementation TTGameAI

//minmax algorithm to predict best score for given tic tac toe game status
//This alogrithm tries to create a Game Tree for each of the  available moves
//This is a recursive function trying to create a a game board simulating player turns
//Predicts the best score for each player
//Since we want to predict the move for Smartest player, We derive scores from Smart Player's perspective
//If Smart Player wins, we will take the maximum score, while if the opponent wins, the score will be negative, indicating the maximum loss for the smart player. ZERO if the game is tied
-(int)getBestScore:(TTPlayer*)currentPlayer  inBoard:(TTBoard *)board depth:(int)depth{
    
    int state = [board winner];
    
    if( state == self.hostPlayer.playerCode ){
        return MAX_LEVELS-depth; // Positive score for smart / host player
    }
    else if( state == self.opponent.playerCode ){
        return depth-MAX_LEVELS; //negative means maximum loss for the host player
    }
    
    NSMutableArray *emptySlots = [board getEmptySpotList];
    //No Empty slots means, that the game board must be full and we will take this as a tie.
    // hence return ZERO
    if( [emptySlots count] == 0){
        return 0;
    }
    
    
    int minScore = MAX_LEVELS, maxScore=-MAX_LEVELS;
    
    //ITs time for the next player's turn.
    // Find the best score for the 'nextPlayer'
    TTPlayer *nextPlayer = (currentPlayer == self.hostPlayer ) ? self.opponent : self.hostPlayer;

    
    while ( [emptySlots count] ){
        
        u_int32_t totalSlots = (u_int32_t)[emptySlots count];
        NSUInteger nextIndex =RAND_FROM_TO(0, totalSlots-1);
        
        NSNumber *positionNum = [emptySlots objectAtIndex:nextIndex];
        
        [emptySlots removeObjectAtIndex:nextIndex];
        
        
        [board markPosition:[positionNum intValue] playerCode:nextPlayer.playerCode];
        
        int score = [self getBestScore:nextPlayer inBoard:board depth:depth+1];
        
        //Now that we have found the score for this postion, we move to next empty slot
        // resetting this position, so that it is becomes available
        [board resetPosition:[positionNum intValue]];
        
        if( minScore > score ){
            minScore = score;
        }
        
        if( maxScore < score ){
            maxScore = score;
        }
    }
    
    //This is the key
    // We take positive score if the host player wins.
    if( nextPlayer == self.hostPlayer ){
        return maxScore;
    }
    
    
    // We take min Score if the opponent wins. The reason here, we always assume the opponent to be SMART, and he will always
    // try to make a next move to win ( a heavy loss for us ).

    return minScore;

}

-(instancetype)initWithHostPlayer:(TTPlayer *)hostPlayer opponent:(TTPlayer *)opponent{
    self = [super init];
    if( self ){
        self.hostPlayer = hostPlayer;
        self.opponent = opponent;
    }
    return self;
}

//predicts the next best move and calls the completionHandler with the position and the board on which the move was predicted
-(void)predictNextPositionForBoard:(TTBoard *)board completionHandler:(void(^)(int position, TTBoard *boardInContext))completionHandler
{
    
    TTBoard *boardCopy = [board copy];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        
        int position =-1;
        //If Smart player is making the first move, then chose corner sides, as this move will always result in a win, except in case where the opponent
        // places his next move in center
        
        if( [boardCopy isBoardEmpty]){
            int cornerSlots[4] = {0,2,6,8};
            position = cornerSlots[RAND_FROM_TO(0, 3)];
        }
        else{
            
            //Apply MiniMax Algorithm
            // Loop through empty slots and find out the maximum score the smart player can score on each of next available moves
            // Select the score which returns the maximum score
            NSMutableArray *emptySlots = [boardCopy getEmptySpotList];
            if( [emptySlots count] != 0){
                int maxScore = -MAX_LEVELS;
                while ( [emptySlots count] ){
                    
                    u_int32_t totalSlots = (u_int32_t)[emptySlots count];
                    NSUInteger nextIndex =RAND_FROM_TO(0, totalSlots-1);
                    
                    NSNumber *positionNum = [emptySlots objectAtIndex:nextIndex];
                    
                    [emptySlots removeObjectAtIndex:nextIndex];
                    
                    [boardCopy markPosition:[positionNum intValue] playerCode:self.hostPlayer.playerCode];
                    
                    int tempScore = [self getBestScore:self.hostPlayer inBoard:boardCopy depth:0];
                    
                    [boardCopy resetPosition:[positionNum intValue]];
                    if( maxScore < tempScore ){
                        maxScore = tempScore;
                        position = [positionNum intValue];
                    }
                }
            }
        }
        
        //Flush the result on a main thread
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandler(position,boardCopy);
        });
    });
    
    
}


@end
