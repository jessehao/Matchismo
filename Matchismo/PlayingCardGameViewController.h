//
//  PlayingCardGameViewController.h
//  Matchismo
//
//  Created by 郝泽 on 2017/6/11.
//  Copyright © 2017年 JesseHao. All rights reserved.
//

#import "CardGameViewController.h"

@class CardMatchingGame;

@interface PlayingCardGameViewController : CardGameViewController

#pragma mark - Properties
@property(nonatomic, strong, readonly) CardMatchingGame *matchingGame;

@end
