//
//  TTGameAITests.m
//  TicTacToe
//
//  Created by Bharath Booshan on 6/14/15.
//  Copyright (c) 2015 Personagraph. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "TTPlayer.h"
#import "TTSmartPlayer.h"
#import "TTBoard.h"
#import "TTGameAI.h"

@interface TTGameAITests : XCTestCase
{
    TTGameAI *_AI;
    TTPlayer *_humanPlayer;
    TTPlayer *_smartPlayer;
}
- (void)testForPredictingNextPosition:(int)position inBoard:(TTBoard *)board testCaseName:(NSString *)name;
@end

@implementation TTGameAITests

- (void)testForPredictingNextPosition:(int)position inBoard:(TTBoard *)board testCaseName:(NSString *)name
{
    XCTestExpectation *expectation = [self expectationWithDescription:name];
    
    [_AI predictNextPositionForBoard:board completionHandler:^(int predeictedPosition, TTBoard *boardInContext) {
        XCTAssertEqual(position, predeictedPosition, @"Test : %@", name);
        [expectation fulfill];
    }];
    
    //Now it is Smart players turn
    [self waitForExpectationsWithTimeout:4.0 handler:^(NSError *error) {
        NSLog(@"%@", error);
    }];

}

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    _humanPlayer = [[TTPlayer alloc] init];
    _humanPlayer.playerCode=1;
    
    _smartPlayer = [[TTSmartPlayer alloc] init];
    _smartPlayer.playerCode=2;
    
    _AI = [[TTGameAI alloc] initWithHostPlayer:_smartPlayer opponent:_humanPlayer];
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testPreventHumanToWinInFirstRow {
    TTBoard *board = [[TTBoard alloc] init];
    
    //Lets us bring the board to following state
    //Human =1 , SmartPlayer= 2
    /*
      1 0 1
      2 0 0
      2 0 0
     */
    
    [board markPosition:3 playerCode:_smartPlayer.playerCode];
    [board markPosition:0 playerCode:_humanPlayer.playerCode];
    [board markPosition:6 playerCode:_smartPlayer.playerCode];
    [board markPosition:2 playerCode:_humanPlayer.playerCode];
    
    [self testForPredictingNextPosition:1 inBoard:board testCaseName:@"prevent_horizontal_win"];
    
}

- (void)testPreventHumanToWinSecondRow {
    TTBoard *board = [[TTBoard alloc] init];
    
    //Lets us bring the board to following state
    //Human =1 , SmartPlayer= 2
    /*
     2 0 0
     1 0 1
     0 2 0
     */
    
    [board markPosition:0 playerCode:_smartPlayer.playerCode];
    [board markPosition:3 playerCode:_humanPlayer.playerCode];
    [board markPosition:7 playerCode:_smartPlayer.playerCode];
    [board markPosition:5 playerCode:_humanPlayer.playerCode];
    
    [self testForPredictingNextPosition:4 inBoard:board testCaseName:@"prevent_horizontal_win"];
    
}

- (void)testPreventHumanToWinThirdRow {
    TTBoard *board = [[TTBoard alloc] init];
    
    //Lets us bring the board to following state
    //Human =1 , SmartPlayer= 2
    /*
     0 0 2
     2 0 0
     1 0 1
     */
    
    [board markPosition:3 playerCode:_smartPlayer.playerCode];
    [board markPosition:6 playerCode:_humanPlayer.playerCode];
    [board markPosition:2 playerCode:_smartPlayer.playerCode];
    [board markPosition:8 playerCode:_humanPlayer.playerCode];
    
    [self testForPredictingNextPosition:7 inBoard:board testCaseName:@"prevent_horizontal_win"];
    
}


- (void)testSmartPlayerAlwaysWinWhenPossible{
    
    TTBoard *board = [[TTBoard alloc] init];
    
    //Lets us bring the board to following state
    //Human =1 , SmartPlayer= 2
    /*
     1 0 1
     2 2 0
     0 0 0
     */
    
    [board markPosition:3 playerCode:_smartPlayer.playerCode];
    [board markPosition:0 playerCode:_humanPlayer.playerCode];
    [board markPosition:4 playerCode:_smartPlayer.playerCode];
    [board markPosition:2 playerCode:_humanPlayer.playerCode];
    
    [self testForPredictingNextPosition:5 inBoard:board testCaseName:@"testSmartPlayerAlwaysWinWhenPossible"];
}

//TODO:
// Test if smart player wins in all directions
// Test if AI prevents from hum winning in diagonal and vertical directions



@end
