//
//  CardGame.m
//  Matchismo
//
//  Created by 郝泽 on 2017/4/23.
//  Copyright © 2017年 JesseHao. All rights reserved.
//

#import "CardGame.h"

@interface CardGame()

@end

@implementation CardGame

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

-(instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck{
    self = [super init];
    if (self) {
        for (int i = 0; i<count; i++) {
            Card *card = [deck drawRandomCard];
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

//abstract
-(void)chooseCardAtIndex:(NSUInteger)index { return; }

//abstract
-(Card *)cardAtIndex:(NSUInteger)index { return nil; }

@end
