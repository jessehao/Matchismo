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

@interface CardGame : NSObject
@property(nonatomic) NSInteger score;
@property(nonatomic, strong) NSMutableArray *cards;
@property(nonatomic, strong) NSMutableArray *chosenCards;
@property(nonatomic, getter=isStarted) BOOL started;
//designate initializer
-(instancetype)initWithCardCount: (NSUInteger)count
                       usingDeck: (Deck *) deck;

-(Card *)cardAtIndex: (NSUInteger)index;

#pragma MARK : Protected Methods
-(void)chooseCardAtIndex: (NSUInteger)index;    // abstract

@end
