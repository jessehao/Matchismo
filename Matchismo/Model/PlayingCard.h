//
//  PlayingCard.h
//  Matchismo
//
//  Created by 郝泽 on 2017/3/23.
//  Copyright © 2017年 JesseHao. All rights reserved.
//

#import "Card.h"
@class Deck;

@interface PlayingCard : Card

#pragma mark - Properties
@property (nonatomic, strong) NSString *suit;
@property (nonatomic) NSUInteger rank;

#pragma mark - Methods
+(NSArray *)validSuits;
+(NSUInteger)maxRank;

@end
