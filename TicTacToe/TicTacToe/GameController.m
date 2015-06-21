//
//  ViewController.m
//  TicTacToe
//
//  Created by Bharath Booshan on 6/3/15.
//  Copyright (c) 2015 Personagraph. All rights reserved.
//

#import "GameController.h"
#import  "TTGame.h"
#import  "TTSmartPlayer.h"

@interface GameController ()
{
    TTGame *_currentGame;
    TTPlayer *_humanPlayer;
    TTSmartPlayer *_smartPlayer;
}
- (void)registerForEvents;
- (void)refreshScreen;
@end

@implementation GameController

#pragma mark Private Methods
- (void)refreshScreen{
    
    if( _currentGame == nil ){
        mGameResultLabel.text = @"Will you Start?";
        mHumanTurnButton.enabled=YES;
        mComputerTurnButton.enabled=YES;
    }
    else{
        mGameResultLabel.text=[NSString stringWithFormat:@"Its %@'s Turn", _currentGame.currentPlayer.name];
        //mHumanTurnButton.enabled=NO;
        //mComputerTurnButton.enabled=NO;
    }
}

- (void)registerForEvents{
    //register for  Game and Player Events
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gamePositionUpdated:) name:TTGamePositionUpdatedKey object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gameEnded:) name:TTGameEndedNotificationKey object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(smartPlayerNextMove:) name:TTSmartPlayerPredictedNextPositionKey object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(newGameStarted:) name:TTGameStartedNotificationKey object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerTurnChanged:) name:TTPlayerTurnNotificationKey object:nil];
}

#pragma mark Game Controller Functions

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if( self ){
        
        [self registerForEvents];
        
        [self refreshScreen];
        //Since we are not doing any player management, we stick to two players for now
        _humanPlayer = [[TTPlayer alloc] init];
        _humanPlayer.name = @"Human";
        _humanPlayer.color = [UIColor lightGrayColor];
        
        _smartPlayer = [[TTSmartPlayer alloc] initWithOpponent:_humanPlayer];
        _smartPlayer.name = [UIDevice currentDevice].model;
        _smartPlayer.color = [UIColor darkGrayColor];

        
    }
    return self;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    mTTView.delegate = self;
    mPlayer1NameField.text = _humanPlayer.name;
    mPlayer2NameField.text = _smartPlayer.name;
    
    [self refreshScreen];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark IBAction Methods

- (IBAction)iwillStartAction:(id)sender{
    
    _currentGame = [[TTGame alloc] init];
    [_currentGame startGameWithPlayer1:_humanPlayer player2:_smartPlayer currentPlayer:_humanPlayer];
}

- (IBAction)youWillStartAction:(id)sender{
    _currentGame = [[TTGame alloc] init];
    [_currentGame startGameWithPlayer1:_humanPlayer player2:_smartPlayer currentPlayer:_smartPlayer];
}

#pragma mark TTViewDelegate

-(void)ttView:(TTView *)tView didTapPosition:(int)pos
{
    if( _currentGame.currentPlayer == _humanPlayer){
        [_currentGame markPosition:pos];
    }
}

#pragma mark TTGameEventNotifications

- (void)newGameStarted:(NSNotification *)notif{
    [mTTView reset];
    _smartPlayer.board = [_currentGame currentBoard];
    [self refreshScreen];
}

- (void)gameEnded:(NSNotification *)notif{
    NSNumber *isTied = [notif userInfo][TTGameIsTieKey];
    
    if( ![isTied boolValue]){
        TTPlayer *winner = [notif userInfo][TTGamePlayerKey];
        //TODO - use Localized strings for localization
        
        if( winner.isSmart ){
            mGameResultLabel.text = @"Try Again.. Will you Start?";
        }
        else {
            mGameResultLabel.text = [NSString stringWithFormat:@"Mircale - %@!!, You made it",winner.name];
        }
    }
    else{
        mGameResultLabel.text = @"Its a Tie!! Shall I Start?";
    }
    _currentGame = nil;
    _smartPlayer.board = nil;
    
    mComputerTurnButton.enabled = YES;
    mHumanTurnButton.enabled = YES;

}

- (void)gamePositionUpdated:(NSNotification *)notif
{
    TTPlayer *player = [[notif userInfo] objectForKey:TTGamePlayerKey];
    NSNumber *position = [[notif userInfo] objectForKey:TTGamePositionKey];
    [mTTView mark:player.color atPosition:[position intValue]];
    [self refreshScreen];
}

- (void)playerTurnChanged:(NSNotification *)notif{
    [self refreshScreen];
}

#pragma mark TTSmartPlayerNotifications
- (void)smartPlayerNextMove:(NSNotification *)notif{
    
    if( _currentGame.currentPlayer == _smartPlayer){
        NSNumber *nextPosition = [notif userInfo][TTSmartPlayerPosition];
        [_currentGame markPosition:[nextPosition intValue]];
    }

}



@end
