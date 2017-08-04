//
//  PlayingCardView.m
//  SuperCard
//
//  Created by 郝泽 on 2017/7/25.
//  Copyright © 2017年 JH. All rights reserved.
//

#import "PlayingCardView.h"

@interface PlayingCardView()

@property (nonatomic) CGFloat faceCardScaleFactor;

@end

@implementation PlayingCardView

#pragma mark - Properties
@synthesize faceCardScaleFactor = _faceCardScaleFactor;
@synthesize enabled = _enabled;
#define DEFAULT_FACE_CARD_FACTOR 0.90

- (void)setFaceCardScaleFactor:(CGFloat)faceCardScaleFactor {
    _faceCardScaleFactor = faceCardScaleFactor;
    [self setNeedsDisplay];
}

- (CGFloat)faceCardScaleFactor {
    if(!_faceCardScaleFactor) _faceCardScaleFactor = DEFAULT_FACE_CARD_FACTOR;
    return _faceCardScaleFactor;
}

- (void)setRank:(NSUInteger)rank{
    _rank = rank;
    [self setNeedsDisplay];
}

- (void)setSuit:(NSString *)suit{
    _suit = suit;
    [self setNeedsDisplay];
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

#pragma mark - Drawing
- (CGFloat)cornerOffset { return [self cornerRadius] / 3.0; }

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    [self drawContent];
}


- (void)drawContent {
    if (self.selected) {
        [self drawCorners];
    } else {
        [[UIImage imageNamed:@"CardBack"] drawInRect:self.bounds];
    }
}

- (BOOL)drawFrontImage {
    UIImage *faceImage = [UIImage imageNamed:@"CardFront"];
    if (faceImage) {
        CGRect imageRect = CGRectInset(self.bounds,
                                       self.bounds.size.width * (1.0 - self.faceCardScaleFactor),
                                       self.bounds.size.height * (1.0 - self.faceCardScaleFactor));
        [faceImage drawInRect:imageRect];
        return YES;
    }
    return NO;
}

- (NSString *)rankAsString {
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"][self.rank];
}

- (void)drawCorners {
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentCenter;
    
    UIFont *cornerFont = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    cornerFont = [cornerFont fontWithSize:cornerFont.pointSize * [self cornerScaleFactor]];
    
    NSAttributedString *cornerText = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n%@", [self rankAsString], self.suit]
                                                                     attributes:@{ NSFontAttributeName : cornerFont,
                                                                                   NSParagraphStyleAttributeName : paragraphStyle }];
    CGRect textBounds;
    textBounds.origin = CGPointMake([self cornerOffset], [self cornerOffset]);
    textBounds.size = [cornerText size];
    [cornerText drawInRect:textBounds];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, self.bounds.size.width, self.bounds.size.height);
    CGContextRotateCTM(context, M_PI);
    
    [cornerText drawInRect:textBounds];
}


@end
