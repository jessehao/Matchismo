//
//  PlayingCardView.h
//  SuperCard
//
//  Created by 郝泽 on 2017/7/25.
//  Copyright © 2017年 JH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardView.h"

@interface PlayingCardView : CardView

@property (nonatomic) NSUInteger rank;
@property (strong, nonatomic) NSString *suit;

@end
