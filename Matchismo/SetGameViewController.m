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
        return NO;
    }
    SetCardView *scView = (SetCardView *)view;
    SetCard *sCard = (SetCard *)card;
    scView.symbol = sCard.symbol;
    scView.shading = sCard.shading;
    scView.color = sCard.color;
    scView.number = sCard.number;
    if (scView.enabled == YES && sCard.isMatched == YES) {
        scView.enabled = NO;
        [self popCardView:scView];
    } else if (!sCard.isMatched) {
        scView.enabled = YES;
    }
    scView.selected = sCard.isChosen;
    return YES;
}

#pragma mark - Actions
#pragma mark Storyboard
- (IBAction)edgePan:(UIScreenEdgePanGestureRecognizer *)sender { // Testing
    if (sender.state ==UIGestureRecognizerStateEnded) {
//        if ([self.setGame requestCards]) {
//            [self addNewCards];
//        }
        [self pushCardView:nil atIndex:3];
    }
}

#pragma mark - Operations
- (void)addNewCards {
    if (!self.setGame.newCards.count)
        return;
    self.grid.minimumNumberOfCells += self.setGame.newCards.count;
    if (![self.grid inputsAreValid]) {
        NSLog(@"%@ : Grid Inputs Not Valid", self);
        return;
    }
    for (SetCard *card in self.setGame.newCards) {
        CGRect frame = CGRectMake(0, 0, self.grid.cellSize.width, self.grid.cellSize.height);
        SetCardView *newCardView = [[SetCardView alloc] initWithFrame:frame];
        if (![self mapCard:card toView:newCardView]) {
            NSLog(@"%@ : CANNOT MAP MODEL TO VIEW", self);
            return;
        }
        [self.cardViews addObject:newCardView];
        NSUInteger index = self.cardViews.count - 1;
        [self pushCardView:newCardView atIndex:index];
    }
}

@end
