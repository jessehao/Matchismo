//
//  SetGameViewController.m
//  Matchismo
//
//  Created by 郝泽 on 2017/7/23.
//  Copyright © 2017年 JesseHao. All rights reserved.
//

#import "SetGameViewController.h"
#import "SetGame.h"
#import "SetCard.h"
#import "SetCardDeck.h"
#import "SetCardView.h"
#import "Grid.h"

@implementation SetGameViewController

@synthesize game = _game;

#pragma mark - Properties
- (CardGame *)game{
    if(!_game){
        _game = [[SetGame alloc] init];
    }
    return _game;
}

-(SetGame *)setGame{
    return (SetGame *)self.game;
}

#pragma mark Override
- (CardView *)newCardViewWithFrame:(CGRect)frame { return [[SetCardView alloc] initWithFrame:frame]; }

- (BOOL)mapCard:(Card *)card toView:(CardView *)view {
    if (![card isKindOfClass:[SetCard class]] ||
        ![view isKindOfClass:[SetCardView class]]) {
        NSLog(@"CANNOT MAP SET CARD TO SET CARD VIEW");
        return NO;
    }
    SetCardView *scView = (SetCardView *)view;
    SetCard *sCard = (SetCard *)card;
    scView.symbol = sCard.symbol;
    scView.shading = sCard.shading;
    scView.color = sCard.color;
    scView.number = sCard.number;
    scView.selected = sCard.isChosen;
    scView.enabled = !sCard.isMatched;
    return YES;
}

#pragma mark - Actions
#pragma mark Gestures
- (IBAction)edgePan:(UIScreenEdgePanGestureRecognizer *)sender {
    if (sender.state ==UIGestureRecognizerStateEnded) {
        if ([self.setGame requestCards]) {
            [self updateUI];
        }
    }
}

@end
