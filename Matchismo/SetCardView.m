//
//  SetCardView.m
//  Matchismo
//
//  Created by 郝泽 on 2017/7/31.
//  Copyright © 2017年 JesseHao. All rights reserved.
//

#import "SetCardView.h"
#import "Grid.h"
#import "SymbolView.h"

@interface SetCardView ()
@property (strong, nonatomic) UIStackView *stackView;
@end

static const CGFloat STACK_SCALE_FACTOR = 0.75;

@implementation SetCardView
#pragma mark - Properties
@synthesize selected = _selected;
@synthesize enabled = _enabled;

- (UIStackView *)stackView {
    if (!_stackView) {
        CGRect scaledFrame = CGRectMake(0, 0, self.bounds.size.width * STACK_SCALE_FACTOR, self.bounds.size.height * STACK_SCALE_FACTOR);
        _stackView = [[UIStackView alloc] initWithFrame:scaledFrame];
        _stackView.center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
        _stackView.alignment = UIStackViewAlignmentFill;
        _stackView.distribution = UIStackViewDistributionFillEqually;
        _stackView.spacing = 5;
        _stackView.axis = UILayoutConstraintAxisVertical;
    }
    return _stackView;
}

- (void)setSymbol:(SCSymbolType)symbol {
    if (_symbol != symbol) {
        _symbol = symbol;
        [self updateSymbolViews];
    }
}

- (void)setColor:(SCColorType)color {
    if (_color != color) {
        _color = color;
        [self updateSymbolViews];
    }
}

- (void)setShading:(SCShadingType)shading {
    if (_shading != shading) {
        _shading = shading;
        [self updateSymbolViews];
    }
}

- (void)setNumber:(NSUInteger)number {
    if (_number != number) {
        _number = number;
        [self redrawSymbols];
    }
}

- (void)setSelected:(BOOL)selected {
    if (_selected != selected) {
        _selected = selected;
        [self setNeedsDisplay];
    }
}

- (void)setEnabled:(BOOL)enabled {
    if (_enabled != enabled) {
        if (enabled) {
            [self addGestureRecognizer:self.tapGesture];
        } else {
            [self removeGestureRecognizer:self.tapGesture];
        }
        _enabled = enabled;
    }
}

#pragma mark - Initialization
- (void)setup {
    [self addSubview:self.stackView];
    self.autoresizesSubviews = YES;
    self.stackView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
}

#pragma mark - Drawing
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    if (self.selected) {
        UIBezierPath *selectBounds = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                                cornerRadius:[self cornerRadius]];
        [selectBounds setLineWidth:10];
        [[UIColor blueColor] setStroke];
        [selectBounds stroke];
    }
}

#pragma mark - Operations
- (void)redrawSymbols {
    [self removeAllSymbolViews];
    for (int i = 0; i<self.number; i++) {
        SymbolView *sv = [[SymbolView alloc] init];
        UIView *container = [[UIView alloc] init];
        [container addSubview:sv];
        [self updateSpecificSymbolView:sv];
        [self.stackView addArrangedSubview:container];
    }
}

- (void)removeAllSymbolViews {
    for (UIView *view in self.stackView.arrangedSubviews) {
        [self.stackView removeArrangedSubview:view];
    }
}

- (void)updateSpecificSymbolView:(SymbolView *)symbol {
    symbol.symbol = self.symbol;
    symbol.shading = self.shading;
    symbol.color = self.color;
}

- (void)updateSymbolViews {
    for (SymbolView *symbol in self.subviews) {
        if ([symbol isKindOfClass:[SymbolView class]]) {
            [self updateSpecificSymbolView:symbol];
        }
    }
}


@end
