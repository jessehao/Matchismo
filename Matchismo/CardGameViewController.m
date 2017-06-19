//
//  ViewController.m
//  Matchismo
//
//  Created by 郝泽 on 2017/3/23.
//  Copyright © 2017年 JesseHao. All rights reserved.
//

#import "CardGameViewController.h"
#import "Model/CardMatchingGame.h"
@interface CardGameViewController ()

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameModeSegmentedController;
@property (weak, nonatomic) IBOutlet UIButton *restartButton;

@property (strong, nonatomic) Deck *deck;
@property (nonatomic, strong) CardMatchingGame *game;

@end

@implementation CardGameViewController

- (CardMatchingGame *)game{
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count
                                                  usingDeck:self.deck];
        _game.matchCount = self.gameModeSegmentedController.selectedSegmentIndex + 2;
    }
    return _game;
}

- (Deck *)deck{
    if (!_deck) {
        _deck = [self createDeck];
    }
    return _deck;
}

- (Deck *)createDeck{   // abstract
    return nil;
}

- (IBAction)touchCardButton:(UIButton *)sender {
    NSUInteger chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
}

- (IBAction)changeSegmentedControl:(UISegmentedControl *)sender {
    self.game.matchCount = sender.selectedSegmentIndex + 2;
}

- (IBAction)touchRestartButton:(UIButton *)sender {
    self.game = nil;
    self.deck = nil;
    [self updateUI];
}

- (void)updateUI{
    self.gameModeSegmentedController.hidden = self.game.isStarted;
    self.restartButton.hidden = !self.game.isStarted;
    for (UIButton *cardButton in self.cardButtons) {
        if([cardButton isMemberOfClass:[UIButton class]]){
            NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
            Card *card = [self.game cardAtIndex:cardButtonIndex];
            [cardButton setTitle:[self titleForCard: card] forState:UIControlStateNormal];
            [cardButton setBackgroundImage:[self backgroundImageForCard: card] forState:UIControlStateNormal];
            cardButton.enabled = !card.isMatched;
                self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
        }
    }
}

- (NSString *)titleForCard: (Card *)card{
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard: (Card *)card{
    return card.isChosen ? [UIImage imageNamed:@"CardFront"] : [UIImage imageNamed:@"CardBack"];
}


@end
