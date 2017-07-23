//
//  ViewController.m
//  Matchismo
//
//  Created by 郝泽 on 2017/3/23.
//  Copyright © 2017年 JesseHao. All rights reserved.
//

#import "CardGameViewController.h"
#import "CardGame.h"
#import "Deck.h"
#import "Card.h"

@interface CardGameViewController ()

@end

@implementation CardGameViewController

#pragma mark - Getter & Setter
- (Deck *)deck{
    if (!_deck) {
        _deck = [self createDeck];
    }
    return _deck;
}

#pragma mark - Methods
- (NSString *)titleForCard: (Card *)card{
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard: (Card *)card{
    return card.isChosen ? [UIImage imageNamed:@"CardFront"] : [UIImage imageNamed:@"CardBack"];
}

#pragma mark Abstract
- (Deck *)createDeck { return nil; }

- (void)updateUI { return; }

#pragma mark StoryBoard Actions
- (IBAction)touchCardButton:(UIButton *)sender {
    NSUInteger chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
}

- (IBAction)touchRestartButton:(UIButton *)sender {
    self.game = nil;
    self.deck = nil;
    [self updateUI];
}

@end
