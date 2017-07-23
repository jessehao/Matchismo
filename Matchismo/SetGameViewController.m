//
//  SetGameViewController.m
//  Matchismo
//
//  Created by 郝泽 on 2017/7/23.
//  Copyright © 2017年 JesseHao. All rights reserved.
//

#import "SetGameViewController.h"
#import "SetGame.h"
#import "SetCard.h"
#import "SetCardDeck.h"

@interface SetGameViewController ()

@end

@implementation SetGameViewController

#pragma mark - Getter & Setter
- (CardGame *)game{
    if(!_game){
        _game = [[SetGame alloc] initWithCardCount:self.cardButtons.count];
    }
    return _game;
}

-(SetGame *)setGame{
    return (SetGame *)_game;
}

#pragma mark - Methods
- (UIColor *)getColorFrom:(SCColorType)color{
    switch (color) {
        case SCColorRed:
            return [UIColor redColor];
            break;
        case SCColorGreen:
            return [UIColor greenColor];
            break;
        case SCColorPurple:
            return [UIColor purpleColor];
            break;
        default:
            break;
    }
}

- (NSDictionary *)attributesFor:(SetCard *)card {
    if (!card.isChosen)
        return nil;
    UIColor *color = [self getColorFrom:card.color];
    switch (card.shading) {
        case SCShadingOpen:
            return @{ NSStrokeWidthAttributeName : @7,
                      NSStrokeColorAttributeName : color,
                      NSForegroundColorAttributeName : color };
            break;
        case SCShadingSolid:
            return @{ NSForegroundColorAttributeName : color };
            break;
        case SCShadingStriped:
            return @{ NSForegroundColorAttributeName : color,
                      NSStrokeColorAttributeName : [UIColor blackColor],
                      NSStrokeWidthAttributeName : @-7 };
            break;
        default:
            return nil;
            break;
    }
}

#pragma mark Override
-(Deck *)createDeck{
    return [[SetCardDeck alloc] init];
}

-(void)updateUI{
    self.restartButton.hidden = !self.game.isStarted;
    for (UIButton *cardButton in self.cardButtons) {
        if ([cardButton isMemberOfClass:[UIButton class]]) {
            NSUInteger index = [self.cardButtons indexOfObject:cardButton];
            Card *card = [self.game cardAtIndex:index];
            [cardButton setAttributedTitle:[[NSAttributedString alloc] initWithString:[self titleForCard:card]
                                                                           attributes:[self attributesFor:(SetCard *)card]]
                                  forState:UIControlStateNormal];
            [cardButton setBackgroundImage:[self backgroundImageForCard:card]
                                  forState:UIControlStateNormal];
            cardButton.enabled = !card.isMatched;
            self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
        }
    }
}

@end
