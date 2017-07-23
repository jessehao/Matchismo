//
//  SetGame.m
//  Matchismo
//
//  Created by 郝泽 on 2017/7/23.
//  Copyright © 2017年 JesseHao. All rights reserved.
//

#import "SetGame.h"
#import "SetCard.h"
#import "SetCardDeck.h"

@implementation SetGame

#pragma mark - Initializer
- (instancetype)initWithCardCount:(NSUInteger)count{
    self = [super initWithCardCount:count usingDeck:[[SetCardDeck alloc] init]];
    return self;
}

#pragma mark - Methods

#pragma mark Override
- (void)chooseCardAtIndex:(NSUInteger)index{
    self.started = YES;
    Card *card = [self cardAtIndex:index];
    if(!card.isMatched) {
        if(card.isChosen) {
            card.chosen = NO;
            [self.chosenCards removeObject:card];
        } else {
            [self.chosenCards addObject:card];
            if (self.chosenCards.count == 3) {
                if([card match:self.chosenCards]) {
                    for(Card *card in self.chosenCards)
                        card.matched = YES;
                    self.score += MATCH_BONUS * 5;
                    [self.chosenCards removeAllObjects];
                    
                }
                else{
                    for(Card *chosenCard in self.chosenCards){
                        chosenCard.chosen = NO;
                    }
                    self.score -= MISMATCH_PENALTY;
                    [self.chosenCards removeAllObjects];
                    [self.chosenCards addObject:card];
                }
            }
            card.chosen = YES;
            self.score -= COST_TO_CHOOSE;
        }
    }
}

@end
