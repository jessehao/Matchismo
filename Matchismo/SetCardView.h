//
//  SetCardView.h
//  Matchismo
//
//  Created by 郝泽 on 2017/7/31.
//  Copyright © 2017年 JesseHao. All rights reserved.
//

#import "CardView.h"
#import "Enums.h"

@interface SetCardView : CardView

@property (nonatomic) NSUInteger number;
@property (nonatomic) SCSymbolType symbol;
@property (nonatomic) SCShadingType shading;
@property (nonatomic) SCColorType color;

@end
