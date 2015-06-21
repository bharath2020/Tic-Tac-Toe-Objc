//
//  TTView.m
//  TicTacToe
//
//  Created by Bharath Booshan on 6/4/15.
//  Copyright (c) 2015 Personagraph. All rights reserved.
//

#import "TTView.h"

@interface TTView()
{
    NSMutableArray *tapLayers;
}
@end

@implementation TTView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)createTicTacToeMatrixViews{
    
    
    CGFloat width= self.frame.size.width/3.0, height=self.frame.size.height/3.0, yPos=0.0;
    for ( int row=0; row < 3; row++ )
    {
        for (int col=0; col<3; col++) {
            CALayer *tapLayer  = [CALayer layer];
            tapLayer.frame = CGRectMake(col * width, yPos , width, height);
            tapLayer.borderWidth = 1.0;
            tapLayer.borderColor = [[UIColor orangeColor] CGColor];
            tapLayer.backgroundColor = [[UIColor whiteColor] CGColor];
            [tapLayers addObject:tapLayer];
            
            [self.layer addSublayer:tapLayer];
        }
        yPos+=height;
    }
}

- (void)resetLayers{
    
    for ( CALayer *layer in tapLayers ){
        layer.backgroundColor = [[UIColor whiteColor] CGColor];
    }
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    if( self)
    {
        tapLayers = [NSMutableArray array];
        [self createTicTacToeMatrixViews];
        
        UIGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
        [self addGestureRecognizer:tapGesture];
        
    }
    return self;
}

- (void)tapGesture:(UIGestureRecognizer *)gesture{
    
    CGPoint pointInBounds = [gesture locationInView:self];
    NSUInteger totalLayers =[tapLayers count];
    for ( NSUInteger pos=0; pos < totalLayers; pos++ ){
        CALayer *layer = tapLayers[pos];
        if( CGRectContainsPoint(layer.frame, pointInBounds)){
            [self.delegate ttView:self didTapPosition:(int)pos];
            break;
        }
    }
}

-(void)mark:(UIColor *)color atPosition:(int)pos
{
    if( pos < [tapLayers count]){
        CALayer *layer = tapLayers[pos];
        layer.backgroundColor = [color CGColor];
    }
}

-(void)reset{
    for ( CALayer *layer in tapLayers ){
        layer.backgroundColor = [[UIColor whiteColor] CGColor];
    }
}

@end
