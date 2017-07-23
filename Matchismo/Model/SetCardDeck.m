//
//  SetCardDeck.m
//  Matchismo
//
//  Created by 郝泽 on 2017/7/23.
//  Copyright © 2017年 JesseHao. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

#pragma mark - Initializer
-(instancetype)init {
    self = [super init];
    if(self)
        for(int number = 1; number <= 3; number++)
            for(NSString *symbol in [SetCard validSymbol])
                for(int color = 0; color < 3; color++)
                    for(int shading = 0; shading < 3; shading++)
                        [self addCard:[[SetCard alloc] initWithNumber:number
                                                               symbol:symbol
                                                              shading:shading
                                                                color:color]];
    return self;
}

@end
