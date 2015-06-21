//
//  TTPlayer.h
//  TicTacToe
//
//  Created by Bharath Booshan on 6/3/15.
//  Copyright (c) 2015 Personagraph. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;


//Notifies when the player turn arrives
extern NSString *const TTPlayerTurnNotificationKey;



//Represents a player in the came.
@interface TTPlayer : NSObject
{
    BOOL _smart;
}


@property(nonatomic)NSString *name;//name of the player
@property(nonatomic,assign)int playerCode; // a code assigned by the game to this player
@property(nonatomic)UIColor *color; //a color to represent this player in tic-tac-toe board
@property(nonatomic,readonly,getter=isSmart)BOOL smart;//specifies whether he is smart ( who can predict his own moves )



- (void)yourTurn; //invoke when this player turn arrives
- (void)youWin; // invoke when this player wins
- (void)youLose; // invoke when this player loses
- (void)youAreTied; // invoke when this player ties


@end
