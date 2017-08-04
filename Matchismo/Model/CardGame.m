//
//  CardGame.m
//  Matchismo
//
//  Created by 郝泽 on 2017/4/23.
//  Copyright © 2017年 JesseHao. All rights reserved.
//

#import "CardGame.h"
#import "Deck.h"
#import "Card.h"

@interface CardGame()
@property (strong, nonatomic, readwrite) Deck *deck;
@end

@implementation CardGame

#pragma mark - Getter & Setter
-(NSMutableArray *)chosenCards{
    if (!_chosenCards) {
        _chosenCards = [[NSMutableArray alloc] init];
    }
    return _chosenCards;
}

-(NSMutableArray *)cards{
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    return _cards;
}

#pragma mark - Initializer
-(instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck{
    self = [super init];
    if (self) {
        self.deck = deck;
        for (int i = 0; i<count; i++) {
            Card *card = [self.deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            }else{
                self = nil;
                break;
            }
        }
        self.started = NO;
    }
    return self;
}

#pragma mark - Methods

- (Card *)cardAtIndex:(NSUInteger)index{
    Card *result = nil;
    if(index < self.cards.count){
        result = self.cards[index];
        if(![result isKindOfClass:[Card class]]){
            result = nil;
        }
    }
    return result;
}

#pragma mark Abstract
- (void)chooseCardAtIndex:(NSUInteger)index { return; } //abstract

@end
