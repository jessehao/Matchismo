//
//  CardView.h
//  Matchismo
//
//  Created by 郝泽 on 2017/7/31.
//  Copyright © 2017年 JesseHao. All rights reserved.
//

#import <UIKit/UIKit.h>

static const CGFloat CARD_VIEW_CORNER_FONT_STANDARD_HEIGHT = 180.0;
static const CGFloat CARD_VIEW_CORNER_RADIUS = 12.0;
static const CGFloat CARD_VIEW_RATIO = 5.0 / 8.0;

@interface CardView : UIView

@property (strong, nonatomic, readonly) UITapGestureRecognizer *tapGesture;
@property (nonatomic, getter=isSelected) BOOL selected;
@property (nonatomic, getter=isEnabled) BOOL enabled;

- (void)setup;
- (CGFloat)cornerScaleFactor;
- (CGFloat)cornerRadius;
- (void)drawBounds;
@end
