//
//  Deck.m
//  Matchismo
//
//  Created by 郝泽 on 2017/3/22.
//  Copyright © 2017年 郝泽. All rights reserved.
//

#import "Deck.h"
#import "Card.h"

@interface Deck()

@property(strong, nonatomic) NSMutableArray<Card *> *cards;

@end

@implementation Deck

#pragma mark - Properties
//这里只是重写了Getter，没有重写Setter，所以不用写@synthesize
-(NSMutableArray *)cards{
    if(!_cards)
        _cards = [[NSMutableArray alloc] init];
    return _cards;
}

#pragma mark - Operations
-(void)addCard:(Card *)card atTop:(BOOL)atTop{
    if (atTop) {
        [self.cards insertObject:card atIndex:0];
    }else{
        [self.cards addObject:card];
    }
}

-(void)addCard:(Card *)card{
    [self addCard:card atTop:false];
}

-(Card *)drawRandomCard{
    Card* result = nil;
    if (self.cards.count) {
        unsigned index = arc4random() % self.cards.count;
        result = self.cards[index];
        [self.cards removeObjectAtIndex:index];
    }
    return result;
}

@end
