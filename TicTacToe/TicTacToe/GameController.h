//
//  ViewController.h
//  TicTacToe
//
//  Created by Bharath Booshan on 6/3/15.
//  Copyright (c) 2015 Personagraph. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTView.h"


@interface GameController : UIViewController<TTViewDelegate>
{
    IBOutlet TTView *mTTView;
    IBOutlet UILabel *mPlayer1NameField;
    IBOutlet UILabel *mPlayer2NameField;
    IBOutlet UILabel *mGameResultLabel;
    IBOutlet UIButton *mComputerTurnButton;
    IBOutlet UIButton *mHumanTurnButton;
    
}

@end

