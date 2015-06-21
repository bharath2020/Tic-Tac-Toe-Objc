//
//  TTBoard.m
//  TicTacToe
//
//  Created by Bharath Booshan on 6/3/15.
//  Copyright (c) 2015 Personagraph. All rights reserved.
//

#import "TTBoard.h"
#import <stdlib.h>

#define RAND_FROM_TO(min, max) (min + arc4random_uniform(max - min + 1))


const int NOT_OCCUPIED =-1;

@interface TTBoard()
{
    int board[9];
    int _totalPiecesOnBoard;
}

-(void)setTotalPiecesOnBoard:(int)totalPiece;
-(void)setBoardIdentifier:(NSString *)uuid;
@end

@interface TTBoard(Utilities)
- (BOOL)isBoardComplete;
@end

@implementation TTBoard(Utilities)

- (BOOL)isBoardComplete
{
    return _totalPiecesOnBoard == 9;
}

- (void)resetBoard
{
    for (int pos=0; pos<9; pos++ ){
        board[pos] = NOT_OCCUPIED;
    }
    _totalPiecesOnBoard =0;
}

@end

@implementation TTBoard(CopyProtocol)

- (void)copyBoardFrom:(int *)otherBoard length:(int)length{
    NSAssert(length==9,@"Length not equal to 9");
    for( int pos=0;pos<9;pos++){
        board[pos]=otherBoard[pos];
    }
}


@end


@implementation TTBoard
@synthesize boardID=_boardID;

#pragma mark Private Methods

-(void)setTotalPiecesOnBoard:(int)totalPiece
{
    _totalPiecesOnBoard = totalPiece;
}

-(void)setBoardIdentifier:(NSString *)uuid
{
    _boardID = uuid;
}

#pragma mark Initialization
- (id)init
{
    self = [super init];
    if (self ){
        [self resetBoard];
        _boardID = [[NSUUID UUID] UUIDString];
    }
    return self;
}

-(id)copyWithZone:(NSZone *)zone
{
    id copy = [[[self class] alloc] init];
    if( copy)
    {
        [copy copyBoardFrom:board length:9];
        [copy setTotalPiecesOnBoard:_totalPiecesOnBoard];
        [copy setBoardIdentifier:self.boardID];
    }
    return copy;
}

#pragma mark Public Methods

- (void)resetPosition:(int)position{
    NSAssert(position<9, @"Position greater than 9 while resetting");
    board[position]=NOT_OCCUPIED;
    _totalPiecesOnBoard--;
}

//Return 1 Player Wins
//Return 0 if game does not end
//Return -1 if there are no more positions
- (TTBoardState)markPosition:(int)position playerCode:(int)playerCode
{
    NSAssert(position<9, @"Position greather than 9 while marking position");
    if( position <0 || position>=9)
        return TTBoardStateInComplete;
    
    if( board[position] != NOT_OCCUPIED ){
        return TTBoardStateInComplete;
    }
    
    board[position]=playerCode;
    _totalPiecesOnBoard++;
    
    if( [self winner] != 0){
        return TTBoardStateWin;
    }
    else if( [self isBoardComplete]){
        return TTBoardStateComplete;
    }
    else{
        return TTBoardStateInComplete;
    }
}

//returns TRUE, if Board is empty
- (BOOL)isBoardEmpty{
    return _totalPiecesOnBoard ==0;
}

//get the list of indexes of available spots
- (NSMutableArray *)getEmptySpotList{
    NSMutableArray *emptySlots = [NSMutableArray array];
    for ( int pos = 0 ; pos < 9 ; pos++ ){
        if( board[pos] == NOT_OCCUPIED ){
            [emptySlots addObject:@(pos)];
        }
    }
    return emptySlots;
}

//0 - if no win
//any other num, its the player code

- (int)winner
{
    //  0 1 2
    //  3 4 5
    //  6 7 8
    
    int win[][3] = {{0,1,2},{3,4,5},{6,7,8},{0,3,6},{1,4,7},{2,5,8},{0,4,8},{2,4,6}};
    
    for( int index =0; index < 8; index++ ){
        if( board[ win[index][0] ] != NOT_OCCUPIED &&
           board[win[index][0]] == board[win[index][1]] &&
           board[win[index][0]] == board[win[index][2]] ){
            return board[win[index][0]];
        }
    }
    
    return 0;
}

//check if two boards are same
- (BOOL)isEqualToBoard:(TTBoard *)otherBoard{
    return [self.boardID isEqualToString:otherBoard.boardID];
}

@end
