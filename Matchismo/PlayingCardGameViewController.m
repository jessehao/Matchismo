//
//  PlayingCardGameViewController.m
//  Matchismo
//
//  Created by 郝泽 on 2017/6/11.
//  Copyright © 2017年 JesseHao. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardView.h"
#import "CardMatchingGame.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"
#import "Grid.h"

@interface PlayingCardGameViewController () 
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameModeSegmentedController;
@end

@implementation PlayingCardGameViewController

@synthesize game = _game;

#pragma mark - Properties
- (CardGame *)game{
    if (!_game) {
        CardMatchingGame *matchingGame = [[CardMatchingGame alloc] initWithCardCount:PLAYING_CARD_GAME_INITIAL_CARD_NUMBER];
        matchingGame.matchCount = self.gameModeSegmentedController.selectedSegmentIndex + 2;
        _game = matchingGame;
    }
    return _game;
}

- (CardMatchingGame *)matchingGame{
    return (CardMatchingGame *)self.game;
}

#pragma mark - Override
- (CardView *)newCardViewWithFrame:(CGRect)frame { return [[PlayingCardView alloc] initWithFrame:frame]; }

- (void)updateUI{
    self.gameModeSegmentedController.hidden = self.game.isStarted;
    [super updateUI];
}

- (BOOL)mapCard:(Card *)card toView:(CardView *)view {
    if (![card isKindOfClass:[PlayingCard class]] ||
        ![view isKindOfClass:[PlayingCardView class]]) {
        return NO;
    }
    PlayingCardView *pcView = (PlayingCardView *)view;
    PlayingCard *pCard = (PlayingCard *)card;
    pcView.rank = pCard.rank;
    pcView.suit = pCard.suit;
    pcView.selected = pCard.isChosen;
    pcView.enabled = !pCard.isMatched;
    return YES;
}

#pragma mark - Actions
#pragma mark Storyboard
- (IBAction)changeSegmentedControl:(UISegmentedControl *)sender {
    self.matchingGame.matchCount = sender.selectedSegmentIndex + 2;
}
@end
