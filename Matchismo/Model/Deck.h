//
//  Deck.h
//  Matchismo
//
//  Created by 郝泽 on 2017/3/22.
//  Copyright © 2017年 郝泽. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

-(void) addCard:(Card *)card atTop:(BOOL)atTop;
-(void) addCard:(Card *)card;

-(Card *)drawRandomCard;

@end
