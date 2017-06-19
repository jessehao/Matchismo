//
//  CardGame.h
//  Matchismo
//
//  Created by 郝泽 on 2017/4/23.
//  Copyright © 2017年 JesseHao. All rights reserved.
//
// Abstract Class. Must implement methods as  described below

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"

@interface CardGame : NSObject{
    @protected
    NSInteger _score;
}
@property(nonatomic) NSInteger score;
@property(nonatomic, strong) NSMutableArray *cards;
@property(nonatomic, strong) NSMutableArray *chosenCards;
@property(nonatomic, getter=isStarted) BOOL started;
//designate initializer
-(instancetype)initWithCardCount: (NSUInteger)count
                       usingDeck: (Deck *) deck;

//Protected
-(void)chooseCardAtIndex: (NSUInteger)index;    // abstract
-(Card *)cardAtIndex: (NSUInteger)index;    // abstract

@end
