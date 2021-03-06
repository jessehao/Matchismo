//
//  SetGame.h
//  Matchismo
//
//  Created by 郝泽 on 2017/7/23.
//  Copyright © 2017年 JesseHao. All rights reserved.
//

#import "CardGame.h"

@class SetCard;

static const NSUInteger SET_GAME_REQUEST_NUMBER = 3;
static const NSUInteger SET_GAME_INITIAL_NUMBER = 12;

static const int COST_TO_REQUEST_ONE = 1;

@interface SetGame : CardGame

@property (strong, nonatomic, readonly) NSArray<SetCard *> *newCards;

#pragma mark - Initialization
- (instancetype)initWithCardCount:(NSUInteger)count;

#pragma mark - Operations
- (BOOL)requestCards;
@end
