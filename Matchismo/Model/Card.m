//
//  Card.m
//  Matchismo
//
//  Created by 郝泽 on 2017/3/22.
//  Copyright © 2017年 郝泽. All rights reserved.
//

#import "Card.h"

@interface Card()

@end

@implementation Card

#pragma mark - Operations
- (int)match:(NSArray *)otherCards{
    int score = 0;
    for(Card* card in otherCards){
        if([card isKindOfClass:[Card class]] && [card.contents isEqualToString:self.contents])
            score = 1;
    }
    return score;
}

@end
