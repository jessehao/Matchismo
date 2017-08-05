//
//  PlayingCard.m
//  Matchismo
//
//  Created by 郝泽 on 2017/3/23.
//  Copyright © 2017年 JesseHao. All rights reserved.
//

#import "PlayingCard.h"
#import "Deck.h"

@implementation PlayingCard

#pragma mark - Properties

@synthesize suit = _suit;

-(NSString *)contents{
    NSArray *rankString = [PlayingCard rankStrings];
    return [rankString[self.rank] stringByAppendingString:self.suit];
}

-(void)setRank:(NSUInteger)rank{
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

-(void)setSuit:(NSString *)suit{
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

-(NSString *)suit{
    return _suit ? _suit : @"?";
}

#pragma mark - Override
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

#pragma mark - Methods
+(NSArray *)validSuits{
    return @[@"♥︎", @"♦︎", @"♠︎", @"♣︎"];
}

+(NSArray *)rankStrings{
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

+(NSUInteger)maxRank{
    return [self rankStrings].count-1;
}

@end
