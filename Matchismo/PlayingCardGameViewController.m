//
//  PlayingCardGameViewController.m
//  Matchismo
//
//  Created by 郝泽 on 2017/6/11.
//  Copyright © 2017年 JesseHao. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "Model/PlayingCardDeck.h"

@interface PlayingCardGameViewController ()

@end

@implementation PlayingCardGameViewController

-(Deck *)createDeck{
    return [[PlayingCardDeck alloc] init];
}

@end
