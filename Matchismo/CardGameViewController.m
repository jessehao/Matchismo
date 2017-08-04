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

@interface CardGameViewController ()
@property (strong, nonatomic, readwrite) Grid  *grid;
@property (strong, nonatomic) NSMutableArray<__kindof CardView *> *cardViewsToRemove;
@end

@implementation CardGameViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self commonSetup];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self updateUI];
}

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
    }
    return _grid;
}

#pragma mark - Initialization
- (void) commonSetup {
    [self setupGrid];
    [self setup];
}

- (void)setupGrid {
    self.grid.size = self.boardView.bounds.size;
    self.grid.cellAspectRatio = CARD_VIEW_RATIO;
    self.grid.minimumNumberOfCells = 0;
}

#pragma mark - Actions
- (void)tapOnCard:(UITapGestureRecognizer *)gesture {
    if (![gesture.view isKindOfClass:[CardView class]]) {
        NSLog(@"The Sender of Tap Gesture is NOT CardView");
        return;
    }
    CardView *cardView = (CardView *)gesture.view;
    NSUInteger index = [self.cardViews indexOfObject:cardView];
    [self.game chooseCardAtIndex:index];
    [self updateUI];
}

#pragma mark StoryBoard
- (IBAction)touchRestartButton:(UIButton *)sender {
    self.game = nil;
    [self updateUI];
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

#pragma mark Abstract
- (CardView *)newCardViewWithFrame:(CGRect)frame { return [[CardView alloc] initWithFrame:frame]; }
- (void)setup { return; }
- (BOOL)mapCard:(Card *)card toView:(CardView *)view { return NO; }

@end
