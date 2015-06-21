//
//  TTGameAI.h
//  TicTacToe
//
//  Created by Bharath Booshan on 6/4/15.
//  Copyright (c) 2015 Personagraph. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TTBoard;
@class TTPlayer;


//Represents Tic Tac Toe Game AI
// Uses MiniMax Algorithm  to predict the next best move, where the Host Player either wins or ties, but Never loses

//TODO: This class need not be instantiated and can contain Static / Class method to predict the next move

@interface TTGameAI : NSObject

-(instancetype)initWithHostPlayer:(TTPlayer *)hostPlayer opponent:(TTPlayer *)opponent;

// 1. Takes the current board status and predicts the next move. The prediction will work after making a copy of the board
//     hence does not change the original board configuration
// 2. Completion handler will have the next position and the board that was used for predictions
// 3. Completion handler is always callled on main thread
// 4. Position will have value between 0-8
// 5. This method runs in a different thread and hence will not block the main thread
// 6. Always call this method on main thread. 
-(void)predictNextPositionForBoard:(TTBoard *)board completionHandler:(void(^)(int position, TTBoard *boardInContext))completionHandler;

@end
