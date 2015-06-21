//
//  TTPlayer.m
//  TicTacToe
//
//  Created by Bharath Booshan on 6/3/15.
//  Copyright (c) 2015 Personagraph. All rights reserved.
//

#import "TTPlayer.h"

NSString *const TTPlayerTurnNotificationKey = @"turn";

@implementation TTPlayer

@synthesize smart=_smart;

- (instancetype)init
{
    self = [super init];
    if( self )
    {
        _smart = NO;
    }
    return self;
}

- (void)yourTurn
{
    [[NSNotificationCenter defaultCenter] postNotificationName:TTPlayerTurnNotificationKey object:self];
}

- (void)youWin
{
    NSLog(@" %@ WON!! ", self.name);
}

- (void)youLose
{
    NSLog(@"%@ LOST ", self.name);
}
- (void)youAreTied
{
    NSLog(@"%@ TIED", self.name);
}

@end
