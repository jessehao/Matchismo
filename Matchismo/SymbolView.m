//
//  SymbolView.m
//  Matchismo
//
//  Created by 郝泽 on 2017/7/31.
//  Copyright © 2017年 JesseHao. All rights reserved.
//

#import "SymbolView.h"
@interface SymbolView()
@property (strong, nonatomic) UIBezierPath *path;
@property (strong, nonatomic) UIBezierPath *stripe;
@end

@implementation SymbolView

static NSString *const KEY_BOUNDS = @"bounds";
static const CGFloat SYMBOL_SCALE_FACTOR = 0.8;
static const CGFloat STRIPE_INTERVAL = 4;

- (void)willMoveToSuperview:(UIView *)newSuperview {
    if (self.superview) {
        [self.superview removeObserver:self forKeyPath:KEY_BOUNDS];
    }
}

- (void)didMoveToSuperview {
    [self.superview addObserver:self forKeyPath:KEY_BOUNDS options:NSKeyValueObservingOptionNew context:nil];
    [self superViewBoundsChanged];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setup];
}

#pragma mark - Properties

- (void)setSymbol:(SCSymbolType)symbol {
    if (_symbol != symbol) {
        _symbol = symbol;
        self.path = nil;
    }
}

- (void)setColor:(SCColorType)color {
    if (_color != color) {
        _color = color;
        [self setNeedsDisplay];
    }
}

- (void)setShading:(SCShadingType)shading {
    if (_shading != shading) {
        _shading = shading;
        [self setNeedsDisplay];
    }
}

- (UIBezierPath *)path {
    if (!_path) {
        switch (self.symbol) {
            case SCSymbolCircle:
                _path = [UIBezierPath bezierPathWithOvalInRect:self.bounds];
                break;
            case SCSymbolSquare:
                _path = [UIBezierPath bezierPathWithRect:self.bounds];
                break;
            case SCSymbolTriangle:
                _path = self.trianglePath;
                break;
            default:
                return nil;
        }
        [_path addClip];
    }
    return _path;
}

- (UIBezierPath *)stripe {
    if (self.shading != SCShadingStriped) {
        _stripe = nil;
    }else if (!_stripe) {
        _stripe = [[UIBezierPath alloc] init];
        for (CGFloat y = STRIPE_INTERVAL; y <= self.bounds.size.height; y += STRIPE_INTERVAL) {
            [_stripe moveToPoint:CGPointMake(0, y)];
            [_stripe addLineToPoint:CGPointMake(self.bounds.size.width, y)];
        }
    }
    return _stripe;
}

- (UIBezierPath *)trianglePath {
    UIBezierPath *triangle = [[UIBezierPath alloc] init];
    [triangle moveToPoint:CGPointMake(self.bounds.size.width / 2, 0)];
    [triangle addLineToPoint:CGPointMake(self.bounds.size.width, self.bounds.size.height)];
    [triangle addLineToPoint:CGPointMake(0, self.bounds.size.height)];
    [triangle closePath];
    return triangle;
}

- (UIColor *)uicolor {
    switch (self.color) {
        case SCColorRed:
            return [UIColor redColor];
        case SCColorGreen:
            return [UIColor greenColor];
        case SCColorPurple:
            return [UIColor purpleColor];
        default:
            return nil;
    }
}

- (UIColor *)fillColor {
    switch (self.shading) {
        case SCShadingOpen:
            return nil;
        case SCShadingSolid:
            return self.uicolor;
        case SCShadingStriped:
            return nil;
        default:
            return nil;
    }
}

- (UIColor *)strokeColor {
    return self.uicolor;
}

#pragma mark - Initialization
- (void)setup {
    
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

#pragma mark - Drawing
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    [self drawFrame];
    [self.fillColor setFill];
    [self.strokeColor setStroke];
    [self.path fill];
    [self.path stroke];
    [self.stripe stroke];
}

- (void)drawFrame {
    [[UIColor whiteColor] setFill];
    UIRectFill(self.bounds);
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:KEY_BOUNDS]) {
        [self superViewBoundsChanged];
    }
}

#pragma mark - Operations
- (void)superViewBoundsChanged {
    CGSize containerSize = self.superview.bounds.size;
    CGFloat length = containerSize.width <= containerSize.height ? containerSize.width : containerSize.height;
    length *= SYMBOL_SCALE_FACTOR;
    CGRect newBounds = CGRectMake(0, 0, length, length);
    self.bounds = newBounds;
    self.center = CGPointMake(self.superview.bounds.size.width / 2, self.superview.bounds.size.height / 2);
}
@end
