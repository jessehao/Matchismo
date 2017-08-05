//
//  PlayingCardGameViewController.h
//  Matchismo
//
//  Created by 郝泽 on 2017/6/11.
//  Copyright © 2017年 JesseHao. All rights reserved.
//

#import "CardGameViewController.h"

@class CardMatchingGame;

static const NSUInteger PLAYING_CARD_GAME_INITIAL_CARD_NUMBER = 30;

@interface PlayingCardGameViewController : CardGameViewController

@property(nonatomic, strong, readonly) CardMatchingGame *matchingGame;

@end
