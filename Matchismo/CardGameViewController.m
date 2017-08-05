//
//  ViewController.m
//  Matchismo
//
//  Created by 郝泽 on 2017/3/23.
//  Copyright © 2017年 JesseHao. All rights reserved.
//

#import "CardGameViewController.h"
#import "CardView.h"
#import "CardGame.h"
#import "Deck.h"
#import "Card.h"
#import "Grid.h"

//principle: cardViewsToRemove <= boardView.subviews <= cardViews <= game.cards

@interface CardGameViewController ()
@property (strong, nonatomic, readwrite) Grid  *grid;
@property (strong, nonatomic) NSMutableArray<__kindof CardView *> *cardViewsToRemove;
@property (nonatomic, getter=isAllowInteract) BOOL allowInteract;
@property (nonatomic, getter=isPinched) BOOL pinched;
@end

@implementation CardGameViewController

#pragma mark - Properties

- (NSMutableArray<CardView *> *)cardViewsToRemove {
    if (!_cardViewsToRemove) {
        _cardViewsToRemove = [NSMutableArray array];
    }
    return _cardViewsToRemove;
}

- (CGRect)mainViewBounds {
    return self.view.bounds;
}

- (NSMutableArray<CardView *> *)cardViews {
    if (!_cardViews) {
        _cardViews = [NSMutableArray array];
    }
    return _cardViews;
}

- (BOOL)isNeedForAddToBoard {
    BOOL result = NO;
    self.grid.minimumNumberOfCells += self.game.cards.count - self.self.cardViews.count;
    for (NSUInteger i = self.cardViews.count, j = self.boardView.subviews.count; i < self.game.cards.count; i++, j++) {
        NSUInteger row = j / self.grid.columnCount;
        NSUInteger column = j % self.grid.columnCount;
        CardView *cardView = [self newCardViewWithFrame:[self.grid frameOfCellAtRow:row inColumn:column]];
        [cardView.tapGesture addTarget:self action:@selector(tapOnCard:)];
        cardView.center = [self centerBoundaryPositionOfView:cardView];
        [self.cardViews addObject:cardView];
        [self.boardView addSubview:cardView];
        result = YES;
    }
    return result;
}

- (BOOL)isNeedForRemoveFromBoard {
    BOOL result = NO;
    for (CardView *view in self.boardView.subviews) {
        if (!view.enabled) {
            [self.cardViewsToRemove addObject:view];
            result = YES;
        }
    }
    self.grid.minimumNumberOfCells -= self.cardViewsToRemove.count;
    return result;
}

- (Grid *)grid {
    if (!_grid) {
        _grid = [[Grid alloc] init];
        _grid.size = self.boardView.bounds.size;
        _grid.cellAspectRatio = CARD_VIEW_RATIO;
        _grid.minimumNumberOfCells = 0;
    }
    return _grid;
}

#pragma mark - Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self commonSetup];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self updateUI];
}

#pragma mark - Initialization
- (void) commonSetup {
    [self.boardView addGestureRecognizer:[[UIPinchGestureRecognizer alloc] initWithTarget:self
                                                                                   action:@selector(pinchOnBoard:)]];
    self.pinched = NO;
    self.allowInteract = YES;
    [self setup];
}

#pragma mark - Actions
- (IBAction)touchRestartButton:(UIButton *)sender {
    [self clear];
    [self updateUI];
}

#pragma mark Gestures
- (void)tapOnCard:(UITapGestureRecognizer *)gesture {
    if (!self.isAllowInteract) {
        return;
    }
    if (![gesture.view isKindOfClass:[CardView class]]) {
        NSLog(@"The Sender of Tap Gesture is NOT CardView");
        return;
    }
    if (self.isPinched) {
        [self updateBoard];
        return;
    }
    CardView *cardView = (CardView *)gesture.view;
    NSUInteger index = [self.cardViews indexOfObject:cardView];
    [self.game chooseCardAtIndex:index];
    [self updateUI];
}

- (void)pinchOnBoard:(UIPinchGestureRecognizer *)gesture {
    if (!self.isAllowInteract) {
        return;
    }
    if (gesture.state == UIGestureRecognizerStateEnded) {
        if (gesture.numberOfTouches == 2) {
            CGPoint a = [gesture locationOfTouch:0 inView:self.boardView];
            CGPoint b = [gesture locationOfTouch:1 inView:self.boardView];
            CGPoint center = CGPointMake((a.x + b.x) / 2, (a.y + b.y) / 2);
            [UIView animateWithDuration:0.5 animations:^{
                for (CardView *view in self.boardView.subviews) {
                    view.center = center;
                }
            } completion:^(BOOL finished) {
                self.pinched = YES;
            }];
        }
    }
}

#pragma mark Device Rotation
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    self.grid.size = self.boardView.bounds.size;
    [self updateBoard];
}

#pragma mark - Operations

- (void)updateUI {
    BOOL isNeedForUpdateBoard = NO;
    self.restartButton.hidden = !self.game.isStarted;
    isNeedForUpdateBoard |= self.isNeedForAddToBoard;
    [self mapping];
    isNeedForUpdateBoard |= self.isNeedForRemoveFromBoard;
    if (isNeedForUpdateBoard) {
        [self updateBoard];
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];
}

- (void)updateBoard {
    self.allowInteract = NO;
    [UIView animateWithDuration:0.3
                     animations:^{
                         for (int i = 0, j = 0; i < self.boardView.subviews.count; i++) {
                             CardView *view = self.boardView.subviews[i];
                             if ([self.cardViewsToRemove containsObject:view]) {
                                 view.center = [self centerBoundaryPositionOfView:view];
                                 continue;
                             }
                             NSUInteger row = j / self.grid.columnCount;
                             NSUInteger column = j % self.grid.columnCount;
                             CGRect frame = [self.grid frameOfCellAtRow:row inColumn:column];
                             view.frame = frame;
                             j++;
                         }
                     }
                     completion:^(BOOL finished) {
                         for (UIView *view in self.cardViewsToRemove) {
                             [view removeFromSuperview];
                         }
                         [self.cardViewsToRemove removeAllObjects];
                         self.pinched = NO;
                         self.allowInteract = YES;
                     }];
}

- (void)mapping {
    for (int i = 0; i<self.cardViews.count; i++) {
        CardView *cardView = [self.cardViews objectAtIndex:i];
        Card *card = [self.game cardAtIndex:i];
        [self mapCard:card toView:cardView];
    }
}

- (CGPoint)centerBoundaryPositionOfView:(UIView *)view {
    CGFloat y = view.center.y;
    CGFloat x = self.view.bounds.size.width + (view.frame.size.width / 2);
    return CGPointMake(x, y);
}

- (void)clear {
    for (CardView *view in self.boardView.subviews) {
        [view removeFromSuperview];
    }
    [self.cardViews removeAllObjects];
    self.game = nil;
    self.grid = nil;
}

#pragma mark - Abstract
- (CardView *)newCardViewWithFrame:(CGRect)frame { return [[CardView alloc] initWithFrame:frame]; }
- (void)setup { return; }
- (BOOL)mapCard:(Card *)card toView:(CardView *)view { return NO; }

@end
