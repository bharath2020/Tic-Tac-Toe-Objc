//
//  TTView.h
//  TicTacToe
//
//  Created by Bharath Booshan on 6/4/15.
//  Copyright (c) 2015 Personagraph. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TTView;

@protocol TTViewDelegate
-(void)ttView:(TTView *)tView didTapPosition:(int)pos;
@end

@interface TTView : UIView

@property(nonatomic,unsafe_unretained)id<TTViewDelegate> delegate;

-(void)mark:(UIColor *)color atPosition:(int)pos;
-(void)reset;
@end
