//
//  ViewController.h
//  Matchismo
//
//  Created by 郝泽 on 2017/3/23.
//  Copyright © 2017年 JesseHao. All rights reserved.
//
// Abstract Class. Must implement methods as  described below

#import <UIKit/UIKit.h>

@class CardGame;
@class Deck;
@class Card;
@class CardView;
@class Grid;


@interface CardGameViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *boardView;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UIButton *restartButton;

@property (strong, nonatomic) CardGame *game;
@property (strong, nonatomic) NSMutableArray<CardView *> *cardViews;
@property (strong, nonatomic, readonly) Grid  *grid;
- (CGRect)mainViewBounds;

#pragma mark - Operations
- (void)updateUI;

#pragma mark - Abstract
- (CardView *)newCardViewWithFrame:(CGRect)frame;
- (void)setup;
- (BOOL)mapCard:(Card *)card toView:(CardView *)view;

@end

