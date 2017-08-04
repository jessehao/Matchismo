//
//  CardView.m
//  Matchismo
//
//  Created by 郝泽 on 2017/7/31.
//  Copyright © 2017年 JesseHao. All rights reserved.
//

#import "CardView.h"

@implementation CardView

#pragma mark - Properties
-(UITapGestureRecognizer *)tapGesture {
    if (!_tapGesture) {
        _tapGesture = [[UITapGestureRecognizer alloc] init];
    }
    return _tapGesture;
}

- (void)setSelected:(BOOL)selected {
    if (_selected != selected) {
        _selected = selected;
        [UIView transitionWithView:self
                          duration:0.4
                           options:UIViewAnimationOptionTransitionFlipFromLeft
                        animations:^{
                            [self setNeedsDisplay];
                        }
                        completion:nil];
        
    }
}

#pragma mark - Initialization
- (void)commonSetup {
    self.backgroundColor = nil;
    self.opaque = NO;
    self.contentMode = UIViewContentModeRedraw;
    [self setup];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self commonSetup];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonSetup];
    }
    return self;
}

#pragma mark - Drawing
- (void)drawRect:(CGRect)rect {
    [self drawBounds];
}

- (CGFloat)cornerScaleFactor { return self.bounds.size.height / CARD_VIEW_CORNER_FONT_STANDARD_HEIGHT; }
- (CGFloat)cornerRadius { return CARD_VIEW_CORNER_RADIUS * [self cornerScaleFactor]; }

- (void)drawBounds {
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                           cornerRadius:[self cornerRadius]];
    [roundedRect addClip];
    [[UIColor whiteColor] setFill];
    UIRectFill(self.bounds);
    [[UIColor blackColor] setStroke];
    [roundedRect stroke];
}

#pragma mark - Abstract
- (void)setup { return; }

#pragma mark - Class

@end
