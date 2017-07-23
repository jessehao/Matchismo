//
//  SetCard.h
//  Matchismo
//
//  Created by 郝泽 on 2017/7/23.
//  Copyright © 2017年 JesseHao. All rights reserved.
//

#import "Card.h"

typedef enum {
    SCShadingSolid = 0,
    SCShadingStriped = 1,
    SCShadingOpen = 2
}SCShadingType;

typedef enum{
    SCColorRed = 0,
    SCColorGreen = 1,
    SCColorPurple = 2
}SCColorType;

@interface SetCard : Card
#pragma mark - Properties
@property(nonatomic, readonly) NSUInteger number;
@property(nonatomic, strong, readonly) NSString *symbol;
@property(nonatomic, readonly) SCShadingType shading;
@property(nonatomic, readonly) SCColorType color;

#pragma mark - Initializer
- (instancetype)initWithNumber:(NSUInteger)number
                        symbol:(NSString *)symbol
                       shading:(SCShadingType)shading
                         color:(SCColorType)color;

#pragma mark - Methods
+ (NSArray *)validSymbol;
@end
