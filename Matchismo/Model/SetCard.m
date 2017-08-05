//
//  SetCard.m
//  Matchismo
//
//  Created by 郝泽 on 2017/7/23.
//  Copyright © 2017年 JesseHao. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard {
    NSMutableString *_contents;
}

#pragma mark - Properties
-(BOOL)setNumber:(NSUInteger)number{
    if(number < 1 || number > 3){
        NSLog(@"New Value For number in SetCard is Out of Range");
        return false;
    }
    _number = number;
    return true;
}

#pragma mark - Initialization
- (instancetype)initWithNumber:(NSUInteger)number
                        symbol:(SCSymbolType)symbol
                       shading:(SCShadingType)shading
                         color:(SCColorType)color
{
    self = [super init];
    if (self && [self setNumber:number]) {
        _symbol = symbol;
        _shading = shading;
        _color = color;
    } else {
        self = nil;
    }
    return self;
}

#pragma mark - Override
- (int)match:(NSArray *)otherCards{
    SetCard *firstCard = (SetCard *)otherCards.firstObject;
    SetCard *lastCard = (SetCard *)otherCards.lastObject;
    BOOL sameNumber = firstCard.number == lastCard.number;
    BOOL sameSymbol = firstCard.symbol == lastCard.symbol;
    BOOL sameColor = firstCard.color == lastCard.color;
    BOOL sameShading = firstCard.shading == lastCard.shading;
    for (SetCard *card1 in otherCards) {
        for(SetCard *card2 in otherCards) {
            if(card1 == card2)
                continue;
            if(sameNumber ^ (card1.number == card2.number) ||
               sameColor ^ (card1.color == card2.color) ||
               sameSymbol ^ (card1.symbol == card2.symbol) ||
               sameShading ^ (card1.shading == card2.shading))
                return 0;
        }
    }
    return 1;
}

@end
