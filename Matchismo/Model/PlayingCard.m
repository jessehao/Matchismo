//
//  PlayingCard.m
//  Matchismo
//
//  Created by 郝泽 on 2017/3/23.
//  Copyright © 2017年 JesseHao. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

-(NSString *)contents{
    NSArray *rankString = [PlayingCard rankStrings];
    return [rankString[self.rank] stringByAppendingString:self.suit];
}

+(NSArray *)validSuits{
    return @[@"♥︎", @"♦︎", @"♠︎", @"♣︎"];
}

+(NSArray *)rankStrings{
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

+(NSUInteger)maxRank{
    return [self rankStrings].count-1;
}

+(Deck *)createPlayingCardDeck{
    Deck* deck = [[Deck alloc] init];
    for(NSString *suit in [PlayingCard validSuits]){
        for( NSUInteger rank = 1; rank <= [PlayingCard maxRank]; rank++){
            PlayingCard *card = [[PlayingCard alloc] init];
            card.rank = rank;
            card.suit = suit;
            [deck addCard:card];
        }
    }
    return deck;
}

-(void)setRank:(NSUInteger)rank{
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

@synthesize suit = _suit;

-(void)setSuit:(NSString *)suit{
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

-(NSString *)suit{
    return _suit ? _suit : @"?";
}

-(int)match:(NSArray *)otherCards{
    int score = 0;
    for (PlayingCard *card in otherCards) {
        if (self == card) {
            continue;
        }
        if(card.rank == self.rank){
            score += 4;
        }else if([card.suit isEqualToString:self.suit]){
            score += 1;
        }
    }
    return score;
}

@end
