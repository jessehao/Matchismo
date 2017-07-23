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

#pragma mark - Getter & Setter
-(BOOL)setNumber:(NSUInteger)number{
    if(number < 1 || number > 3){
        NSLog(@"New Value For number in SetCard is Out of Range");
        return false;
    }
    _number = number;
    return true;
}

-(BOOL)setSymbol:(NSString *)symbol{
    if([[SetCard validSymbol] containsObject:symbol]){
        _symbol = symbol;
        return true;
    }
    else{
        NSLog(@"invalid new symbol");
        return false;
    }
}

-(NSString *)contents{
    if (!_contents) {
        _contents = [[NSMutableString alloc] init];
        for(int i = 1; i<=self.number; i++){
            [_contents appendString:self.symbol];
        }
    }
    return _contents;
}

#pragma mark - Initializer
- (instancetype)initWithNumber:(NSUInteger)number
                        symbol:(NSString *)symbol
                       shading:(SCShadingType)shading
                         color:(SCColorType)color
{
    self = [super init];
    if (self && [self setSymbol:symbol] && [self setNumber:number]) {
        _shading = shading;
        _color = color;
    } else {
        self = nil;
    }
    return self;
}

#pragma mark - Methods
+ (NSArray *)validSymbol{
    return @[@"▲",@"●",@"■"];
}

#pragma mark Instance
- (int)match:(NSArray *)otherCards{
    SetCard *firstCard = (SetCard *)otherCards.firstObject;
    SetCard *lastCard = (SetCard *)otherCards.lastObject;
    BOOL sameNumber = firstCard.number == lastCard.number;
    BOOL sameSymbol = [firstCard.symbol isEqualToString:lastCard.symbol];
    BOOL sameColor = firstCard.color == lastCard.color;
    BOOL sameShading = firstCard.shading == lastCard.shading;
    for (SetCard *card1 in otherCards) {
        for(SetCard *card2 in otherCards) {
            if(card1 == card2)
                continue;
            if(sameNumber ^ (card1.number == card2.number) ||
               sameColor ^ (card1.color == card2.color) ||
               sameSymbol ^ [card1.symbol isEqualToString:card2.symbol] ||
               sameShading ^ (card1.shading == card2.shading))
                return 0;
        }
    }
    return 1;
}

@end
