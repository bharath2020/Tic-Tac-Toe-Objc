//
//  TTSmartPlayer.m
//  TicTacToe
//
//  Created by Bharath Booshan on 6/4/15.
//  Copyright (c) 2015 Personagraph. All rights reserved.
//

#import "TTSmartPlayer.h"
#import "TTGameAI.h"
#import "TTBoard.h"

NSString * TTSmartPlayerPredictedNextPositionKey = @"TTSmartPlayerPredictedNextPositionKey";
NSString * TTSmartPlayerPosition = @"TTSmartPlayerPosition";

@interface TTSmartPlayer()
{
    TTGameAI *_AI; // Key to predict his next move
}
@property(nonatomic)TTPlayer *opponent;
@end

@implementation TTSmartPlayer
- (instancetype)initWithOpponent:(TTPlayer *)player
{
    self = [super init];
    if( self )
    {
        _smart = YES;
        self.opponent = player;
        //AI needs to know the host and opponent
        _AI = [[TTGameAI alloc] initWithHostPlayer:self opponent:self.opponent];
    }
    return self;
}

- (void)yourTurn{
    
    [super yourTurn];
    

    [_AI predictNextPositionForBoard:self.board completionHandler:^(int position, TTBoard *boardInContext) {
        
        //Since we only changed the boards whent he game end and player remains same throught app cycle,
        //we need to make sure that the prediction was applied to same board
        //If the baord has changed between predictions, lets not send it
        if( [self.board isEqualToBoard:boardInContext] ){
            [[NSNotificationCenter defaultCenter] postNotificationName:TTSmartPlayerPredictedNextPositionKey object:self userInfo:@{TTSmartPlayerPosition : @(position)}];
        }
    }];
 
}
@end
