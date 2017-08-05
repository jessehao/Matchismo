//
//  SetCard.h
//  Matchismo
//
//  Created by 郝泽 on 2017/7/23.
//  Copyright © 2017年 JesseHao. All rights reserved.
//

#import "Card.h"
#import "../Enums.h"

@interface SetCard : Card

@property(nonatomic, readonly) NSUInteger number;
@property(nonatomic, readonly) SCSymbolType symbol;
@property(nonatomic, readonly) SCShadingType shading;
@property(nonatomic, readonly) SCColorType color;

#pragma mark - Initialization
- (instancetype)initWithNumber:(NSUInteger)number
                        symbol:(SCSymbolType)symbol
                       shading:(SCShadingType)shading
                         color:(SCColorType)color;
@end
