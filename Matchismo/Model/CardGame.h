//
//  CardGame.h
//  Matchismo
//
//  Created by 郝泽 on 2017/4/23.
//  Copyright © 2017年 JesseHao. All rights reserved.
//
// Abstract Class. Must implement methods as  described below

#import <Foundation/Foundation.h>

@class Deck;
@class Card;

static const int COST_TO_CHOOSE = 1;
static const int MATCH_BONUS = 4;
static const int MISMATCH_PENALTY = 2;

@interface CardGame : NSObject

#pragma mark - Properties
@property(nonatomic) NSInteger score;
@property(nonatomic, strong) NSMutableArray *cards;
@property(nonatomic, strong) NSMutableArray *chosenCards;
@property(nonatomic, getter=isStarted) BOOL started;

#pragma mark - Initializer
//designate initializer
-(instancetype)initWithCardCount: (NSUInteger)count
                       usingDeck: (Deck *) deck;

#pragma mark - Methods
-(Card *)cardAtIndex: (NSUInteger)index;

#pragma mark Abstract
-(void)chooseCardAtIndex: (NSUInteger)index;    // abstract

@end
