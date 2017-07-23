//
//  PlayingCardGameViewController.m
//  Matchismo
//
//  Created by 郝泽 on 2017/6/11.
//  Copyright © 2017年 JesseHao. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "CardMatchingGame.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@interface PlayingCardGameViewController ()

#pragma mark - Properties
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameModeSegmentedController;

@end

@implementation PlayingCardGameViewController

#pragma mark - Getter & Setter
- (CardGame *)game{
    if (!_game) {
        CardMatchingGame *matchingGame = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count];
        matchingGame.matchCount = self.gameModeSegmentedController.selectedSegmentIndex + 2;
        _game = matchingGame;
    }
    return _game;
}

- (CardMatchingGame *)matchingGame{
    return (CardMatchingGame *)_game;
}

#pragma mark - Methods
#pragma mark Override
-(Deck *)createDeck{
    return [[PlayingCardDeck alloc] init];
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

#pragma mark StoryBoard Actions
- (IBAction)changeSegmentedControl:(UISegmentedControl *)sender {
    self.matchingGame.matchCount = sender.selectedSegmentIndex + 2;
}

@end
