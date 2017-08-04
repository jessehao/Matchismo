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
@end

@implementation CardGameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self commonSetup];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.grid.minimumNumberOfCells += 3;
    [self updateBoard];
}

#pragma mark - Properties
- (CGRect)mainViewBounds {
    return self.view.bounds;
}

- (NSMutableArray<CardView *> *)cardViews {
    if (!_cardViews) {
        _cardViews = [NSMutableArray array];
    }
    return _cardViews;
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
    [self setupBoard];
    [self setup];
    [self updateUI];
}

- (void)setupGrid {
    self.grid.size = self.boardView.bounds.size;
    self.grid.cellAspectRatio = CARD_VIEW_RATIO;
    self.grid.minimumNumberOfCells = self.game.cards.count;
}

- (void)setupBoard {
    NSUInteger columnCount = self.grid.columnCount;
    for (int i = 0;i < self.game.cards.count; i++) {
        CardView *cardView = [self newCardViewWithFrame:[self.grid frameOfCellAtRow:i / columnCount
                                                                           inColumn:i % columnCount]];
        [cardView.tapGesture addTarget:self action:@selector(tapOnCard:)];
        [self.cardViews addObject:cardView];
        [self.boardView addSubview:cardView];
    }
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

#pragma mark - Animation 
-(void)moveView:(__kindof UIView *)view to:(CGPoint)point {
    
}

#pragma mark - Operations

- (void)updateUI{
    self.restartButton.hidden = !self.game.isStarted;
    for (int i = 0; i<self.cardViews.count; i++) {
        CardView *cardView = [self.cardViews objectAtIndex:i];
        Card *card = [self.game cardAtIndex:i];
        if([self mapCard:card toView:cardView]){
            self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];
        }
    }
}

- (void)updateBoard {
    [UIView animateWithDuration:0.3 animations:^{
        for (int i = 0; i < self.boardView.subviews.count; i++) {
            NSUInteger row = i / self.grid.columnCount;
            NSUInteger column = i % self.grid.columnCount;
            CGRect frame = [self.grid frameOfCellAtRow:row inColumn:column];
            self.boardView.subviews[i].frame = frame;
//            self.boardView.subviews[i].bounds = CGRectMake(0, 0, frame.size.width, frame.size.height);
        }
    }];
}

- (void)pushCardView:(CardView *)cardView atIndex:(NSUInteger)index{ // Testing
    [self updateBoard];
//    NSUInteger row = index / self.grid.columnCount;
//    NSUInteger column = index % self.grid.columnCount;
//    CGPoint end = [self.grid centerOfCellAtRow:row inColumn:column];
//    CGPoint start = CGPointMake(self.mainViewBounds.size.width + cardView.bounds.size.width / 2, end.y);
//    cardView.center = start;
//    [UIView animateWithDuration:0.4
//                     animations:^{
//                         cardView.center = end;
//                     }];
}

- (BOOL)popCardView:(CardView *)cardView {
    if (![self.boardView.subviews containsObject:cardView]) {
        NSLog(@"Specific Card View DOESN't EXIST");
        return false;
    }
    CGFloat x = self.mainViewBounds.size.width + (cardView.bounds.size.width / 2);
    [UIView animateWithDuration:0.4
                     animations:^{
                         cardView.center = CGPointMake(x, cardView.center.y);
                     } completion:^(BOOL finished) {
                         [cardView removeFromSuperview];
                     }];
    [self updateBoard];
    return true;
}

#pragma mark Abstract
- (CardView *)newCardViewWithFrame:(CGRect)frame { return [[CardView alloc] initWithFrame:frame]; }
- (void)setup { return; }
- (BOOL)mapCard:(Card *)card toView:(CardView *)view { return NO; }

@end
