//
//  TTBoardTests.m
//  TicTacToe
//
//  Created by Bharath Booshan on 6/14/15.
//  Copyright (c) 2015 Personagraph. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "TTBoard.h"

@interface TTBoardTests : XCTestCase

@end

@implementation TTBoardTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testIfBoardReturnsCorrectEmptySlots {
    // This is an example of a functional test case.
    
    TTBoard *board = [[TTBoard alloc] init];
    
    [board markPosition:0 playerCode:1];
    [board markPosition:2 playerCode:2];
    
    //expected slots are 2-8
    NSArray *emptySlots = [board getEmptySpotList];
    
    NSArray *expectedSlots = @[@1,@3,@4,@5,@6,@7,@8];
    
    XCTAssertEqualObjects(emptySlots, expectedSlots);
 
}

- (void)testWinnerHorizontally{
    TTBoard *board = [[TTBoard alloc] init];
    
    /*
       1 1 1
       2 0 2
       0 0 0
     */
    
    [board markPosition:0 playerCode:1];
    [board markPosition:3 playerCode:2];
    [board markPosition:1 playerCode:1];
    [board markPosition:5 playerCode:2];
    [board markPosition:2 playerCode:1];
    
    //expected slots are 2-8
   int winner = [board winner];
    int expectedWinner = 1;
    XCTAssertEqual(expectedWinner, winner);
}

- (void)testWinnerDiagonally{
    TTBoard *board = [[TTBoard alloc] init];
    
    /*
     1 2 2
     0 1 0
     0 0 1
     */

    
    [board markPosition:0 playerCode:1];
    [board markPosition:1 playerCode:2];
    [board markPosition:4 playerCode:1];
    [board markPosition:2 playerCode:2];
    [board markPosition:8 playerCode:1];
    
    //expected slots are 2-8
    int winner = [board winner];
    int expectedWinner = 1;
    XCTAssertEqual(expectedWinner, winner);
}

- (void)testWinnerReverseDiagonally{
    
    /*
     0 2 1
     0 1 2
     1 0 1
     */
    TTBoard *board = [[TTBoard alloc] init];
    
    [board markPosition:2 playerCode:1];
    [board markPosition:1 playerCode:2];
    [board markPosition:4 playerCode:1];
    [board markPosition:5 playerCode:2];
    [board markPosition:6 playerCode:1];
    
    //expected slots are 2-8
    int winner = [board winner];
    int expectedWinner = 1;
    XCTAssertEqual(expectedWinner, winner);
}

//TODO:
//Test winner vertically
//Test rest positions



@end
