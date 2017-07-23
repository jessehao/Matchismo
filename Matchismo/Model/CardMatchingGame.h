//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by 郝泽 on 2017/3/25.
//  Copyright © 2017年 JesseHao. All rights reserved.
//

#import "CardGame.h"

@interface CardMatchingGame : CardGame

#pragma mark - Properties
@property(nonatomic) NSUInteger matchCount;

#pragma mark - Initializer
- (instancetype)initWithCardCount:(NSUInteger)count;

@end
