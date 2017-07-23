//
//  Card.h
//  Matchismo
//
//  Created by 郝泽 on 2017/3/22.
//  Copyright © 2017年 郝泽. All rights reserved.
//

@import Foundation;

@interface Card : NSObject

@property (strong, nonatomic) NSString* contents;

@property (nonatomic, getter=isChosen) BOOL chosen;
@property (nonatomic, getter=isMatched) BOOL matched;

- (int)match:(NSArray *)otherCards;

@end
