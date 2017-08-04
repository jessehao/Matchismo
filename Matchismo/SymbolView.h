//
//  SymbolView.h
//  Matchismo
//
//  Created by 郝泽 on 2017/7/31.
//  Copyright © 2017年 JesseHao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Enums.h"

@interface SymbolView : UIView
@property (nonatomic) SCSymbolType symbol;
@property (nonatomic) SCColorType color;
@property (nonatomic) SCShadingType shading;

@property (strong, nonatomic, readonly) UIBezierPath *path;
@property (weak, nonatomic, readonly) UIView *container;
@end
