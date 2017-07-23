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

@interface CardGameViewController : UIViewController{
    @protected
    CardGame *_game;
    Deck *_deck;
}
#pragma mark - Properties
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UIButton *restartButton;

@property (nonatomic, strong) CardGame *game;
@property (strong, nonatomic) Deck *deck;

#pragma mark - Methods
- (NSString *)titleForCard: (Card *)card;
- (UIImage *)backgroundImageForCard: (Card *)card;

#pragma mark Abstract
- (Deck *)createDeck;
- (void)updateUI;

@end

