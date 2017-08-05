//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by 郝泽 on 2017/3/25.
//  Copyright © 2017年 JesseHao. All rights reserved.
//

#import "CardMatchingGame.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@interface CardMatchingGame()

@end

@implementation CardMatchingGame

#pragma mark - Properties
@synthesize matchCount = _matchCount;

- (void)setMatchCount:(NSUInteger)matchCount{
    if (self.isStarted) {
        return;
    }
    if (matchCount > 1) {
        _matchCount = matchCount;
    } else {
        _matchCount = 2;    }
}

- (NSUInteger)matchCount{

    if (_matchCount < 2) {
        _matchCount = 2;
    }
    return _matchCount;
}

#pragma mark - Initialization
- (instancetype)initWithCardCount:(NSUInteger)count{
    self = [super initWithCardCount:count usingDeck:[[PlayingCardDeck alloc] init]];
    return self;
}

#pragma mark - Override
- (void)chooseCardAtIndex:(NSUInteger)index{
    self.started = YES;
    Card *card = [self cardAtIndex:index];
    if(!card.isMatched){
        if(card.isChosen){
            card.chosen = NO;
            [self.chosenCards removeObject:card];
        }else{
            [self.chosenCards addObject:card];
            if (self.chosenCards.count == self.matchCount) {
                int maxMatchScore = 0;
                for (Card *chosenCard in self.chosenCards) {
                    if ([chosenCard isKindOfClass:[Card class]]) {
                        int currentMatchScore = [chosenCard match:self.chosenCards];
                        maxMatchScore = currentMatchScore > maxMatchScore ? currentMatchScore : maxMatchScore;
                    }
                }
                if (maxMatchScore) {
                    for (Card *chosenCard in self.chosenCards) {
                        if([chosenCard isKindOfClass:[Card class]]){
                            chosenCard.matched = YES;
                        }
                    }
                    card.matched = YES;
                    self.score += maxMatchScore * MATCH_BONUS;
                    [self.chosenCards removeAllObjects];
                }else{
                    for (Card *chosenCard in self.chosenCards) {
                        if([chosenCard isKindOfClass:[Card class]]){
                            chosenCard.chosen = NO;
                            self.score -= MISMATCH_PENALTY;
                        }
                    }
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
